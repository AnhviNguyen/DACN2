## Koreanhwa Mobile

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.x-4CAF50)](https://riverpod.dev)
[![GoRouter](https://img.shields.io/badge/Routing-GoRouter-orange)](https://pub.dev/packages/go_router)
[![Dio](https://img.shields.io/badge/API-Dio-informational)](https://pub.dev/packages/dio)
[![Hive](https://img.shields.io/badge/Storage-Hive-yellow)](https://pub.dev/packages/hive)
[![Material%203](https://img.shields.io/badge/Design-Material%203-9C27B0)](https://m3.material.io/)

### Mô tả dự án
- Ứng dụng di động chính thức cho nền tảng Koreanhwa.
- Mục tiêu: Mở rộng hệ thống (hiện đã có phiên bản Web bằng React) lên nền tảng di động Flutter, cung cấp trải nghiệm native song song cho người dùng.

---

## Kiến trúc & Công nghệ (Tech Stack)
- **Kiến trúc: Feature-First**: Tổ chức mã nguồn theo tính năng. Mỗi feature tự quản lý pages/widgets/providers/models của chính nó, giúp độc lập triển khai và mở rộng.
- **State Management: Riverpod**: Tách bạch logic và UI, dễ test và composable providers.
- **Routing: GoRouter**: Định nghĩa tuyến đường tập trung, hỗ trợ guards và deep-linking.
- **Local Storage: Hive**: Lưu trữ khoá/giá trị hiệu năng cao cho session, cấu hình, cache.
- **API Client: Dio**: HTTP client với interceptors, timeout, logging và xử lý lỗi.
- **UI**: Flutter Material Design 3, custom theme (màu primary vàng tương tự web).

---

## Các Tính năng chính (theo lộ trình)

- **Authentication & User Management (Phase 2)**
  - Login/Register (UI + validation, Remember me, Forgot password)
  - Social login (Google, Facebook)
  - Quick demo login (Student/Teacher/Admin)
  - Auth Provider (Riverpod), lưu session (Hive/SharedPreferences), Role-based routing

- **Student Features - Core Learning (Phase 3)**
  - Student Dashboard: level, points, progress (Nghe/Nói/Đọc/Viết)
  - Daily tasks, streak calendar, achievements, leaderboard
  - Migrate Landing/Home Page
  - Point/Level/Progress-to-next-level, Content pricing
  - Lessons: Dashboard, Info, Learning, Classroom
  - Roadmap: Overview, Detail

- **TOPIK Practice System (Phase 4)**
  - Main page, TestForm, DetailTest, AnswerTestForm
  - AnswerDetailQuestion, Exam Results, Results Statistics

- **Vocabulary System (Phase 5)**
  - Manager, Add, Lessons, Learning/Test/Quiz/Matching/Flashcard
  - Pronunciation, Writting, Listen & Write Quiz

- **Content & Resources (Phase 6)**
  - Materials (list/detail)
  - Blog (list/detail/create/manage)

- **Competition & Social (Phase 7)**
  - Competition list/join/details

- **Admin Features (Phase 8)**
  - Admin Dashboard (thống kê, truy cập nhanh)
  - User/Content/Role/Forum/Dictionary/Materials/Exam/Progress/Reports/Settings
  - AI System Monitoring

- **Settings & Profile (Phase 9)**
  - SettingsPage, AdminProfile, Notifications, Language, Theme

---

## Cấu trúc Thư mục

```text
lib/
├── features/                # Mỗi tính năng (auth, dashboard, lessons, vocabulary, ...)
│   └── <feature>/
│       └── presentation/pages/...   # UI pages của feature
│       └── ... (providers, widgets, models theo nhu cầu)
└── shared/                  # Dùng chung toàn app
    ├── routing/             # GoRouter và định nghĩa routes
    ├── theme/               # Material 3 theme, màu sắc, typography
    ├── utils/               # API client (Dio), helpers
    └── widgets/             # Base widgets: Button, Input, Card, Badge, Modal...
```

- `lib/features/`: Nơi hiện thực hoá từng khả năng của sản phẩm; giúp phát triển độc lập, dễ bảo trì và scale.
- `lib/shared/`: Hạ tầng dùng chung; tránh trùng lặp và chuẩn hoá trải nghiệm UI/UX lẫn kỹ thuật.

---

## Hướng dẫn Cài đặt & Chạy dự án

1) Clone dự án
```bash
git clone <your-repo-url>
cd koreanhwa_flutter
```

2) Cài đặt dependencies
```bash
flutter pub get
```

3) Chạy dự án (thiết bị thật hoặc giả lập)
```bash
flutter run
```

4) Tuỳ chọn: chỉ định thiết bị/định dạng build
```bash
flutter devices
flutter run -d <device_id>
```

---

### Ghi chú phát triển
- Initial route và routing tập trung trong `lib/shared/routing/app_router.dart`.
- Các base widgets trong `lib/shared/widgets/` giúp giao diện thống nhất và tái sử dụng cao.
- API client nằm ở `lib/shared/utils/api_client.dart` (Dio + interceptors/logging ở môi trường dev).
- Theo chiến lược migration: bottom-up (shared/widgets/utils) và feature-by-feature.

---

## Quy trình Git (Git Flow)

Vui lòng xem tài liệu chi tiết tại: [README_GIT_FLOW.md](./README_GIT_FLOW.md)
