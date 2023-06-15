import 'package:bloc/bloc.dart';
import 'package:clean_arch_tdd_course/core/either.dart';
import 'package:clean_arch_tdd_course/core/error/failures.dart';
import 'package:clean_arch_tdd_course/core/util/input_converter.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter/material.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = "Server failure";
const String cacheFailureMessage = "Cache failure";
const String invalidInputMessage =
    "Invalid input, the number must be a positive integer or zero";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final InputConverter inputConverter;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;

  NumberTriviaBloc({
    required this.inputConverter,
    required GetRandomNumberTrivia random,
    required GetConcreteNumberTrivia concrete,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final input = inputConverter.stringToUnsignedInteger(event.numberString);
      await input.fold(
        (failure) async => emit(Errored(invalidInputMessage)),
        (value) async {
          emit(Loading());
          final failureOrTrivia = await getConcreteNumberTrivia(value);
          _eitherLoadedOrErrorState(failureOrTrivia, emit);
        },
      );
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia();
      _eitherLoadedOrErrorState(failureOrTrivia, emit);
    });
  }

  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia,
      Emitter<NumberTriviaState> emit) {
    failureOrTrivia.fold(
      (failure) => emit(Errored(failure.errorMessage)),
      (trivia) => emit(Loaded(trivia)),
    );
  }
}

extension _FailureMessage on Failure {
  String get errorMessage => switch (this) {
        ServerFailure() => serverFailureMessage,
        CacheFailure() => cacheFailureMessage,
        InvalidInputFailure() => invalidInputMessage,
      };
}
