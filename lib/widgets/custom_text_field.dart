import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color.fromARGB(255, 84, 83, 83),
          width: 2.0,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignInside),
      borderRadius: BorderRadius.circular(15),
    );

    return SizedBox(
      width: 389,
      child: TextFormField(
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter some text';
        //   }
        //   return null;
        // },
        controller: controller,
        minLines: 1,
        style: const TextStyle(
          color: Color.fromARGB(255, 84, 83, 83),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 84, 83, 83),
          ),
          focusedBorder: border,
          enabledBorder: border,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
        ),
      ),
    );
  }
}
