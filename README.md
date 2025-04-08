# 🛡️ MySQL Docker Backup & Restore

Tự động backup MySQL từ container Docker, upload lên Google Drive, gửi email nếu lỗi.

## 🧩 Yêu cầu

- Docker đã cài sẵn
- `mailx` để gửi email
- `rclone` để upload file lên Google Drive

## 🚀 Cách dùng

### 1. Cấu hình
Tạo file `.env` từ mẫu:

```bash
cp .env.example .env
```

### 2. Backup
```bash
./scripts/backup-mysql.sh
```

### 3. Restore
```bash
./scripts/restore-mysql.sh backups/backup-<tên_database>-YYYY-MM-DD_HH-MM-SS.sql
```

### 4. Tự động hoá (Crontab)
Backup mỗi ngày lúc 2h sáng:

```bash
0 2 * * * /path/to/scripts/backup-mysql.sh >> /path/to/backup.log 2>&1
```

## ☁️ Cấu hình Google Drive (rclone)

```bash
rclone config
```

Chọn remote là `drive`, và trỏ đúng thư mục như cấu hình trong `.env`
