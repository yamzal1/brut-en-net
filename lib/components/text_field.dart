import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String) onTextChanged;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.onTextChanged
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        keyboardType: TextInputType.number,
        onChanged: onTextChanged,
        validator: (amount) => amount != null && double.tryParse(amount) == null
            ? 'Saisir un nombre valide'
            : null,
      ),
    );
  }
}
