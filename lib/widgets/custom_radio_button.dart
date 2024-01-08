import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String title;
  final Function() pressed;
  final bool selected;
  const CustomRadio(
      {required this.title,
      required this.pressed,
      required this.selected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: pressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: 25,
                height: 25,
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: selected
                        ? const Color.fromRGBO(118, 185, 237, 1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: !selected
                        ? Border.all(
                            color: Colors.grey,
                            width: 1,
                          )
                        : null),
                child: Container(
                  decoration: BoxDecoration(
                    color: selected ? Colors.black : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                )),
            const SizedBox(width: 10),
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 18))
          ],
        ));
  }
}
