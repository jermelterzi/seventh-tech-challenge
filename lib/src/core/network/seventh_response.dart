import 'package:equatable/equatable.dart';

class SeventhResponse extends Equatable {
  final int statusCode;
  final String body;

  const SeventhResponse({
    required this.statusCode,
    required this.body,
  });

  @override
  List<Object?> get props => [
        statusCode,
        body,
      ];
}
