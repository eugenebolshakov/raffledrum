$(function() {
  $.datepicker.setDefaults({'dateFormat': 'd M, y'})

  $('#raffle_start_time').datepicker()
  $('#raffle_end_time').datepicker()

  if ($('.my_raffles').size != 0) {
    setInterval(function() { window.location.reload(); }, 1000 * 10);
  }
});
