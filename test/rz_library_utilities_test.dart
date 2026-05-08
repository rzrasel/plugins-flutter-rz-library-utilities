import 'package:flutter_test/flutter_test.dart';
import 'package:rz_library_utilities/rz_library_utilities.dart';
import 'package:rz_library_utilities/rz_library_utilities_platform_interface.dart';
import 'package:rz_library_utilities/rz_library_utilities_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRzLibraryUtilitiesPlatform
    with MockPlatformInterfaceMixin
    implements RzLibraryUtilitiesPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RzLibraryUtilitiesPlatform initialPlatform = RzLibraryUtilitiesPlatform.instance;

  test('$MethodChannelRzLibraryUtilities is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRzLibraryUtilities>());
  });

  test('getPlatformVersion', () async {
    //RzLibraryUtilities rzLibraryUtilitiesPlugin = RzLibraryUtilities();
    MockRzLibraryUtilitiesPlatform fakePlatform = MockRzLibraryUtilitiesPlatform();
    RzLibraryUtilitiesPlatform.instance = fakePlatform;

    //expect(await rzLibraryUtilitiesPlugin.getPlatformVersion(), '42');
  });
}
