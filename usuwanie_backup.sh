#!/bin/bash

FULL_BACKUP_DIR="/home/oem/projekt_ask/tygodniowy_backup"
INCREMENTAL_BACKUP_DIR="/home/oem/projekt_ask/kopia_codzienna"

echo "Usuwanie pelnych kopii zapasowych starszych niz 30 dni..."
find "$FULL_BACKUP_DIR" -mindepth 1 -mtime +30 -exec rm -rf {} \;

echo "Usuwanie kopii przyrostowych starszych niz 30 dni..."
find "$INCREMENTAL_BACKUP_DIR" -mindepth 1 -mtime +30 -exec rm -rf {} \;

echo "Usunieto wszystkie kopie starsze niz 30 dni."

