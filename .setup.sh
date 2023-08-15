#!/bin/sh

pushd ~/
git --git-dir=$HOME/.dotfiles/ --worktree=$HOME/ checkout master
ln -sf ~/.dothooks .dotfiles/hooks
popd
