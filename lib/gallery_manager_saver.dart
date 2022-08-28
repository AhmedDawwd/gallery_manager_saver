import 'files.dart';
import 'gallery_manager_saver_platform_interface.dart';

class GalleryManagerSaver {
  Future<String?> getPlatformVersion() {
    return GalleryManagerSaverPlatform.instance.getPlatformVersion();
  }

  Future<List<String>> getExternalStorageDirectories() async {
    return await GalleryManagerSaverPlatform.instance
        .getExternalStorageDirectories();
  }

  Future<String> getExternalStorageDefaultDirectoriesPath(
      {required Environment environment}) async {
    return await GalleryManagerSaverPlatform.instance
        .getExternalStorageDefaultDirectoriesPath(
            getEnvironmentDir(environment));
  }

  Future<bool?> createAlbum({
    required String albumName,
    required Environment environment,
  }) async {
    return await GalleryManagerSaverPlatform.instance.createAlbum(
        albumName: albumName, albumType: getEnvironmentDir(environment));
  }

  Future<String?> getPathAlbum({
    required String albumName,
    required Environment environment,
  }) async {
    return await GalleryManagerSaverPlatform.instance.getPathAlbum(
        albumName: albumName, albumType: getEnvironmentDir(environment));
  }

  Future<String?> getPathFileInAlbum(
      {required String albumName,
      required Environment environment,
      required String fileName}) async {
    return await GalleryManagerSaverPlatform.instance.getPathFileInAlbum(
        albumName: albumName,
        albumType: getEnvironmentDir(environment),
        fileName: fileName);
  }

  Future<bool?> saveVideo(
    String path, {
    String? albumName,
    bool? toDcim = false,
    bool? toMovies = true,
    bool? toPictures = false,
    Map<String, String>? headers,
  }) async {
    if (toDcim!) {
      toMovies = false;
      toPictures = false;
    } else if (toMovies!) {
      toDcim = false;
      toPictures = false;
    } else if (toPictures!) {
      toMovies = false;
      toDcim = false;
    } else if (!toDcim && !toMovies && !toPictures) {
      toDcim = true;
      toMovies = false;
      toPictures = false;
    }

    return await GalleryManagerSaverPlatform.instance.saveVideo(path,
        albumName: albumName,
        toDcim: toDcim,
        toMovies: toMovies,
        toPictures: toPictures,
        headers: headers);
  }

  Future<bool?> saveImage(
    String path, {
    String? albumName,
    bool? toDcim = false,
    bool? toMovies = false,
    bool? toPictures = true,
    Map<String, String>? headers,
  }) async {
    if (toDcim!) {
      toMovies = false;
      toPictures = false;
    } else if (toMovies!) {
      toDcim = false;
      toPictures = false;
    } else if (toPictures!) {
      toMovies = false;
      toDcim = false;
    } else if (!toDcim && !toMovies && !toPictures) {
      toDcim = false;
      toMovies = false;
      toPictures = true;
    }
    return await GalleryManagerSaverPlatform.instance.saveImage(path,
        albumName: albumName,
        toDcim: toDcim,
        toMovies: toMovies,
        toPictures: toPictures,
        headers: headers);
  }

  Future<bool?> hasExternalStorageDirectoryWithPath({
    required Environment environment,
  }) async {
    return await GalleryManagerSaverPlatform.instance
        .hasExternalStorageDirectoryWithPath(
            albumType: getEnvironmentDir(environment));
  }

  Future<bool?> hasExternalStorageFileWithPath({
    required String albumName,
    required Environment environment,
  }) async {
    return await GalleryManagerSaverPlatform.instance
        .hasExternalStorageFileWithPath(
            albumName: albumName, albumType: getEnvironmentDir(environment));
  }

  Future<bool?> hasExternalStoragePrivateFile({
    required String albumName,
    required Environment environment,
  }) async {
    return await GalleryManagerSaverPlatform.instance
        .hasExternalStoragePrivateFile(
            albumName: albumName, albumType: getEnvironmentDir(environment));
  }

  Future<String?> getAlbumFolderPathWithCall({
    required String albumName,
    bool? toDcim = false,
    bool? toMovies = false,
    bool? toPictures = false,
  }) async {
    return await GalleryManagerSaverPlatform.instance
        .getAlbumFolderPathWithCall(
      albumName: albumName,
      toDcim: toDcim,
      toMovies: toMovies,
      toPictures: toPictures,
    );
  }
}
