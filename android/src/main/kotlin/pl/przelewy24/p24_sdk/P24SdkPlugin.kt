package pl.przelewy24.p24_sdk

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

/** P24SdkPlugin */
public class P24SdkPlugin: FlutterPlugin, ActivityAware {

  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    val binaryMessenger = flutterPluginBinding.binaryMessenger

    MethodChannel(binaryMessenger, "p24_sdk")
            .setMethodCallHandler(MethodCallsHandler(binding, flutterPluginBinding.binaryMessenger))
    MethodChannel(binaryMessenger, "p24_sdk/sdk_config")
            .setMethodCallHandler(SdkConfigMethodCallsHandler())
    MethodChannel(binaryMessenger, "p24_sdk/p24_sdk_version")
            .setMethodCallHandler(P24SdkVersionCallsHandler())
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onDetachedFromActivity() {}

}
