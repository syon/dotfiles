# direnv
eval (direnv hook fish)

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH

# anyenv - ndenv
set -x NDENV_ROOT $HOME/.anyenv/envs/ndenv
set -x PATH $HOME/.anyenv/envs/ndenv/bin $PATH
set -x PATH $NDENV_ROOT/shims $PATH

# pyenv
set -x PYENV_ROOT "$HOME/.anyenv/envs/pyenv"
set -x PATH $PATH "$HOME/.anyenv/envs/pyenv/bin"

# fzf
set FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

# ls when enter
function done_enter --on-event fish_postexec
    if test -z "$argv"
        ls
        if git rev-parse --is-inside-work-tree ^/dev/null
            echo (set_color yellow)"--- git status ---"(set_color normal)
            git status -sb
        end
    end
end
