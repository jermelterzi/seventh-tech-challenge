import 'package:flutter_test/flutter_test.dart';
import 'package:video_monitoring_seventh/src/core/network/seventh_response.dart';

void main() {
  test(
    'equality',
    () async {
      const response =
          SeventhResponse(statusCode: 200, body: '{"return": "test"}');

      expect(
        response,
        equals(
          const SeventhResponse(statusCode: 200, body: '{"return": "test"}'),
        ),
      );
    },
  );
}
