import 'package:get_storage/get_storage.dart';

class Indx {
  dynamic get indx => _indx;

  void setindx(dynamic indx) {
    _indx = indx;
    saveIndx(indx);
  }

  dynamic _indx = GetStorage().read("indx");
  void saveIndx(dynamic indx) => GetStorage().write("indx", indx);
}
