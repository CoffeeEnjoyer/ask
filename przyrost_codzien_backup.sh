#!/bin/bash

SOURCE_DIR="/home/ask/projekt_ask/zrodla"
REPO1_URL="git@github.com:Szajszen/ask_repo1.git" # zdalne repozytorium Git
REPO2_DIR="/home/ask/projekt_ask/repo_git_2" # lokalne repozytorium Git
BACKUP_DIR="/home/ask/projekt_ask/kopia_codzienna"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p "$BACKUP_DIR"

# Kopia przyrostowa pliki
rsync -av --delete --link-dest="$BACKUP_DIR/last" "$SOURCE_DIR/" "$BACKUP_DIR/current"

# Backup lokalnego git
rsync -av --delete --link-dest="$BACKUP_DIR/last_repo_git_2" "$REPO2_DIR/" "$BACKUP_DIR/current_repo_git_2"

# Backup zdalnego git
if [ ! -d "$BACKUP_DIR/repo_git_1" ]; then
    git clone --mirror "$REPO1_URL" "$BACKUP_DIR/repo_git_1"
else
    git -C "$BACKUP_DIR/repo_git_1" fetch --all
fi

tar -czf "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" -C "$BACKUP_DIR" "current" "current_repo_git_2" "repo_git_1"

rm -rf "$BACKUP_DIR/last"
mv "$BACKUP_DIR/current" "$BACKUP_DIR/last"

rm -rf "$BACKUP_DIR/last_repo_git_2"
mv "$BACKUP_DIR/current_repo_git_2" "$BACKUP_DIR/last_repo_git_2"

echo "Kopia przyrostowa zakończona."


