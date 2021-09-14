import 'package:intl/intl.dart';

getDateFormat(_date) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var inputDate = inputFormat.parse(_date);
  var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
  return outputFormat.format(inputDate);
}
