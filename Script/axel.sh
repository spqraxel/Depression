#!/bin/bash
# Script de Axel le 03/10/2025


# Fichier log
LOGFILE="disk_usage.log"
DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo "=== Vérification de l'espace disque ($DATE) ===" >> "$LOGFILE"

# Parcours des disques avec df
df -h --output=source,pcent | tail -n +2 | while read disk used; do
    # Retire le % du chiffre
    usage=${used%%%}

    if [ "$usage" -ge 95 ]; then
        echo "[ERROR] $DATE - Disque $disk utilisé à $usage%" >> "$LOGFILE"
    elif [ "$usage" -ge 90 ]; then
        echo "[WARNING] $DATE - Disque $disk utilisé à $usage%" >> "$LOGFILE"
    elif [ "$usage" -ge 80 ]; then
        echo "[LOG] $DATE - Disque $disk utilisé à $usage%" >> "$LOGFILE"
    fi
done
