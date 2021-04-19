import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DialogController extends GetxController {
  final datetime =
      '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}, ${DateFormat('y').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}'
          .obs;
  changeDate(date) => datetime.value =
      '${DateFormat('EEEE').format(date)}, ${DateFormat('d').format(date)} ${DateFormat('MMMM').format(date).substring(0, 3)}, ${DateFormat('y').format(date)}, ${DateFormat('jm').format(date)}';
}
