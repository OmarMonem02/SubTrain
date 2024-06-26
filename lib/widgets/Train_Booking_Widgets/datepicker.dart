import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class QDatePicker extends StatefulWidget {
  final String label;
  final DateTime? value;
  final String? hint;
  final String? Function(String?)? validator;
  final Function(DateTime) onChanged;

  const QDatePicker({
    super.key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    required this.onChanged,
  });

  @override
  State<QDatePicker> createState() => _QDatePickerState();
}

class _QDatePickerState extends State<QDatePicker> {
  DateTime? selectedValue;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    controller = TextEditingController(
      text: getInitialValue(),
    );
  }

  getInitialValue() {
    if (widget.value != null) {
      return DateFormat("dd/MM/yyyy").format(widget.value!);
    }
    return "-";
  }

  getFormattedValue() {
    if (selectedValue != null) {
      return DateFormat("dd/MM/yyyy").format(selectedValue!);
    }
    return "-";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        selectedValue = pickedDate;
        controller.text = getFormattedValue();
        setState(() {});

        widget.onChanged(selectedValue!);
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(selectedValue.toString());
            }
            return null;
          },
          readOnly: true,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: MyFonts.font16Black,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
