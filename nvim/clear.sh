#!/bin/bash
echo "🧹 Очистка Neovim..."

rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.config/nvim/lazy-lock.json

echo "✅ Neovim очищен!"
