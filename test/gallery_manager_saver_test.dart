import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_manager_saver/gallery_manager_saver.dart';
import 'package:gallery_manager_saver/gallery_manager_saver_platform_interface.dart';
import 'package:gallery_manager_saver/gallery_manager_saver_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGalleryManagerSaverPlatform
    with MockPlatformInterfaceMixin
    implements GalleryManagerSaverPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> createAlbum({String? albumName, String? albumType}) {
    // TODO: implement createAlbum
    throw UnimplementedError();
  }

  @override
  Future<String> getExternalStorageDefaultDirectoriesPath(String albumType) {
    // TODO: implement getExternalStorageDefaultDirectoriesPath
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getExternalStorageDirectories() {
    // TODO: implement getExternalStorageDirectories
    throw UnimplementedError();
  }

  @override
  Future<String?> getPathAlbum({String? albumName, String? albumType}) {
    // TODO: implement getPathAlbum
    throw UnimplementedError();
  }

  @override
  Future<String?> getPathFileInAlbum(
      {String? albumName, String? albumType, String? fileName}) {
    // TODO: implement getPathFileInAlbum
    throw UnimplementedError();
  }

  @override
  Future<bool?> hasExternalStorageDirectoryWithPath({String? albumType}) {
    // TODO: implement hasExternalStorageDirectoryWithPath
    throw UnimplementedError();
  }

  @override
  Future<bool?> hasExternalStorageFileWithPath(
      {String? albumName, String? albumType}) {
    // TODO: implement hasExternalStorageFileWithPath
    throw UnimplementedError();
  }

  @override
  Future<bool?> hasExternalStoragePrivateFile(
      {String? albumName, String? albumType}) {
    // TODO: implement hasExternalStoragePrivateFile
    throw UnimplementedError();
  }

  @override
  Future<bool?> saveImage(String path,
      {String? albumName,
      bool? toDcim,
      bool? toMovies,
      bool? toPictures,
      Map<String, String>? headers}) {
    // TODO: implement saveImage
    throw UnimplementedError();
  }

  @override
  Future<bool?> saveVideo(String path,
      {String? albumName,
      bool? toDcim,
      bool? toMovies,
      bool? toPictures,
      Map<String, String>? headers}) {
    // TODO: implement saveVideo
    throw UnimplementedError();
  }

  @override
  Future<String?> getAlbumFolderPathWithCall(
      {String? albumName, bool? toDcim, bool? toMovies, bool? toPictures}) {
    // TODO: implement getAlbumFolderPathWithCall
    throw UnimplementedError();
  }
}

void main() {
  final GalleryManagerSaverPlatform initialPlatform =
      GalleryManagerSaverPlatform.instance;

  test('$MethodChannelGalleryManagerSaver is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGalleryManagerSaver>());
  });

  test('getPlatformVersion', () async {
    GalleryManagerSaver galleryManagerSaverPlugin = GalleryManagerSaver();
    MockGalleryManagerSaverPlatform fakePlatform =
        MockGalleryManagerSaverPlatform();
    GalleryManagerSaverPlatform.instance = fakePlatform;

    expect(await galleryManagerSaverPlugin.getPlatformVersion(), '42');
  });
}
