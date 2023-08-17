function dotgit --wraps='git --git-dir=~/.dotfiles/ --work-tree=~/' --wraps='git --git-dir=/home/keval/.dotfiles/ --work-tree=/home/keval/' --wraps='git --git-dir=(/home/keval)/.dotfiles/ --work-tree=(/home/keval)/' --wraps='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/' --description 'alias dotgit git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/'
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/ $argv
        
end
