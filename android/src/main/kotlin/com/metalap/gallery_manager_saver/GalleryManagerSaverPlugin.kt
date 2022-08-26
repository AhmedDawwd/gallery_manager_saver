package com.metalap.gallery_manager_saver

import android.app.Activity
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GalleryManagerSaverPlugin */
class GalleryManagerSaverPlugin: FlutterPlugin, MethodCallHandler , ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var galleryManagerSaver: GalleryManagerSaver? = null
  private  var manageStorageDirectories :ManageStorageDirectories?=null
  private  var filesUtils : FilesUtils? =null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "gallery_manager_saver")
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.KITKAT)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }

    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "saveImage" -> galleryManagerSaver?.checkPermissionAndSaveFile(call, result, MediaType.Image)
      "saveVideo" -> galleryManagerSaver?.checkPermissionAndSaveFile(call, result, MediaType.Video)
      "getExternalStorageDirectories" -> manageStorageDirectories?.getExternalStorageDirectories()
      "getExternalStorageDefaultDirectoriesPath" -> manageStorageDirectories?.getExternalStorageDefaultDirectoriesPath(call)
      "getPathAlbum" -> manageStorageDirectories?.getPathAlbum(call)
      "getPathFileInAlbum" -> manageStorageDirectories?.getPathFileInAlbum(call)
      "createAlbum" -> manageStorageDirectories?.createAlbum(call)
      "hasExternalStorageDirectoryWithPath" -> manageStorageDirectories?.hasExternalStorageDirectoryWithPath(call)
      "hasExternalStorageFileWithPath" -> manageStorageDirectories?.hasExternalStorageFileWithPath(call)
      "hasExternalStoragePrivateFile" -> manageStorageDirectories?.hasExternalStoragePrivateFile(call)
      "getAlbumFolderPath" -> filesUtils?.getAlbumFolderPathWithCall(call)
      else -> result.notImplemented()
    }
  }



  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity
    galleryManagerSaver = GalleryManagerSaver(activity!!)
    binding.addRequestPermissionsResultListener(galleryManagerSaver!!)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    print("onDetachedFromActivityForConfigChanges")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    print("onReattachedToActivityForConfigChanges")
  }

  override fun onDetachedFromActivity() {
    print("onDetachedFromActivity")
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
