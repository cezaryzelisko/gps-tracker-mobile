String formatDateTime(DateTime dateTime, {withDate = true, withTime = true, withMillis = false}) {
  var localDateTimeStr = dateTime.toLocal().toString();
  if (withDate && withTime && withMillis) {
    return localDateTimeStr;
  }

  var parts = localDateTimeStr.split(' ');
  var date = parts[0];
  var timeParts = parts[1].split('.');
  var time = timeParts[0];
  var millis = timeParts[1];

  var formattedDateTime = '';
  if (withDate) {
    formattedDateTime += date;
  }

  if (withTime) {
    if (formattedDateTime.length > 0) {
      formattedDateTime += ' $time';
    } else {
      formattedDateTime += time;
    }
  }

  if (withMillis) {
    if (withTime) {
      formattedDateTime += '.$millis';
    } else {
      formattedDateTime += millis;
    }
  }

  return formattedDateTime;
}
