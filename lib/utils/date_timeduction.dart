import 'package:intl/intl.dart';

class ConverDate {
  String getdateofDelivery(String datetime) {
    DateTime date = DateTime.parse(datetime);

    DateTime deliveryDate = date.add(const Duration(days: 2));
    return DateFormat.yMd().format(deliveryDate);
  }

  converDateOrder(String datetime) {
    DateTime date = DateTime.parse(datetime);

    DateTime deliveryDate = date;
    return DateFormat.yMd().format(deliveryDate);
  }

  String getdateproduct(String dateTime) {
    return DateFormat.yMd().format(DateTime.parse(dateTime));
  }
    DateTime durationNewproducts(){
     DateTime time=DateTime.now();
    DateTime  isproductnewtime= time.subtract(const Duration(days: 10));
     return isproductnewtime;
  }
}
