import 'package:flutter/material.dart';

import 'add_color_dialog.dart';

class ColorSizes extends FormField<List> {
  ColorSizes({
    BuildContext context,
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            builder: (state) {
              return SizedBox(
                height: 50,
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5),
                  children: state.value.map((s) {
                    return GestureDetector(
                      onLongPress: () {
                        state.didChange(state.value..remove(s));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 3)),
                        alignment: Alignment.center,
                        child: Container(
                          color: Color(int.parse(s.substring(1, 7), radix: 16) +
                              0xFF000000),
                        ),
                      ),
                    );
                  }).toList()
                    ..add(GestureDetector(
                      onTap: () async {
                        String color = await showDialog(
                            context: context,
                            builder: (context) => AddColorDialog());
                        if (color != null)
                          state.didChange(state.value..add(color));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: state.hasError
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                                width: 3)),
                        alignment: Alignment.center,
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    )),
                ),
              );
            });
}
