-- pomodoro wrapper that is going to allow us to "focus" things ourselves
-- assumes pomodoro CLI is installed and available in the PATH
-- also assumes the cli is configured however it is desired so that defaults simply work

local M = {}

-- declaring the helpers in a forward way so that they can be used in the main functions without declaring them early
local notify, say, run

--- Watch the status of the current pomodoro session and notify on changes
-- leverages the watching variable above to keep track of private state and store the timer in memory
-- @function watch
M.watch = function()
  if watching.timer then
    return
  end -- already watching
  watching.timer = vim.uv.new_timer()
  watching.timer:start(0, 5000, function() -- uv timers run off the main loop, like vim.system callbacks
    M.status({
      on_ok = function(text)
        local state = text == "" and "none" or text:find("❗") and "overdue" or "running"
        if state ~= watching.last then
          notify(text ~= "" and text or "Pomodoro ended")
          watching.last = state
        end
        if state == "none" then
          M.unwatch()
        end
      end,
    })
  end)
end

--- Start a new pomodoro session with the given description and tags
-- @function start
-- @param desc string: description of the pomodoro session
-- @param tags table: list of tags for the pomodoro session
M.start = function(desc, tags)
  local args = { "start", desc }
  for _, tag in ipairs(tags or {}) do
    table.insert(args, "--tags")
    table.insert(args, tag)
  end

  run(args, say("Pomodoro started: " .. desc))
end

--- Cancel the current pomodoro session
-- @function cancel
M.cancel = function()
  run({ "cancel" }, say("Pomodoro canceled"))
end

--- Finish the current pomodoro session
--- @function finish
M.finish = function()
  run({ "finish" }, say("Pomodoro finished"))
end

--- Get the status of the current pomodoro session
--- @function status
--- @param opts table: options for the status command (currently unused)
M.status = function(opts)
  local opts = opts or {}
  run({ "status" }, function(obj)
    local out = vim.trim(obj.stdout)
    if opts.on_ok then
      opts.on_ok(out)
    else
      notify(out ~= "" and out or "No pomodoro running", nil, opts.id) -- 3b. default: notify
    end
  end)
end

local watching = { timer = nil, last = nil } -- private module state, like `run`

M.unwatch = function()
  if watching.timer then
    watching.timer:stop()
    watching.timer:close()
    watching.timer = nil
    watching.last = nil
  end
end

--- Run a command in a safe manner while also giving pluggable forms of feedback
-- important for threading through the commands including the status which has to be able to alter the output
-- @function run
-- @param args table: list of arguments to pass to the pomodoro command
-- @param on_ok function: callback to call on success
-- @param on_fail function: callback to call on failure (default: notify with error)
function run(args, on_ok, on_fail)
  on_fail = on_fail
    or function(obj)
      notify("pomodoro " .. args[1] .. " failed: " .. obj.stderr, vim.log.levels.ERROR)
    end
  local cmd = vim.list_extend({ "pomodoro" }, args)
  vim.system(cmd, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        on_ok(obj)
      else
        on_fail(obj)
      end
    end)
  end)
end

--- Turn a fixed message into a success callback for run
-- @function say
-- @param msg string: the message to notify the user of
function say(msg)
  return function()
    notify(msg)
  end
end

--- Notify the user of a message with a given log level
-- @function notify
-- @param msg string: the message to notify the user of
-- @param level number: the log level (default: INFO)
-- @param id number: the notification ID (optional)
function notify(msg, level, id)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Pomodoro", id = id })
end

-- rich comment: meant to be evaluated in a REPL, not in the file itself
if false then
  local p = dofile(vim.fn.expand("%:p"))
  p.start("repl test", { "y" })

  local p = dofile(vim.fn.expand("%:p"))
  p.status()

  local p = dofile(vim.fn.expand("%:p"))
  p.watch()

  local p = dofile(vim.fn.expand("%:p"))
  p.cancel()

  local p = dofile(vim.fn.expand("%:p"))
  p.finish()
end

return M
