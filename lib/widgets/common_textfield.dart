import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  const CommonTextField(
      {super.key,
      this.label,
      this.hintText,
      this.keyboardType,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText!,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
        ],
      ),
    );
  }
}
