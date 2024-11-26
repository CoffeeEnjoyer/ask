#!/bin/bash

BACKUP_DIR="/home/ask/projekt_ask/tygodniowy_backup"
SOURCE_DIR="/home/ask/projekt_ask/zrodla"
REPO1_DIR="/home/ask/projekt_ask/repo_git_1"
REPO2_DIR="/home/ask/projekt_ask/repo_git_2"
TMP_RESTORE_DIR="/tmp/restore_tmp"

#echo "Przywracanie plikow zrodlowych..."
LATEST_SOURCE_BACKUP=$(ls -t "$BACKUP_DIR" | grep "zrodla_" | head -n 1)

if [ -z "$LATEST_SOURCE_BACKUP" ]; then
    echo "Blad"
    exit 1
fi

mkdir -p "$TMP_RESTORE_DIR"
tar -xzf "$BACKUP_DIR/$LATEST_SOURCE_BACKUP" -C "$TMP_RESTORE_DIR"

rsync -a --delete "$TMP_RESTORE_DIR/" "$SOURCE_DIR"
if [ $? -ne 0 ]; then
    echo "Blad"
    exit 1
fi

rm -rf "$TMP_RESTORE_DIR"

#echo "Przywracanie repozytorium repo_git_1..."
LATEST_REPO1_BACKUP=$(ls -t "$BACKUP_DIR" | grep "repo_git_1_backup_" | head -n 1)

if [ -z "$LATEST_REPO1_BACKUP" ]; then
    echo "Blad"
    exit 1
fi

rm -rf "$REPO1_DIR"
mkdir -p "$REPO1_DIR"
tar -xzf "$BACKUP_DIR/$LATEST_REPO1_BACKUP" -C "$REPO1_DIR"
if [ $? -ne 0 ]; then
    echo "Blad"
    exit 1
fi

#echo "Przywracanie repozytorium repo_git_2..."
LATEST_REPO2_BACKUP=$(ls -t "$BACKUP_DIR" | grep "repo_git_2_backup_" | head -n 1)

if [ -z "$LATEST_REPO2_BACKUP" ]; then
    echo "Blad"
    exit 1
fi

rm -rf "$REPO2_DIR"
mkdir -p "$REPO2_DIR"
tar -xzf "$BACKUP_DIR/$LATEST_REPO2_BACKUP" -C "$REPO2_DIR"
if [ $? -ne 0 ]; then
    echo "Blad"
    exit 1
fi

echo "Przywracanie danych zakonczone."

