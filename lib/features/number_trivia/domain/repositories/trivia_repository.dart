import 'package:clean_arch_tdd_course/core/error/failures.dart';
import 'package:clean_arch_tdd_course/core/either.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
