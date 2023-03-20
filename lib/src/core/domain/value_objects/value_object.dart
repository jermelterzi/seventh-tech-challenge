import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/error/failure.dart';

@immutable
abstract class ValueObject<T> {
  final T value;

  const ValueObject({required this.value});

  Either<Failure, Unit> validate();

  @override
  bool operator ==(covariant ValueObject<T> other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
