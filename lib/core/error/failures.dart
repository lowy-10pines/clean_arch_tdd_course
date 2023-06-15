sealed class Failure {}

class ServerFailure implements Failure {
  @override
  bool operator ==(Object other) {
    return other is ServerFailure;
  }

  @override
  int get hashCode => 1 + super.hashCode;
}

class CacheFailure implements Failure {
  @override
  bool operator ==(Object other) {
    return other is CacheFailure;
  }

  @override
  int get hashCode => 2 + super.hashCode;
}

class InvalidInputFailure implements Failure {
  @override
  bool operator ==(Object other) {
    return other is InvalidInputFailure;
  }

  @override
  int get hashCode => 3 + super.hashCode;
}
