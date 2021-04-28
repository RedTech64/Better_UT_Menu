import 'package:flutter/material.dart';

class LegendDialog extends StatefulWidget {
  List<String> disabledTags;

  LegendDialog(this.disabledTags);

  @override
  _LegendDialogState createState() => _LegendDialogState(this.disabledTags);
}

class _LegendDialogState extends State<LegendDialog> {
  List<String> disabledTags;

  _LegendDialogState(this.disabledTags);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tags'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(disabledTags),
        )
      ],
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Chefs Choice',
              'Contains Beef',
              'Contains Egg',
              'Contains Fish',
              'Contains Milk',
              'Contains Peanuts',
              'Contains Pork',
              'Contains Shellfish',
              'Contains Soy',
              'Contains Tree Nuts',
              'Contains Wheat',
              'Halal Friendly',
              'Lite Bite',
              'Vegan',
              'Vegetarian'
            ].map((tag) => 
              SwitchListTile(
                secondary: Image.asset(tag.replaceAll(' ', '') + '.png', width: 32, height: 32),
                title: Text(tag),
                value: !disabledTags.contains(tag),
                onChanged: (value) {
                  setState(() {
                    if (value)
                      disabledTags.remove(tag);
                    else
                      disabledTags.add(tag);
                  });
                },
              )  
            ).toList(),
          ),
        ),
      ),
    );
  }
}