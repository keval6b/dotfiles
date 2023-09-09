function dotsetup
    pushd ~/
    rm -rd .dotfiles/hooks
    ln -s ~/.dothooks .dotfiles/hooks
    popd
end