(local minuet (require :minuet))

(minuet.setup {:provider :openai_fim_compatible
               :n_completions 1
               :context_window 512
               :provider_options {:openai_fim_compatible {:name :Ollama
                                                          :model "qwen2.5-coder:3b"
                                                          :end_point "http://localhost:11434/v1/completions"
                                                          :api_key (fn []
                                                                     :dummy)
                                                          :optional {:max_tokens 56
                                                                     :top_p 0.9}}}})
