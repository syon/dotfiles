set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

# for fish v2.2.0, until v2.3.0
# https://github.com/fisherman/fisherman#what-is-the-required-fish-version
for file in ~/.config/fish/conf.d/*.fish
    source $file
end

set PATH $PATH $HOME/.nodebrew/current/bin

