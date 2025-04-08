#!/bin/bash

source "$(dirname "$0")/../.env"
BACKUP_FILE=$1

if [ ! -f "$BACKUP_FILE" ]; then
  echo "❌ File backup không tồn tại: $BACKUP_FILE"
  exit 1
fi

echo "⚠️  Khôi phục database '${DATABASE_NAME}' từ file: $BACKUP_FILE"
read -p "Bạn chắc chắn muốn tiếp tục? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "❌ Hủy thao tác."
  exit 0
fi

cat "$BACKUP_FILE" | docker exec -i $CONTAINER_NAME \
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_NAME

if [ $? -eq 0 ]; then
  echo "✅ Khôi phục thành công!"
else
  echo "❌ Khôi phục thất bại!"
fi
