#!/bin/bash

DOTDIR="$HOME/arch-dots"

echo "🔄 Syncing dotfiles..."

# ─── .config folders ─────────────────────────────────────────────────────────
dirs=(
  kitty
  hypr
  waybar
)

for dir in "${dirs[@]}"; do
  src="$HOME/.config/$dir"
  if [ -d "$src" ]; then
    mkdir -p "$DOTDIR/$dir"
    cp -r "$src"/. "$DOTDIR/$dir/"
    echo "✔ Copied .config/$dir"
  else
    echo "✘ Skipped $dir (not found)"
  fi
done

# ─── .zshrc ──────────────────────────────────────────────────────────────────
if [ -f "$HOME/.zshrc" ]; then
  cp "$HOME/.zshrc" "$DOTDIR/.zshrc"
  echo "✔ Copied .zshrc"
else
  echo "✘ Skipped .zshrc (not found)"
fi

# ─── Push to GitHub ──────────────────────────────────────────────────────────
cd "$DOTDIR"
git add .
git commit -m "Update dotfiles $(date '+%Y-%m-%d %H:%M')"
git push origin main

echo "✅ Done!"
