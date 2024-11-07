#!/bin/bash

# ホームディレクトリにシンボリックリンクを作成
ln -sf ~/workspace/dotfiles/bash/.bashrc ~/.bashrc
ln -sf ~/workspace/dotfiles/bash/.bash_profile ~/.bash_profile
ln -sf ~/workspace/dotfiles/bash/.bash_aliases ~/.bash_aliases

# Gitの設定をホームディレクトリにリンク
ln -sf ~/workspace/dotfiles/git/.gitconfig ~/.gitconfig

# Homebrewがインストールされているか確認し、インストール
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Please install Homebrew first."
else
  # Brewfileを使ってパッケージをインストール
  if [ -f ~/workspace/dotfiles/Brewfile ]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file=~/workspace/dotfiles/Brewfile
  else
    echo "Brewfile not found. Skipping Homebrew package installation."
  fi
fi

# 必要に応じて、依存するパッケージのインストールなどを行う
echo "Dotfiles have been linked! Please reload your shell."
