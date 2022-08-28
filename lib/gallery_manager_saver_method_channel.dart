import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'files.dart';
import 'gallery_manager_saver_platform_interface.dart';

/// An implementation of [GalleryManagerSaverPlatform] that uses method channels.
class MethodChannelGalleryManagerSaver extends GalleryManagerSaverPlatform {
  String pleaseProvidePath = 'Please provide valid file path.';
  String fileIsNotVideo = 'File on path is not a video.';
  String fileIsNotImage = 'File on path is not an image.';

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gallery_manager_saver');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<String>> getExternalStorageDirectories() async {
    final List externalStorageDirs =
        await methodChannel.invokeMethod('getExternalStorageDirectories');

    List<String> storageInfos = externalStorageDirs
        .map((storageInfoMap) => ExStoragePath01.getRootDir(storageInfoMap))
        .toList();
    return storageInfos;
  }

  @override
  Future<String> getExternalStorageDefaultDirectoriesPath(
      String albumType) async {
    return await methodChannel.invokeMethod(
        'getExternalStorageDefaultDirectoriesPath', {'albumType': albumType});
  }

  @override
  Future<bool?> createAlbum({
    String? albumName,
    String? albumType,
  }) async {
    return await methodChannel.invokeMethod(
        'createAlbum', {'albumName': albumName, 'albumType': albumType});
  }

  @override
  Future<String?> getPathAlbum({
    String? albumName,
    String? albumType,
  }) async {
    return await methodChannel.invokeMethod(
        'getPathAlbum', {'albumName': albumName, 'albumType': albumType});
  }

  @override
  Future<String?> getPathFileInAlbum(
      {String? albumName, String? albumType, String? fileName}) async {
    return await methodChannel.invokeMethod('getPathFileInAlbum',
        {'albumName': albumName, 'albumType': albumType, 'fileName': fileName});
  }

  @override
  Future<bool?> saveImage(
    String path, {
    String? albumName,
    bool? toDcim = false,
    bool? toMovies = false,
    bool? toPictures = false,
    Map<String, String>? headers,
  }) async {
    File? tempFile;
    if (path.isEmpty) {
      throw ArgumentError(pleaseProvidePath);
    }
    if (!isImage(path)) {
      throw ArgumentError(fileIsNotImage);
    }
    // if (!isLocalFilePath(path)) {
    //   tempFile = await _downloadFile(path, headers: headers);
    //   path = tempFile.path;
    // }

    bool? result = await methodChannel.invokeMethod(
      'saveImage',
      <String, dynamic>{
        'path': path,
        'albumName': albumName,
        'toDcim': toDcim,
        'toMovies': toMovies,
        'toPictures': toPictures,
      },
    );
    if (tempFile != null) {
      tempFile.delete();
    }

    return result;
  }

  ///saves video from provided temp path and optional album name in gallery
  @override
  Future<bool?> saveVideo(
    String path, {
    String? albumName,
    bool? toDcim = false,
    bool? toMovies = false,
    bool? toPictures = false,
    Map<String, String>? headers,
  }) async {
    File? tempFile;
    if (path.isEmpty) {
      throw ArgumentError(pleaseProvidePath);
    }
    if (!isVideo(path)) {
      throw ArgumentError(fileIsNotVideo);
    }
    // if (!isLocalFilePath(path)) {
    //   tempFile = await _downloadFile(path, headers: headers);
    //   path = tempFile.path;
    // }
    bool? result = await methodChannel.invokeMethod(
      'saveVideo',
      <String, dynamic>{
        'path': path,
        'albumName': albumName,
        'toDcim': toDcim,
        'toMovies': toMovies,
        'toPictures': toPictures,
      },
    );
    if (tempFile != null) {
      tempFile.delete();
    }
    return result;
  }

  @override
  Future<bool?> hasExternalStorageDirectoryWithPath({String? albumType}) async {
    return await methodChannel.invokeMethod(
        'hasExternalStorageDirectoryWithPath', {'albumType': albumType});
  }

  @override
  Future<bool?> hasExternalStorageFileWithPath(
      {String? albumName, String? albumType}) async {
    return await methodChannel.invokeMethod('hasExternalStorageFileWithPath',
        {'albumName': albumName, 'albumType': albumType});
  }

  @override
  Future<bool?> hasExternalStoragePrivateFile(
      {String? albumName, String? albumType}) async {
    return await methodChannel.invokeMethod('hasExternalStoragePrivateFile',
        {'albumName': albumName, 'albumType': albumType});
  }

  @override
  Future<String?> getAlbumFolderPathWithCall({
    String? albumName,
    bool? toDcim = false,
    bool? toMovies = false,
    bool? toPictures = false,
  }) async {
    return await methodChannel.invokeMethod('getAlbumFolderPathWithCall', {
      'albumName': albumName,
      'toDcim': toDcim,
      'toMovies': toMovies,
      'toPictures': toPictures,
    });
  }

  // Future<File> downloadFile(String url, {Map<String, String>? headers}) async {
  //   print(url);
  //   print(headers);
  //   http.Client _client = new http.Client();
  //   var req = await _client.get(Uri.parse(url), headers: headers);
  //   if (req.statusCode >= 400) {
  //     throw HttpException(req.statusCode.toString());
  //   }
  //   var bytes = req.bodyBytes;
  //   String dir = (await getTemporaryDirectory()).path;
  //   File file = File('$dir/${basename(url)}');
  //   await file.writeAsBytes(bytes);
  //   print('File size:${await file.length()}');
  //   print(file.path);
  //   return file;
  // }

}

class ExStoragePath01 {
  static String getRootDir(String appFilesDir) {
    return appFilesDir
        .split("/")
        .sublist(0, appFilesDir.split("/").length - 4)
        .join("/");
  }
}
