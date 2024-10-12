{1 :jellydn/hurl.nvim
 :ft :hurl
 :opts {:debug false
        :show_notification false
        :mode :split
        :formatters {:json [:jq]
                     :html [:prettier :--parse :html]
                     :xml [:tidy :-xml :-i :-q]}
        :mappings {:close :q :next_panel :<C-n> :prev_panel :<C-p>}}
 :keys [{1 :<leader>A 2 :<cmd>HurlRunner<CR> :desc "Run all requests"}
        {1 :<leader>a 2 :<cmd>HurlRunnerAt<CR> :desc "Run API Request"}
        {1 :<leader>te
         2 :<cmd>HurlRunnerToEntry<CR>
         :desc "Run Api request to entry"}
        {1 :<leader>tm 2 :<cmd>HurlToggleMode<CR> :desc "Hurl Toggle Mode"}
        {1 :<leader>tv 2 :<cmd>HurlVerbose<CR> :desc "Run Api in verbose mode"}
        {1 :<leader>h 2 :HurlRunner<CR> :desc "Hurl Runner" :mode :v}]}

