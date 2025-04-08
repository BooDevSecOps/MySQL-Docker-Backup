#!/bin/bash

source "$(dirname "$0")/../.env"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="${BACKUP_DIR}/backup-${DATABASE_NAME}-${DATE}.sql"

mkdir -p "${BACKUP_DIR}"

echo "🔄 Backup database '${DATABASE_NAME}'..."
docker exec -i ${CONTAINER_NAME} \
  mysqldump -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${DATABASE_NAME} \
  > "${BACKUP_FILE}"

if [ $? -eq 0 ]; then
  echo "✅ Backup thành công: ${BACKUP_FILE}"
  # Xóa file cũ hơn 30 ngày
  find "${BACKUP_DIR}" -name "*.sql" -type f -mtime +30 -exec rm {} \;
else
  echo "❌ Backup thất bại!"
  ./scripts/notify.sh "Backup MySQL thất bại lúc $(date)"
  exit 1
fi

# Upload lên Google Drive
rclone copy "${BACKUP_FILE}" ${RCLONE_REMOTE}
if [ $? -ne 0 ]; then
  ./scripts/notify.sh "Upload backup lên cloud thất bại lúc $(date)"
fi
