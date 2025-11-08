# === RULE: CẤU TRÚC THƯ MỤC KHI CHUYỂN ĐỔI REACT → FLUTTER ===

## Nguyên tắc chung:
1. **Feature-First Architecture**: Tổ chức theo tính năng, không theo layer
2. **Role-based organization**: Phân chia theo vai trò (student, admin, auth, home, dashboard)
3. **Layered presentation**: Mỗi feature có `presentation/` với `pages/` và `widgets/`

## Mapping React → Flutter:

### 1. React Page → Flutter Page
**React:** `src/pages/<role>/<FeatureName>.jsx`
**Flutter:** `lib/features/<role>/<feature>/<sub-feature>/presentation/pages/<feature_name>_page.dart`

**Ví dụ:**
- `src/pages/student/LessonInfo.jsx` 
  → `lib/features/student/lessons/info/presentation/pages/lesson_info_page.dart`
- `src/pages/student/LessonDashboard.jsx`
  → `lib/features/student/lessons/dashboard/presentation/pages/lesson_dashboard_page.dart`
- `src/pages/student/LessonClassrom.jsx`
  → `lib/features/student/lessons/classroom/presentation/pages/lesson_classroom_page.dart`

### 2. React Component → Flutter Widget
**React:** `src/components/<role>/<ComponentName>.jsx`
**Flutter:** `lib/features/<role>/<feature>/<sub-feature>/presentation/widgets/<component_name>.dart`

**Ví dụ:**
- `src/components/student/LessonCard.jsx`
  → `lib/features/student/lessons/dashboard/presentation/widgets/lesson_card.dart`
- `src/components/student/LessonInfoHeader.jsx`
  → `lib/features/student/lessons/info/presentation/widgets/lesson_info_header.dart`

### 3. React Component trong Page → Flutter Widget trong cùng sub-feature
**React:** Component được dùng trong `LessonInfo.jsx`
**Flutter:** Widget trong `lib/features/student/lessons/info/presentation/widgets/`

**Ví dụ:**
- Component trong `LessonInfo.jsx` → `lesson_info_*.dart` trong `info/presentation/widgets/`
- Component trong `LessonDashboard.jsx` → `lesson_dashboard_*.dart` trong `dashboard/presentation/widgets/`

### 4. React Common Component → Flutter Shared Widget
**React:** `src/components/common/<ComponentName>.jsx`
**Flutter:** `lib/shared/widgets/<component_name>.dart`

**Ví dụ:**
- `src/components/common/Button.jsx` → `lib/shared/widgets/app_button.dart`
- `src/components/common/Card.jsx` → `lib/shared/widgets/app_card.dart`

### 5. React Hook/Utils → Flutter Provider/Utils
**React:** `src/hooks/useAuth.js` hoặc `src/utils/constants.js`
**Flutter:** 
- Hooks → `lib/features/<role>/<feature>/presentation/providers/` hoặc `lib/shared/providers/`
- Utils → `lib/shared/utils/` hoặc `lib/features/<role>/<feature>/shared/`

**Ví dụ:**
- `src/hooks/useAuth.js` → `lib/features/auth/presentation/providers/auth_provider.dart`
- `src/utils/constants.js` → `lib/shared/constants/` hoặc `lib/features/<role>/shared/`

## Quy tắc đặt tên:

### File names:
- **React:** PascalCase (LessonInfo.jsx, LessonCard.jsx)
- **Flutter:** snake_case (lesson_info_page.dart, lesson_card.dart)

### Class names:
- **React:** PascalCase (LessonInfo, LessonCard)
- **Flutter:** PascalCase (LessonInfoPage, LessonCard)

### Folder structure:
- **React:** `src/pages/student/`, `src/components/student/`
- **Flutter:** `lib/features/student/lessons/<sub-feature>/presentation/`

## Quy trình tạo file khi chuyển đổi:

### Bước 1: Xác định role và feature
- Xác định file React thuộc role nào (student, admin, auth, ...)
- Xác định feature nào (lessons, dashboard, vocabulary, ...)
- Xác định sub-feature nếu có (dashboard, info, classroom trong lessons)

