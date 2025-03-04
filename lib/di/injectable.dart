import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/di/injectable.config.dart';
import 'package:ultra/network/dio_client.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  DioClient get dioClient => DioClient();

  @lazySingleton
  BondsRepository get bondsRepository =>
      BondsRepositoryImpl(getIt<DioClient>());
}
