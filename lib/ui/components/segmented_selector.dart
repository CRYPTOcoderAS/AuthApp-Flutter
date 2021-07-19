import 'package:flutter/material.dart';
import 'package:authapp/ui/components/sliding_segmented_control.dart';

class SegmentedSelector extends StatelessWidget {
  SegmentedSelector(
      {this.menuOptions, this.selectedOption, this.onValueChanged});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(dynamic) onValueChanged;

  @override
  Widget build(BuildContext context) {
    //if (Platform.isIOS) {}

    return CupertinoSlidingSegmentedControl(
        groupValue: selectedOption,
        children: Map.fromIterable(
          menuOptions,
          key: (option) => option.key,
          value: (option) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon),
              SizedBox(width: 6),
              Text(option.value),
            ],
          ),
        ),
        onValueChanged: onValueChanged);
  }
}
