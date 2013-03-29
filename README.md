# TiActionSheetPicker

by Paul Mietz Egli (paul@obscure.com)
based on ActionSheetPicker by Tim Cinel (https://github.com/TimCinel/ActionSheetPicker)

**TiActionSheetPicker** is an Appcelerator Titanium module which wraps ActionSheetPicker, the library for
creating action sheets on iOS for choosing date/times and from a list of strings.

## Using the Module

If you have used [Ti.UI.OptionDialog](http://docs.appcelerator.com/titanium/latest/#!/api/Titanium.UI.OptionDialog),
you should feel right at home with the action sheets provided by this module.  Here's how to pop up a
sheet with a date picker and get the selected date back:

```javascript
var picker = TiActionSheetPicker.createDatePickerSheet({
  title: "Pick a Date",
  mode: Ti.UI.PICKER_TYPE_DATE,
  initialDate: new Date(2013, 4, 14),
});
picker.addEventListener('change', function(e) {
  // e.selectedDate contains the date object that was chosen
  label.text = String.formatDate(e.selectedDate, 'medium');
})
picker.show();
```

Similarly, you can create an action sheet for selecting from a list of strings:
```javascript
var rows = ['aardvark', 'bandicoot', 'cougar', 'dugong', 'yak', 'zebra' ];
var picker = TiActionSheetPicker.createStringPickerSheet({
  title: "Pick an Animal",
  initialSelection: 4,
  rows: rows
});
picker.addEventListener('change', function(e) {
  label.text = rows[e.selectedIndex];
})
picker.show();
```

## Requirements

* Titanium SDK 3.0.2 or later
* Xcode 4.5 or later

## License

* TiActionSheetPicker is under the Apache License 2.0
* ActionSheetPicker is under the BSD License. See that project for additional licenses.

## Development Status 

**1.0**

2013-03-29

Added support for date/time picker and string picker
