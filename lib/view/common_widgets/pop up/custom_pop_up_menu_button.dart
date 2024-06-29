import 'package:flutter/material.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import '../../../utils/app_colors.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
    this.selectedColor = AppColors.primaryColor,
    this.unselectedColor = Colors.transparent,
    this.style,
  });

  final List items;
  final String selectedItem;
  final Color selectedColor;
  final Color unselectedColor;
  final Function(int index) onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: selectedColor)),
        offset: const Offset(1, 1),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: selectedItem,
            child: Column(
              children: List.generate(
                items.length,
                    (index) => GestureDetector(
                  onTap: () => onTap(index),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: selectedColor),
                            color: selectedItem == items[index].toString()
                                ? selectedColor
                                : unselectedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        8.width,
                        Text(
                          items[index].toString(),
                          style: style,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.black,
          size: 32,
        ));
  }
}

