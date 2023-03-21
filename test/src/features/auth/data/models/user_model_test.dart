import 'package:flutter_test/flutter_test.dart';
import 'package:video_monitoring_seventh/src/features/auth/data/models/user_model.dart';

void main() {
  final tModel = UserModel(
    id: '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
    username: 'candidato-seventh',
    password: '8n5zSrYq',
  );

  const tJson = '{"username":"candidato-seventh","password":"8n5zSrYq"}';

  final tMap = {
    'username': 'candidato-seventh',
    'password': '8n5zSrYq',
  };

  test(
    'Given a UserModel when toMap method is called then return a '
    'Map<String, dynamic>',
    () {
      // ACT
      final modelMap = tModel.toMap();

      // ASSERT
      expect(
        modelMap,
        equals(tMap),
      );
    },
  );

  test(
    'Given a UserModel when toJson is called then return a String',
    () {
      // ACT
      final modelJson = tModel.toJson();

      // ASSERT
      expect(modelJson, equals(tJson));
    },
  );

  test(
    'Given a Map when fromMap factory method is called then return a UserModel',
    () {
      // ACT
      final model = UserModel.fromMap(tMap);

      // ASSERT
      expect(model, equals(tModel));
    },
  );

  test(
    'Given a Json when fromJson factory method is called then return a '
    'UserModel',
    () {
      // ACT
      final model = UserModel.fromJson(tJson);

      // ASSERT
      expect(model, equals(tModel));
    },
  );

  test(
    'Given a UserModel when toString method is called then return a String '
    'with the UserModel proprerties',
    () {
      // ACT
      final modelToString = tModel.toString();

      // ASSERT
      expect(
        modelToString,
        equals(
          '''UserModel(id: 1cc32bc3-e419-4c36-bca5-1015c5bd68e5, username: candidato-seventh, password: 8n5zSrYq)''',
        ),
      );
    },
  );
}
