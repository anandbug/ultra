// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ultra/bonds/data/repositories/bonds_repository.dart' as _i1052;
import 'package:ultra/di/injectable.dart' as _i19;
import 'package:ultra/network/dio_client.dart' as _i252;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i252.DioClient>(() => registerModule.dioClient);
    gh.lazySingleton<_i1052.BondsRepository>(
      () => registerModule.bondsRepository,
    );
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}
