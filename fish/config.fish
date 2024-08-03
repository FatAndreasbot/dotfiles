export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=gnome
fish_add_path $HOME/.local/bin
fish_add_path $(go env GOPATH)/bin
set fish_prompt_pwd_dir_length 3
set -x -U GOPATH $HOME/.go


if status is-interactive
   # if test $TERM = "xterm-kitty"
   starship init fish | source
   # end
   # alias ra='ranger --choosedir=$HOME/.rangerdir; cd $(cat $HOME/.rangerdir)'
   alias ra='ranger --choosedir=$HOME/.rangerdir; set LASTDIR $(cat $HOME/.rangerdir); cd "$LASTDIR"'
   alias nv "nvim"
   alias timer "termdown"
end
