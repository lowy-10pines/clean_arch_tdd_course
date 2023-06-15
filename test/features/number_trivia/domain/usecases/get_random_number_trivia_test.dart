import 'package:clean_arch_tdd_course/core/either.dart';
import 'package:clean_arch_tdd_course/core/error/failures.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repository);
  });

  final testNumberTrivia = NumberTrivia("Submarine super", 99);

  test('should get trivia for a random number from the repository', () async {
    when(repository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(testNumberTrivia));

    final result = await usecase();

    expect(result, Right<Failure, NumberTrivia>(testNumberTrivia));
    verify(repository.getRandomNumberTrivia());
    verifyNoMoreInteractions(repository);
  });
}