### Bước 2: Tạo cấu trúc thư mục
```
lib/features/<role>/<feature>/<sub-feature>/
└── presentation/
    ├── pages/
    │   └── <feature_name>_page.dart
    └── widgets/
        └── <widget_name>.dart
```

### Bước 3: Tạo file
- Page: `lib/features/<role>/<feature>/<sub-feature>/presentation/pages/<feature_name>_page.dart`
- Widget: `lib/features/<role>/<feature>/<sub-feature>/presentation/widgets/<widget_name>.dart`

### Bước 4: Tạo routing (nếu là page mới)
- Thêm route vào `lib/features/<role>/routing.dart`
- Path: `/<role>-<feature>-<sub-feature>` (ví dụ: `/lesson-classroom`)
- Name: `<role>-<feature>-<sub-feature>` (ví dụ: `lesson-classroom`)

## Ví dụ cụ thể:

### Case 1: LessonInfo.jsx
```
React: src/pages/student/LessonInfo.jsx
Flutter: lib/features/student/lessons/info/presentation/pages/lesson_info_page.dart

Components trong LessonInfo.jsx:
- LessonInfoHeader → lib/features/student/lessons/info/presentation/widgets/lesson_info_header.dart
- LessonInfoBuyCard → lib/features/student/lessons/info/presentation/widgets/lesson_info_buy_card.dart
- LessonInfoTabSection → lib/features/student/lessons/info/presentation/widgets/lesson_info_tab_section.dart
```

### Case 2: LessonDashboard.jsx
```
React: src/pages/student/LessonDashboard.jsx
Flutter: lib/features/student/lessons/dashboard/presentation/pages/lesson_dashboard_page.dart

Components trong LessonDashboard.jsx:
- LessonDashboardHeader → lib/features/student/lessons/dashboard/presentation/widgets/lesson_dashboard_header.dart
- LessonCourseCard → lib/features/student/lessons/dashboard/presentation/widgets/lesson_course_card.dart
```

### Case 3: LessonClassrom.jsx
```
React: src/pages/student/LessonClassrom.jsx
Flutter: lib/features/student/lessons/classroom/presentation/pages/lesson_classroom_page.dart

Components trong LessonClassrom.jsx:
- ClassroomHeader → lib/features/student/lessons/classroom/presentation/widgets/classroom_header.dart
- ClassroomTabBar → lib/features/student/lessons/classroom/presentation/widgets/classroom_tab_bar.dart
```

## Lưu ý đặc biệt:

1. **Sub-feature naming:** 
   - Nếu React page có tên như `LessonInfo`, `LessonDashboard`, `LessonClassroom`
   - Sub-feature sẽ là: `info`, `dashboard`, `classroom` (lowercase, không có prefix "lesson")

2. **Widgets folder naming:**
   - Nếu widget chỉ dùng trong một sub-feature → đặt trong `widgets/` của sub-feature đó
   - Nếu widget dùng chung nhiều sub-feature → đặt trong `widgets/` của feature cha
   - Nếu widget dùng chung nhiều feature → đặt trong `lib/shared/widgets/`

3. **Data/Models:**
   - Nếu data chỉ dùng trong một feature → `lib/features/<role>/<feature>/<sub-feature>/presentation/lesson_dashboard_data.dart`
   - Nếu data dùng chung → `lib/features/<role>/<feature>/shared/` hoặc `lib/shared/models/`

4. **Routing:**
   - Mỗi role có file `routing.dart` riêng: `lib/features/<role>/routing.dart`
   - Routes được import vào `lib/shared/routing/app_router.dart`

## Cấu trúc thư mục chuẩn:

```
lib/
├── features/
│   └── <role>/                    # student, admin, auth, home, dashboard
│       └── <feature>/             # lessons, dashboard, vocabulary
│           └── <sub-feature>/     # dashboard, info, classroom (trong lessons)
│               └── presentation/
│                   ├── pages/      # Full page widgets (Scaffold)
│                   └── widgets/   # Reusable UI components
│       └── <shared>/              # point_system, routing (trong role)
└── shared/                        # Dùng chung toàn app
    ├── routing/
    ├── theme/
    ├── utils/
    └── widgets/
```

# ========================================


