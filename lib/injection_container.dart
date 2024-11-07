import 'package:do_an_tot_nghiep/features/auth/data/auth_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_api_client.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs/http_client.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/data/auth_local_data_source.dart';
import 'features/auth/data/auth_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(sl<AuthRepository>()));

  // Api Repository
  sl.registerLazySingleton(() => AuthRepository(
        authApiClient: sl<AuthApiClient>(),
        authLocalDataSource: sl<AuthLocalDataSource>(),
      ));
  sl.registerLazySingleton(() => UserRepository(sl<UserApiClient>()));
  sl.registerLazySingleton(() => VersionRepository(sl<VersionApiClient>()));

  // Api Client
  sl.registerLazySingleton(() => AuthApiClient(sl<DioClient>()));
  sl.registerLazySingleton(() => UserApiClient(sl<DioClient>()));
  sl.registerLazySingleton(() => VersionApiClient(sl<DioClient>()));

  // Local Data Source
  sl.registerLazySingleton(() => AuthLocalDataSource(sl<SharedPreferences>()));

  sl.registerSingleton(DioClient());

  sl.registerSingleton(await SharedPreferences.getInstance());
}
