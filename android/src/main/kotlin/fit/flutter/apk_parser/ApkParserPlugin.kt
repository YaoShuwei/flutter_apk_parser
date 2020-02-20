package fit.flutter.apk_parser

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import net.dongliu.apk.parser.ApkFile
import net.dongliu.apk.parser.bean.IconFace
import java.io.File
import java.util.*
import kotlin.collections.ArrayList

/** ApkParserPlugin */
public class ApkParserPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "apk_parser")
    channel.setMethodCallHandler(ApkParserPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "apk_parser")
      channel.setMethodCallHandler(ApkParserPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "apkParse") {
      val filePath : String?= call.argument("path");
      val apkFile = ApkFile(File(filePath));
      apkFile.preferredLocale = Locale.SIMPLIFIED_CHINESE;
      val apkMeta = apkFile.apkMeta
      val apkInfo: HashMap<String, Any?>? = HashMap()
      apkInfo!!["label"]=apkMeta.label;
      apkInfo["name"]=apkMeta.name;
      apkInfo["packageName"]=apkMeta.packageName;
      apkInfo["versionCode"]=apkMeta.versionCode;
      apkInfo["versionName"]=apkMeta.versionName;
      val iconFaces: List<IconFace> = apkFile.allIcons;
      val iconDatas = ArrayList<ByteArray>(iconFaces.size)
//      val icons = ArrayList<String>(iconDatas.size)
      for(icon in iconFaces){
        val index = iconFaces.indexOf(icon)
        iconDatas.add(icon.data);
      }
      apkInfo["iconDatas"]=iconDatas;
      apkFile.close();
      result.success(apkInfo);
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}
