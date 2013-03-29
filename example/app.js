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
    hideCancel: true
  });
  picker.addEventListener('change', function(e) {
    label.text = String.formatDate(e.selectedDate, 'medium');
  })
  picker.show();
});
win.add(b1);


win.open();
