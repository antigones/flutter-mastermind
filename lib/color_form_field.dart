import 'package:flutter/material.dart';

class ColorFormField extends FormField<int> {
  ColorFormField(
      {FormFieldSetter<int> onSaved,
      FormFieldValidator<int> validator,
      int initialValue = 0,
      AutovalidateMode autovalidateMode = AutovalidateMode.always})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.always,
            builder: (FormFieldState<int> state) {
              return Column(
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_drop_up),
                    onTap: () {
                      state.didChange((state.value + 1) % 10);
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(state.value.toString(),style: TextStyle(fontSize: 20),)),
                  InkWell(
                    child: Icon(Icons.arrow_drop_down),
                    onTap: () {
                      state.didChange((state.value - 1) % 10);
                    },
                  ),
                ],
              );

            });
}
