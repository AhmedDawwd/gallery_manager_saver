import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gallery_manager_saver_method_channel.dart';

abstract class GalleryManagerSaverPlatform extends PlatformInterface {
  /// Constructs a GalleryManagerSaverPlatform.
  GalleryManagerSaverPlatform() : super(token: _token);

  static final Object _token = Object();

  static GalleryManagerSaverPlatform _instance =
      MethodChannelGalleryManagerSaver();

  /// The default instance of [GalleryManagerSaverPlatform] to use.
  ///
  /// Defaults to [MethodChannelGalleryManagerSaver].
  static GalleryManagerSaverPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GalleryManagerSaverPlatform] when
  /// they register themselves.
  static set instance(GalleryManagerSaverPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>> getExternalStorageDirectories() {
    throw UnimplementedError(
        'getExternalStorageDirectories() has not been implemented.');
  }

  Future<String> getExternalStorageDefaultDirectoriesPath(String albumType) {
    throw UnimplementedError(
        'getExternalStorageDefaultDirectoriesPath() has not been implemented.');
  }

  Future<bool?> hasExternalStoragePrivateFile({
    String? albumName,
    String? albumType,
  }) {
    throw UnimplementedError(
        'hasExternalStoragePrivateFile() has not been implemented.');
  }

  Future<bool?> hasExternalStorageFileWithPath({
    String? albumName,
    String? albumType,
  }) {
    throw UnimplementedError(
        'hasExternalStorageFileWithPath() has not been implemented.');
  }

  Future<bool?> hasExternalStorageDirectoryWithPath({
    String? albumType,
  }) {
    throw UnimplementedError(
        'hasExternalStorageDirectoryWithPath() has not been implemented.');
  }

  Future<bool?> createAlbum({
    String? albumName,
    String? albumType,
  }) {
    throw UnimplementedError('createAlbum() has not been implemented.');
  }

  Future<String?> getPathAlbum({
    String? albumName,
    String? albumType,
  }) {
    throw UnimplementedError('getPathAlbum() has not been implemented.');
  }

  Future<String?> getPathFileInAlbum(
      {String? albumName, String? albumType, String? fileName}) {
    throw UnimplementedError('getPathFileInAlbum() has not been implemented.');
  }

  Future<bool?> saveVideo(
    String path, {
    String? albumName,
    String? albumType,
    bool? toDcim,
    Map<String, String>? headers,
  }) {
    throw UnimplementedError('saveVideo() has not been implemented.');
  }

  Future<bool?> saveImage(
    String path, {
    String? albumName,
    String? albumType,
    bool? toDcim,
    Map<String, String>? headers,
  }) {
    throw UnimplementedError('saveImage() has not been implemented.');
  }

  Future<String?> getAlbumFolderPathWithCall({
    String? albumName,
    String? albumType,
    bool? toDcim,
  }) {
    throw UnimplementedError(
        'getAlbumFolderPathWithCall() has not been implemented.');
  }
}
