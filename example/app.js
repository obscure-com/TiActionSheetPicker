var TiActionSheetPicker = require('com.obscure.tiactionsheetpicker');

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white',
	layout: 'vertical'
});
var label = Ti.UI.createLabel({ top: 10 });
win.add(label);

var b1 = Ti.UI.createButton({
  top: 10,
  title: 'pick a date'
});
b1.addEventListener('click', function() {
  var picker = TiActionSheetPicker.createDatePickerSheet({
    title: "Pick a Date",
    mode: Ti.UI.PICKER_TYPE_DATE,
    initialDate: new Date(2013, 4, 14),
    hideCancel: true
  });
  picker.addEventListener('change', function(e) {
    label.text = String.formatDate(e.selectedDate, 'medium');
  })
  picker.show();
});
win.add(b1);

var b2 = Ti.UI.createButton({
  top: 10,
  title: 'pick an animal',
});
b2.addEventListener('click', function() {
  var rows = ['aardvark', 'bandicoot', 'cougar', 'dugong', 'emu', 'finch', 'gorilla', 'hedgehog', 'iguana', 'jackal', 'koala', 'llama', 'mastodon', 'newt', 'okapi', 'porcupine', 'quail', 'rhinoceros', 'sheep', 'tapir', 'urchin', 'vicuna', 'wallaby', 'xantus', 'yak', 'zebra' ];
  var picker = TiActionSheetPicker.createStringPickerSheet({
    title: "Pick an Animal",
    initialSelection: 5,
    rows: rows
  });
  picker.addEventListener('change', function(e) {
    label.text = rows[e.selectedIndex];
  })
  picker.show();
});
win.add(b2);


win.open();
