import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'todo_controller.dart';

class PageToDoDetail extends StatefulWidget {
  final ToDoItem? item;
  final bool isEdit;
  final ToDoController controller;

  const PageToDoDetail({
    Key? key,
    this.item,
    required this.isEdit,
    required this.controller,
  }) : super(key: key);

  @override
  _PageToDoDetailState createState() => _PageToDoDetailState();
}

class _PageToDoDetailState extends State<PageToDoDetail> {
  late GlobalKey<FormState> formState;
  late TextEditingController txtTitle;
  late TextEditingController txtDescription;
  late TextEditingController txtDueDate;
  late TextEditingController txtReminder;
  int? selectedPriority;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    formState = GlobalKey<FormState>();
    txtTitle = TextEditingController(text: widget.item?.title ?? "");
    txtDescription =
        TextEditingController(text: widget.item?.description ?? "");
    txtDueDate = TextEditingController(text: widget.item?.dueDate ?? "");
    txtReminder = TextEditingController(text: widget.item?.reminder ?? "");
    selectedPriority = widget.item?.priority ?? 2;
    isCompleted = widget.item?.isCompleted ?? false;
  }

  @override
  void dispose() {
    txtTitle.dispose();
    txtDescription.dispose();
    txtDueDate.dispose();
    txtReminder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Sửa công việc" : "Thêm công việc mới"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: formState,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Tiêu đề *",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: txtTitle,
                validator: (value) => validateString(value),
                decoration: InputDecoration(
                  hintText: "Nhập tiêu đề công việc",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                "Mô tả",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: txtDescription,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Nhập mô tả công việc",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 16),

              // Priority
              Text(
                "Mức độ ưu tiên",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: selectedPriority,
                onChanged: (value) => setState(() => selectedPriority = value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("🔴 Cao")),
                  DropdownMenuItem(value: 2, child: Text("🟠 Trung bình")),
                  DropdownMenuItem(value: 3, child: Text("🟢 Thấp")),
                ],
              ),
              const SizedBox(height: 16),

              // Due Date
              Text(
                "Ngày hạn chót",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: txtDueDate,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Chọn ngày hạn chót",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.date_range),
                    onPressed: _selectDate,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Reminder
              Text(
                "Nhắc nhở",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: txtReminder,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Chọn thời gian nhắc nhở",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.notifications),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: _selectReminder,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Completed
              if (widget.isEdit)
                CheckboxListTile(
                  title: const Text("Đã hoàn thành"),
                  value: isCompleted,
                  onChanged: (value) =>
                      setState(() => isCompleted = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text("Hủy"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text("Lưu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      txtDueDate.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  }

  void _selectReminder() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      txtReminder.text = selectedTime.format(context);
    }
  }

  void _save() {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();

      ToDoItem item = ToDoItem(
        id: widget.item?.id,
        title: txtTitle.text,
        description: txtDescription.text,
        dueDate: txtDueDate.text,
        reminder: txtReminder.text,
        priority: selectedPriority,
        isCompleted: isCompleted,
      );

      if (widget.isEdit) {
        widget.controller.updateToDoItem(item, widget.item!.id!).then((result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cập nhật thành công!")),
            );
            Navigator.pop(context);
          }
        });
      } else {
        widget.controller.addToDoItem(item).then((result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Thêm công việc thành công!")),
            );
            Navigator.pop(context);
          }
        });
      }
    }
  }

  String? validateString(String? value) {
    return value == null || value.isEmpty ? "Bạn chưa nhập tiêu đề" : null;
  }
}
