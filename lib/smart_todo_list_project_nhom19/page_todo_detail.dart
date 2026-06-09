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
  bool hasReminder = false;

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
    hasReminder = (widget.item?.reminder ?? "").isNotEmpty;
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
        elevation: 0,
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

              // Reminder Toggle
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bật nhắc nhở",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Switch(
                            value: hasReminder,
                            onChanged: (value) {
                              setState(() {
                                hasReminder = value;
                                if (!value) {
                                  txtReminder.clear();
                                }
                              });
                            },
                            activeColor: Colors.orange,
                          ),
                        ],
                      ),
                      if (hasReminder) ...[
                        const SizedBox(height: 12),
                        Text(
                          "Thời gian nhắc nhở",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: txtReminder,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Chọn thời gian",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.access_time),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.schedule),
                              onPressed: _selectReminder,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildQuickReminderButtons(),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Completed
              if (widget.isEdit)
                CheckboxListTile(
                  title: const Text("✅ Đã hoàn thành"),
                  value: isCompleted,
                  onChanged: (value) =>
                      setState(() => isCompleted = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text("Lưu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
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

  // Nút nhắc nhở nhanh
  Widget _buildQuickReminderButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildQuickReminderButton("08:00", "Sáng"),
        _buildQuickReminderButton("12:00", "Trưa"),
        _buildQuickReminderButton("18:00", "Chiều"),
        _buildQuickReminderButton("20:00", "Tối"),
      ],
    );
  }

  Widget _buildQuickReminderButton(String time, String label) {
    return ActionChip(
      onPressed: () {
        setState(() {
          txtReminder.text = time;
        });
      },
      label: Text("$label\n$time"),
      backgroundColor: txtReminder.text == time ? Colors.orange : Colors.grey[200],
      labelStyle: TextStyle(
        color: txtReminder.text == time ? Colors.white : Colors.black87,
        fontSize: 12,
      ),
      avatar: Icon(
        Icons.schedule,
        size: 16,
        color: txtReminder.text == time ? Colors.white : Colors.grey,
      ),
    );
  }

  void _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        txtDueDate.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  void _selectReminder() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        // Chuyển đổi sang format 24h (HH:mm) cho notification service
        final hour = selectedTime.hour.toString().padLeft(2, '0');
        final minute = selectedTime.minute.toString().padLeft(2, '0');
        final time24h = '$hour:$minute';
        txtReminder.text = time24h;
        
        debugPrint("✅ Selected time: ${selectedTime.format(context)} → Saved as: $time24h");
      });
    }
  }

  void _save() {
    if (hasReminder && (txtDueDate.text.isEmpty || txtReminder.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Vui lòng chọn ngày hạn chót và giờ nhắc nhở"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (hasReminder) {
      final dateParts = txtDueDate.text.split('/');
      final timeParts = txtReminder.text.split(':');
      if (dateParts.length != 3 || timeParts.length != 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ Định dạng ngày/giờ không đúng"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      final day = int.tryParse(dateParts[0]);
      final month = int.tryParse(dateParts[1]);
      final year = int.tryParse(dateParts[2]);
      final hour = int.tryParse(timeParts[0]);
      final minute = int.tryParse(timeParts[1]);

      if (day == null || month == null || year == null || hour == null || minute == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ Ngày/giờ không hợp lệ"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      final scheduled = DateTime(year, month, day, hour, minute);
      if (scheduled.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ Giờ nhắc nhở phải ở tương lai"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
    }

    if (formState.currentState!.validate()) {
      formState.currentState!.save();

      ToDoItem item = ToDoItem(
        id: widget.item?.id,
        title: txtTitle.text,
        description: txtDescription.text,
        dueDate: txtDueDate.text,
        reminder: hasReminder ? txtReminder.text : "",
        priority: selectedPriority,
        isCompleted: isCompleted,
        notificationId: widget.item?.notificationId,
      );

      if (widget.isEdit) {
        widget.controller.updateToDoItem(item, widget.item!.id!).then((result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("✅ Cập nhật thành công!"),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          }
        });
      } else {
        widget.controller.addToDoItem(item).then((result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("✅ Thêm công việc thành công!"),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          }
        });
      }
    }
  }

  String? validateString(String? value) {
    return value == null || value.isEmpty ? "⚠️ Bạn chưa nhập tiêu đề" : null;
  }
}
