# Smart To-Do List with Reminder

Ứng dụng quản lý công việc hàng ngày với tính năng nhắc nhở, được xây dựng bằng Flutter & Dart.

## 📋 Tính năng

- ✅ **Thêm công việc**: Tạo công việc mới với tiêu đề, mô tả, ngày hạn chót
- ✏️ **Sửa công việc**: Cập nhật thông tin công việc bất kỳ lúc nào
- 🗑️ **Xoá công việc**: Xoá công việc không còn cần thiết
- 🔔 **Nhắc nhở**: Đặt thời gian nhắc nhở cho mỗi công việc
- 🚩 **Mức độ ưu tiên**: Phân loại công việc theo mức độ (Cao, Trung bình, Thấp)
- ✔️ **Đánh dấu hoàn thành**: Kiểm tra công việc đã hoàn thành
- 💾 **SQLite Database**: Lưu trữ dữ liệu trên thiết bị

## 🗂️ Cấu trúc file

```
nhomcuoiki/
├── todo_model.dart           # Model & Database Helper
├── todo_controller.dart      # GetX Controller
├── provider_todo.dart        # Provider State Management
├── page_todo.dart            # Main UI (List view)
├── page_todo_detail.dart     # Detail/Edit page
└── README.md                 # Documentation
```

## 🛠️ Công nghệ sử dụng

- **Flutter & Dart** - Framework & Language
- **GetX** - State Management & Navigation
- **SQLite** - Local Database (sqflite)
- **Provider** - Alternative State Management
- **flutter_local_notifications** - Push Notifications (tuỳ chọn)

## 📦 Dependencies

Thêm vào `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.0
  provider: ^6.0.0
  sqflite: ^2.0.0
  path_provider: ^2.0.0
  intl: ^0.19.0
  flutter_local_notifications: ^14.0.0  # Optional
```

## 🚀 Sử dụng

### Cách 1: Dùng GetX Controller

```dart
import 'package:code/nhomcuoiki/page_todo.dart';

// Trong main.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: PageToDo(),
    );
  }
}
```

### Cách 2: Dùng Provider

```dart
import 'package:provider/provider.dart';
import 'package:code/nhomcuoiki/provider_todo.dart';

// Trong main.dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoProvider(),
      child: MyApp(),
    ),
  );
}
```

## 📱 Giao diện chính

### Trang danh sách (page_todo.dart)
- Hiển thị tất cả công việc với checkbox hoàn thành
- Hiển thị tiêu đề, mô tả, ngày hạn chót, nhắc nhở
- Nút mềm thêm công việc
- Menu để sửa/xoá công việc

### Trang chi tiết (page_todo_detail.dart)
- Form thêm/sửa công việc
- Nhập tiêu đề (bắt buộc)
- Nhập mô tả (tuỳ chọn)
- Chọn mức độ ưu tiên
- Chọn ngày hạn chót (date picker)
- Chọn thời gian nhắc nhở (time picker)
- Nút lưu/hủy

## 🔄 Workflow

1. **Mở ứng dụng** → Tải dữ liệu từ SQLite
2. **Nhấn "+" để thêm** → Mở form thêm công việc
3. **Điền thông tin** → Nhấn lưu
4. **Xem danh sách** → Click vào mục để sửa hoặc xóa
5. **Checkbox** → Đánh dấu hoàn thành công việc

## 📌 Mô tả file

### todo_model.dart
- Class `ToDoItem` - Model dữ liệu
- Class `DatabaseHelperToDo` - SQLite Helper
- Các phương thức: insert, update, delete, getToDoItems

### todo_controller.dart
- Class `ToDoController` extends GetxController
- Quản lý state với RxList, RxBool
- Phương thức: loadToDoItems, addToDoItem, updateToDoItem, deleteToDoItem, toggleCompleted

### provider_todo.dart
- Class `ToDoProvider` extends ChangeNotifier
- Alternative state management với Provider
- Tương tự functionality như GetX Controller

### page_todo.dart
- UI danh sách công việc
- GetX Obx() để reactive UI
- PopupMenu để edit/delete
- FloatingActionButton để thêm

### page_todo_detail.dart
- Form StatefulWidget để thêm/sửa
- Date & Time picker
- Form validation
- Lưu dữ liệu qua controller

## 🎨 Màu sắc & Design

- **Primary**: Deep Purple
- **Priority colors**: 
  - 🔴 Cao (Red)
  - 🟠 Trung bình (Orange)
  - 🟢 Thấp (Green)

## 💡 Mẹo sử dụng

1. Dùng **Date Picker** để chọn ngày hạn chót
2. Dùng **Time Picker** để chọn giờ nhắc nhở
3. Checkbox để đánh dấu công việc đã xong
4. PopupMenu (3 chấm) để edit hoặc delete

## 🔧 Customization

Bạn có thể:
- Thay đổi màu sắc trong AppBar
- Thêm filter theo trạng thái (hoàn thành/chưa hoàn thành)
- Thêm tính năng tìm kiếm
- Thêm sort theo ngày/ưu tiên
- Thêm hình ảnh cho công việc
- Tích hợp Firebase để đồng bộ cloud

## 🐛 Troubleshooting

**Lỗi database não mở?**
- Kiểm tra permissions trong AndroidManifest.xml
- Xoá app và cài lại

**Không hiện data?**
- Kiểm tra InitDatabase() được gọi trong onInit
- Kiểm tra GetX Controller đúng cách

**Provider không update UI?**
- Đảm bảo gọi notifyListeners()
- Kiểm tra Consumer<ToDoProvider> wrapper

---

**Tác giả**: Lâm Tiến Đạt  
**Mã số**: 65130399  
**Lớp**: Quản lý ứng dụng mobile
