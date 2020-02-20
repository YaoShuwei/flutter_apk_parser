import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apk_parser/apk_parser.dart';

void main() {
  const MethodChannel channel = MethodChannel('apk_parser');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {});
}
