

import 'package:get_it/get_it.dart';

import 'app/features/dashboard/views/components/crud/components/last_index.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static init() {
    getIt.registerSingleton<Indx>(Indx());

  }

  static T get<T extends Object>() {
    return getIt.get<T>();
  }
}
//LocaleProvider GradeSelected