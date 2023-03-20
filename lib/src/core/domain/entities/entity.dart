import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import 'package:video_monitoring_seventh/src/core/error/failure.dart';

@immutable
abstract class Entity<T> {
  final String id;

  const Entity({
    required this.id,
  });

  Either<Failure, Unit> validate();

  @override
  bool operator ==(covariant Entity<T> other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
