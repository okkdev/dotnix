(local dap (require :dap))

(set dap.adapters.php {:type :executable :command :php-debug-adapter :args []})

(set dap.configurations.php
     [{:type :php :request :launch :port 9003 :name "Listen for Xdebug"}])

(local map vim.keymap.set)

(map :n :<leader>db dap.toggle_breakpoint {:desc "toggle breakpoint"})
(map :n :<leader>d<cr> dap.continue {:desc :continue})
(map :n :<leader>dl dap.step_over {:desc "step over"})
(map :n :<leader>dj dap.step_into {:desc "step into"})
(map :n :<leader>dk dap.step_out {:desc "step out"})
