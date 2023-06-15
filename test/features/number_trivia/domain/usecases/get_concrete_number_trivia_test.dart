import 'package:clean_arch_tdd_course/core/either.dart';
import 'package:clean_arch_tdd_course/core/error/failures.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/repositories/trivia_repository.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repository);
  });

  const testNumber = 1;
  final testNumberTrivia = NumberTrivia("One is the most solitary number", 1);

  test('should get trivia for the number from the repository', () async {
    when(repository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(testNumberTrivia));

    final result = await usecase(testNumber);

    expect(result, Right<Failure, NumberTrivia>(testNumberTrivia));
    verify(repository.getConcreteNumberTrivia(testNumber));
    verifyNoMoreInteractions(repository);
  });
}
