# 🚀 GIT FLOW — Quy trình làm việc nhóm

## 🧭 1. Cấu trúc nhánh chính

```
main        → nhánh production (chạy thật)
dev         → nhánh phát triển (tổng hợp các feature)
feature/*   → nhánh tính năng (code từng phần nhỏ)
fix/*       → nhánh sửa lỗi
hotfix/*    → nhánh fix khẩn cho production
```

---

## ⚙️ 2. Quy trình làm việc tiêu chuẩn

### 🔹 Khi mới clone dự án

```bash
git clone <repo_url>
cd <project_name>
git checkout dev
```

---

### 🔹 Khi tạo tính năng mới

```bash
git checkout dev
git pull origin dev       # cập nhật code mới nhất
git checkout -b feature/<tên_tính_năng>
```

👉 Ví dụ:

```bash
git checkout -b feature/login_screen
```

---

### 🔹 Trong quá trình code

* Commit thường xuyên, chia nhỏ commit rõ ràng.
* Quy tắc đặt commit message:

  ```
  [feature] Tạo UI cho login screen
  [fix] Sửa lỗi validate email
  [refactor] Tách logic call API
  ```

---

### 🔹 Khi hoàn thành tính năng

1. Push lên remote:

   ```bash
   git push origin feature/<tên_tính_năng>
   ```
2. Tạo **Pull Request (PR)** về `dev`.
3. Reviewer review → Merge PR → Xoá nhánh local + remote:

   ```bash
   git branch -d feature/<tên_tính_năng>
   git push origin --delete feature/<tên_tính_năng>
   ```

#### 💡 Tại sao nên xoá nhánh sau khi merge?

* Giữ repo **gọn gàng, dễ quản lý** (tránh tồn đọng hàng chục nhánh cũ).
* Tránh **nhầm lẫn hoặc code nhầm vào nhánh đã hoàn thành**.
* Khi cần làm lại tính năng, bạn có thể **tạo lại nhánh mới từ dev**, đảm bảo code nền luôn mới nhất.

---

### 🔹 Khi cần deploy (production)

1. Từ `dev` merge vào `main`:

   ```bash
   git checkout main
   git pull origin main
   git merge dev
   git push origin main
   ```
2. Tạo tag version:

   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

---

## 🧹 3. Quy tắc ignore & giữ thư mục trống

### 🧾 `.gitignore`

Luôn có file `.gitignore` chuẩn cho Flutter:

```
/build/
/.idea/
/.gradle/
/android/.gradle/
/ios/Pods/
/node_modules/
*.log
*.iml
*.DS_Store
pubspec.lock
```

### 📁 `.gitkeep`

Nếu bạn muốn giữ thư mục trống (VD: `assets/images/`), thêm file `.gitkeep` bên trong.

* Nếu **muốn Git theo dõi** → giữ nguyên `.gitkeep`
* Nếu **muốn Git bỏ qua** → thêm dòng này vào `.gitignore`:

  ```
  *.gitkeep
  ```

Kiểm tra xem `.gitkeep` có đang được theo dõi không:

```bash
git check-ignore -v <path_to_gitkeep>
```

---

## 🧠 4. Lưu ý quan trọng

* Luôn **pull trước khi code**.
* Không push trực tiếp lên `dev` hoặc `main`.
* Review kỹ PR trước khi merge.
* Giữ commit message **ngắn gọn, mô tả rõ thay đổi**.
* Không commit file build, file IDE.

---

## 👥 5. Mẹo dành cho nhóm

| Tình huống                    | Lệnh nhanh                          |
| ----------------------------- | ----------------------------------- |
| Cập nhật code mới nhất từ dev | `git pull origin dev`               |
| Hoàn tác thay đổi chưa commit | `git restore .`                     |
| Xem nhánh hiện tại            | `git branch`                        |
| Xoá nhánh local               | `git branch -d <branch>`            |
| Xoá nhánh remote              | `git push origin --delete <branch>` |

---

## 🏁 6. Ví dụ quy trình đầy đủ

```bash
# 1. Tạo nhánh mới
git checkout dev
git pull origin dev
git checkout -b feature/chat_screen

# 2. Code, commit
git add .
git commit -m "[feature] Thêm UI chat screen"

# 3. Push & tạo PR
git push origin feature/chat_screen
# -> Lên GitHub tạo Pull Request về dev

# 4. Sau khi merge
git checkout dev
git pull origin dev
git branch -d feature/chat_screen
git push origin --delete feature/chat_screen
```

---

🧩 **Tác giả:** Team Flutter–Spring Boot
📅 **Cập nhật:** 2025-11-04
✅ **Mục tiêu:** Giữ quy trình Git rõ ràng, đồng nhất, tránh xung đột code.
