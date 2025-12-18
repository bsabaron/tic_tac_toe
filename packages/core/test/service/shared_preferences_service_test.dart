import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/src/service/shared_preferences_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SharedPreferencesService', () {
    late SharedPreferencesService service;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      service = const SharedPreferencesService();
    });

    tearDown(() async {
      await prefs.clear();
    });

    test('should set and get string value', () async {
      const key = 'test_key';
      const value = 'test_value';

      await service.setString(key, value);
      final result = await service.getString(key);

      expect(result, value);
    });

    test('should return null when key does not exist', () async {
      const key = 'non_existent_key';

      final result = await service.getString(key);

      expect(result, isNull);
    });

    test('should overwrite existing string value', () async {
      const key = 'test_key';
      const initialValue = 'initial_value';
      const updatedValue = 'updated_value';

      await service.setString(key, initialValue);
      final initialResult = await service.getString(key);
      expect(initialResult, initialValue);

      await service.setString(key, updatedValue);
      final updatedResult = await service.getString(key);
      expect(updatedResult, updatedValue);
    });

    test('should remove key', () async {
      const key = 'test_key';
      const value = 'test_value';

      await service.setString(key, value);
      final beforeRemove = await service.getString(key);
      expect(beforeRemove, value);

      await service.remove(key);
      final afterRemove = await service.getString(key);
      expect(afterRemove, isNull);
    });

    test('should handle removing non-existent key', () async {
      const key = 'non_existent_key';

      await service.remove(key);
      final result = await service.getString(key);
      expect(result, isNull);
    });

    test('should handle multiple keys independently', () async {
      const key1 = 'key1';
      const key2 = 'key2';
      const value1 = 'value1';
      const value2 = 'value2';

      await service.setString(key1, value1);
      await service.setString(key2, value2);

      final result1 = await service.getString(key1);
      final result2 = await service.getString(key2);

      expect(result1, value1);
      expect(result2, value2);
    });

    test('should handle empty string value', () async {
      const key = 'empty_key';
      const value = '';

      await service.setString(key, value);
      final result = await service.getString(key);

      expect(result, value);
    });
  });
}
