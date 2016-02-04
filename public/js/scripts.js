$(function() {
  $('.select-auto-submit').on('change', function() {
    this.form.submit();
  });
});

/* Show theme slider values on ingredients_edit.erb */


var total = 0;
var value = 0;

 window.onload = function() {
 $("#numbers").append(100);
 console.log("are we on load?")
 };

function showValue(newValue, index) {
  var numbersDiv = document.getElementById("numbers");
  total = 0;

	document.getElementsByClassName('theme-value')[index].innerHTML=newValue;
  cal_value()
  numbersDiv.innerHTML=total;
  if(total === 100) {
    $('.value-btn').removeAttr('disabled', 'disabled');
    $('#numbers').removeClass('red');
    $('#numbers').addClass('green');
  } else {
    $('.value-btn').attr('disabled', 'disabled');
    $('#numbers').removeClass('green');
    $('#numbers').addClass('red');
  }
  console.log(total);
};

function cal_value() {
  value = 0;
  for (i = 0; i < 6; i++) {
    value = parseInt(document.getElementsByClassName('theme-value')[i].innerHTML);
    if(!isNaN(value)) {
      total += value;
    }
  }
};

$(document).ready(function() {
  //$("#numbers").append(total);
});
