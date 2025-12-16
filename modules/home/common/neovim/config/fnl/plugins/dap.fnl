(local dap (require :dap))
(local view (require :dap-view))

(set dap.adapters.php {:type :executable :command :php-debug-adapter :args []})

; PHP Debug configuration for Xdebug
; Note: pathMappings is project-specific - adjust for your environment
(set dap.configurations.php
     [{:type :php
       :request :launch
       :port 9003
       :name "Listen for Xdebug"
       :pathMappings {:/var/www/mycyon "${workspaceFolder}"
                      :/var/www/froox "${workspaceFolder}"}}])

(local map vim.keymap.set)

(map :n :<leader>db dap.toggle_breakpoint {:desc "toggle breakpoint"})
(map :n :<leader>dc dap.continue {:desc :continue})
(map :n :<leader>dl dap.step_over {:desc "step over"})
(map :n :<leader>dj dap.step_into {:desc "step into"})
(map :n :<leader>dk dap.step_out {:desc "step out"})
(map :n :<leader>dh dap.run_to_cursor {:desc "run to cursor"})
(map :n :<leader>dv view.toggle {:desc "toggle view"})

(set dap.listeners.after.event_initialized.virtualtext
     (fn []
       (let [vt (require :nvim-dap-virtual-text)] (vt.setup {}))))

(set dap.listeners.after.event_initialized.dapview view.open)
(set dap.listeners.after.event_terminated.dapview view.close)
