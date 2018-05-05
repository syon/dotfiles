# yarn
#set -x PATH (yarn global bin) $PATH

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH

# anyenv - ndenv
set -x NDENV_ROOT $HOME/.anyenv/envs/ndenv
set -x PATH $HOME/.anyenv/envs/ndenv/bin $PATH
set -x PATH $NDENV_ROOT/shims $PATH

# peco
set fish_plugins theme peco

# Bind for peco history to Ctrl+r
function fish_user_key_bindings
    bind \cr peco_select_history
end

# Enter ls
function done_enter --on-event fish_postexec
    if test -z "$argv"
        ls
        if git rev-parse --is-inside-work-tree ^/dev/null
            echo (set_color yellow)"--- git status ---"(set_color normal)
            git status -sb
        end
    end
end
