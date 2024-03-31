import 'package:flutter/material.dart';
import 'package:todo_app/configs/utils.dart';

class FormInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const FormInput({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.9,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Entrez une valeur';
          }
          return null;
        },
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.next,
        style: context.bodySmall,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            height: 2,
            color: Colors.black.withOpacity(0.7),
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2),),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: context.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
