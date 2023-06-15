import 'package:clean_arch_tdd_course/core/network/network_info.dart';
import 'package:clean_arch_tdd_course/core/util/input_converter.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/repositories/trivia_repository.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

/// Entry point to register all dependencies
Future<void> init() async {
  _featuresNumberTrivia();
  _core();
  await _external();
}

void _featuresNumberTrivia() {
  getIt.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      inputConverter: getIt(),
      random: getIt(),
      concrete: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetConcreteNumberTrivia(getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTrivia(getIt()));

  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(getIt()),
  );
}

void _core() {
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton(() => InputConverter());
}

Future<void> _external() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Client());
  getIt.registerLazySingleton(() => InternetConnection());
}
