import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rz_library_utilities/rz_library_utilities_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRzLibraryUtilities platform = MethodChannelRzLibraryUtilities();
  const MethodChannel channel = MethodChannel('rz_library_utilities');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
