// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repository/auth_repository.dart' as _i7;
import '../repository/impl/auth_repository.dart' as _i8;
import '../storages/hive_storage.dart' as _i4;
import '../utils/services/notification/fcm_service.dart' as _i3;
import '../utils/services/notification/local_notification_service.dart' as _i5;
import 'rest_client_factory.dart' as _i6;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.FCMService>(() => _i3.FCMService());
  gh.singleton<_i4.HiveStorage>(() => _i4.HiveStorage());
  gh.lazySingleton<_i5.NotificationService>(() => _i5.NotificationService());
  gh.singleton<_i6.RestClientFactory>(() => _i6.RestClientFactory());
  gh.lazySingleton<_i7.AuthRepository>(
      () => _i8.AuthRepositoryImpl(gh<_i6.RestClientFactory>()));
  return getIt;
}
