sealed class Either<L, R> {
  late L _left;
  late R _right;

  Either._left(L left) : _left = left;

  Either._right(R right) : _right = right;

  B fold<B>(B Function(L left) onLeft, B Function(R right) onRight);
}

class Left<L, R> extends Either<L, R> {
  Left(L value) : super._left(value);

  @override
  bool operator ==(Object other) {
    return other is Left && other._left == _left;
  }

  @override
  int get hashCode => _left.hashCode + super.hashCode;

  @override
  B fold<B>(B Function(L left) onLeft, B Function(R right) onRight) {
    return onLeft(_left);
  }
}

class Right<L, R> extends Either<L, R> {
  Right(R value) : super._right(value);

  @override
  bool operator ==(Object other) {
    return other is Right && other._right == _right;
  }

  @override
  int get hashCode => _right.hashCode + super.hashCode;

  @override
  B fold<B>(B Function(L left) onLeft, B Function(R right) onRight) {
    return onRight(_right);
  }
}
