import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class EmptyUsernameFailure extends Failure {
  const EmptyUsernameFailure({
    super.message = 'O campo usuário é obrigatório.',
  });
}

class EmptyPasswordFailure extends Failure {
  const EmptyPasswordFailure({
    super.message = 'O campo senha é obrigatório.',
  });
}

class OfflineFailure extends Failure {
  const OfflineFailure({
    super.message = 'Erro ao se conectar, verifique sua conexão!',
  });
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({
    super.message = 'Erro na requisição, tente novamente!',
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Erro ao salvar localmente, verifique seu armazenamento!',
  });
}
