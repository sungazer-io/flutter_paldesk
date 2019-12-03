package io.sungazer.flutter_paldesk;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.paldesk.paldesksdk.*;
import com.paldesk.paldesksdk.ui.chat.PDChatActivity;
import com.paldesk.paldesksdk.ui.register.PDRegisterActivity;

/** FlutterPaldeskPlugin */
public class FlutterPaldeskPlugin implements MethodCallHandler {
  private final Application application;

  private static final String METHOD_INIT = "init";
  private static final String METHOD_START_CONVERSATION = "startConversation";
  private static final String METHOD_CLEAR = "clear";
  private static final String METHOD_CREATE_ANONYMOUS_CLIENT = "createAnonymousClient";
  private static final String METHOD_CREATE_CLIENT = "createClient";


  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_paldesk");
    channel.setMethodCallHandler(new FlutterPaldeskPlugin((Application) registrar.context()));
  }

  private FlutterPaldeskPlugin(Application application) {
    this.application = application;
  }


  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case METHOD_INIT:
        final String apiKey = call.argument("apiKey");
        PaldeskSDK.init(this.application, apiKey, true);
        result.success(true);
        break;
      case METHOD_CLEAR:
        PaldeskSDK.clear();
        result.success(true);
        break;
      case METHOD_CREATE_ANONYMOUS_CLIENT:
        PaldeskSDK.createAnonymousClient();
        result.success(true);
        break;
      case METHOD_CREATE_CLIENT:
        final String email = call.argument("email");
        final String externalId = call.argument("externalId");
        final String firstName = call.argument("firstName");
        final String lastName = call.argument("lastName");
        ClientParams.Builder builder = new ClientParams.Builder(email, externalId);
        if (firstName != null) {
          builder.firstName(firstName);
        }
        if (lastName != null) {
          builder.lastName(lastName);
        }
        ClientParams clientParams = builder.build();
        PaldeskSDK.createClient(clientParams);
        result.success(true);
        break;
      case METHOD_START_CONVERSATION:
        if (PaldeskSDK.isInitialized()) {
          if (PaldeskSDK.getPdClientRepository().isClientRegistered()) {
            Intent intent = new Intent(this.application, PDChatActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            this.application.startActivity(intent);
          } else {
            Intent intent = new Intent(this.application, PDRegisterActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            this.application.startActivity(intent);
          }
          result.success(true);
        } else {
          Log.d("PaldeskSDK", "PaldeskSDK is not initialized. Please initialize PaldeskSDK by calling init() method");
          result.success(false);
        }
        break;
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
    }
//    if (call.method.equals("getPlatformVersion")) {
//      result.success("Android " + android.os.Build.VERSION.RELEASE);
//    } else {
//      result.notImplemented();
//    }
  }
}
