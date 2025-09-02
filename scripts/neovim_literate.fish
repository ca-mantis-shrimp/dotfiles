#!/usr/bin/env fish
function validate_arguments
 if test (count $argv) -ne 1
  echo "Usage: (basename (status --current-filename)) <path-to-norg-file>"
  echo "Example: (basename (status --current-filename)) literate_config/neovim/plugins/new_plugin.norg"
  return 1
 end

 set norg_file $argv[1]

 if not test -f "$norg_file"
  echo "Error: File not found: $norg_file"
  return 1
 end

 if not string match -q "literate_config/neovim/*" -- "$norg_file"
  echo "Error: The .norg file must be located inside 'literate_config/neovim/'"
  return 1
 end

 echo "$norg_file"
end

function derive_paths
 set norg_file $argv[1]

 echo "==> Deriving paths..." >&2

 set rel_norg_path (realpath --relative-to="literate_config/neovim" "$norg_file")
 set rel_dir (dirname "$rel_norg_path")
 set filename (basename "$norg_file" .norg)

 set fnl_dir ".chezmoitemplates/Neovim/$rel_dir"
 set fnl_file "$fnl_dir/$filename.fnl"
 set lua_file "$fnl_dir/$filename.lua"
 set template_path "Neovim/$rel_dir/$filename.lua"

 if test "$rel_dir" = "."
  set fnl_dir ".chezmoitemplates/Neovim"
  set fnl_file "$fnl_dir/$filename.fnl"
  set lua_file "$fnl_dir/$filename.lua"
  set template_path "Neovim/$filename.lua"
 end

 echo "    -> Derived paths for '$filename'" >&2

 # Return all paths as a space-separated string
 echo "$rel_dir" "$filename" "$fnl_file" "$lua_file" "$template_path"
end

function tangle_and_compile
 set norg_file $argv[1]
 set fnl_file $argv[2]
 set lua_file $argv[3]

 echo "==> Tangling $norg_file..."
 nvim "$norg_file" -c "Neorg tangle current-file" -c "q"
 echo "    -> Tangled to $fnl_file"

 echo "==> Compiling $fnl_file to Lua..."
 nvim "$fnl_file" -c "w" -c "q"
 nvim "$lua_file" -c "w" -c "q"
 echo "    -> Compiled to $lua_file"
end

function create_templates
 set rel_dir $argv[1]
 set filename $argv[2]
 set template_path $argv[3]

 echo "==> Creating chezmoi template files..."
 set template_content "{{- template \"$template_path\" -}}"

 set dest_base1 "dot_config/remove_nvim/lua"
 set dest_base2 "AppData/Local/remove_nvim/lua"
 set dest_dir1 "$dest_base1/$rel_dir"
 set dest_dir2 "$dest_base2/$rel_dir"

 if test "$rel_dir" = "."
  set dest_dir1 "$dest_base1"
  set dest_dir2 "$dest_base2"
 end

 mkdir -p "$dest_dir1" "$dest_dir2"

 set dest_file1 "$dest_dir1/$filename.lua.tmpl"
 set dest_file2 "$dest_dir2/$filename.lua.tmpl"

 echo "$template_content" > "$dest_file1"
 echo "    -> Created $dest_file1"
 echo "$template_content" > "$dest_file2"
 echo "    -> Created $dest_file2"
end

function main
 set norg_file (validate_arguments $argv)
 or return 1

 set path_info (derive_paths "$norg_file")
 set rel_dir (echo $path_info | cut -d' ' -f1)
 set filename (echo $path_info | cut -d' ' -f2)
 set fnl_file (echo $path_info | cut -d' ' -f3)
 set lua_file (echo $path_info | cut -d' ' -f4)
 set template_path (echo $path_info | cut -d' ' -f5)

 tangle_and_compile "$norg_file" "$fnl_file" "$lua_file"

 create_templates "$rel_dir" "$filename" "$template_path"

 echo "==> Done!"
 echo "Review the generated files, then run 'chezmoi apply'."
end

main $argv
