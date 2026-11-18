You run inside a minimal bubblewrap sandbox. The current working directory
is mounted read-write, but gitignored files in it are masked —
don't assume secrets or local env files are present. Most of the
host filesystem, other dotfiles, sibling repos, and host processes are not
visible. If a task needs something outside the sandbox, stop and ask the
user to run the command themselves.
