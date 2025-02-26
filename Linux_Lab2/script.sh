#!/bin/bash

# Set MySQL user and password
MYSQL_USER="root"  # Replace with your MySQL username
MYSQL_PASS="randa"  # Replace with your MySQL password
MYSQL_DB="my_database"  # Replace with your MySQL database name

# Set backup directory
BACKUP_DIR="/home/randa/mysql_Backups"

# Replace with your backup directory
DATE=$(date +\%F)  # Current date in YYYY-MM-DD format
BACKUP_FILE="${BACKUP_DIR}/${MYSQL_DB}_backup_${DATE}.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run the mysqldump command to backup the database
mysqldump -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB > $BACKUP_FILE

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup of database $MYSQL_DB completed successfully at $(date)" >> ${BACKUP_DIR}/backup.log
else
  echo "Backup of database $MYSQL_DB failed at $(date)" >> ${BACKUP_DIR}/backup.log
fi
