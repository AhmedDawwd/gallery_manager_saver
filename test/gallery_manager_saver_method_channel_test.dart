import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_manager_saver/gallery_manager_saver_method_channel.dart';

void main() {
  MethodChannelGalleryManagerSaver platform = MethodChannelGalleryManagerSaver();
  const MethodChannel channel = MethodChannel('gallery_manager_saver');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
