import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swift_do/utils/color_constants.dart';


class DatePickerHelper with ChangeNotifier {
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;
   void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  String get formattedDate => _selectedDate == null 
      ? "Select due date" 
      : "Due: ${DateFormat('MMM dd, yyyy').format(_selectedDate!)}";

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      notifyListeners(); // Notify UI to update
    }
  }

  void clearDate() {
    _selectedDate = null;
    notifyListeners();
  }
}