package ai.g42healthcare.uaepass.uaepass_plugin;

import androidx.annotation.NonNull;
import android.os.Bundle;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.content.Intent;

//new imports
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import android.app.Activity;
import android.content.Context;
import android.widget.Toast;
import android.util.Log;
import java.lang.String;

//UAE Pass imports
import ae.sdg.libraryuaepass.UAEPassAccessCodeCallback;
import ae.sdg.libraryuaepass.UAEPassAccessTokenCallback;
import ae.sdg.libraryuaepass.UAEPassController;
import ae.sdg.libraryuaepass.UAEPassDocumentDownloadCallback;
import ae.sdg.libraryuaepass.UAEPassDocumentSigningCallback;
import ae.sdg.libraryuaepass.UAEPassProfileCallback;
import ae.sdg.libraryuaepass.business.authentication.model.UAEPassAccessTokenRequestModel;
import ae.sdg.libraryuaepass.business.documentsigning.model.DocumentSigningRequestParams;
import ae.sdg.libraryuaepass.business.documentsigning.model.UAEPassDocumentDownloadRequestModel;
import ae.sdg.libraryuaepass.business.documentsigning.model.UAEPassDocumentSigningRequestModel;
import ae.sdg.libraryuaepass.business.profile.model.ProfileModel;
import ae.sdg.libraryuaepass.business.profile.model.UAEPassProfileRequestModel;
import ae.sdg.libraryuaepass.utils.FileUtils;
import ae.sdg.libraryuaepass.business.Environment;
import android.webkit.CookieManager;
import android.webkit.ValueCallback;
import io.flutter.embedding.android.FlutterActivity;
// import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;

/** UaepassPlugin */
public class UaepassPlugin extends FlutterActivity implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity = null;
  private Context context;
  private Result result;

  private String accessToken;
  private String accessCode;
  private String name;
  private String eid;


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Intent intent = getIntent();
    String action = intent.getAction();
    String type = intent.getType();

    System.out.println("onCreate: intent: " + intent.getData());
    System.out.println("onCreate: action: " + action);
    System.out.println("onCreate: type: " + type);

    // if (Intent.ACTION_SEND.equals(action) && type != null) {
    //   if ("text/plain".equals(type)) {
    //     handleSendText(intent); // Handle text being sent
    //   }
    // }
  }


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "uaepass_plugin");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    setResult(result);
    switch (call.method) {
      // case "logout":
      //   logout();
      //   break;
      case "login":
        System.out.println("method call login: " + call.method);
        login();
        break;
      case "logout":
        logout();
        break;
      default:
        System.out.println("method call default: " + call.method);
        result.notImplemented();
        break;
    }
  }

//  @Override
//  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
//    channel.setMethodCallHandler(null);
//  }
  ///new overrides

  @Override
  public void onDetachedFromEngine(FlutterPlugin.FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }
  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }
  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }
  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  private void login() {
    UAEPassAccessTokenRequestModel requestModel = UAEPassRequestModels.getAuthenticationRequestModel(context);
    System.out.println("UAEPassAccessTokenRequestModel: " + requestModel);
    UAEPassController.INSTANCE.getAccessToken(activity, requestModel, new UAEPassAccessTokenCallback() {
        @Override
        public void getToken(String accessToken, String state, String error) {
          System.out.println("getToken: " + accessToken);
            if (error != null) {
              System.out.println("failed auth uae pass");
            } else {
              System.out.println("success auth uae pass");
              setAccessToken(accessToken);
              getProfile();
            }
        }
    });
    
}


  private void logout(){
    clearData();
  }

private void getProfile() {
  UAEPassProfileRequestModel requestModel = UAEPassRequestModels.getProfileRequestModel(context);
        UAEPassController.INSTANCE.getUserProfile(activity, requestModel, new UAEPassProfileCallback() {

            @Override
            public void getProfile(ProfileModel profileModel, String state, String error) {
                if (error != null) {
                  // getResult().success("");
                } else {

                  String name = profileModel.getFirstnameEN() + " " + profileModel.getLastnameEN();
                  String eid = profileModel.getIdn();
                  String JSON_STRING = "{\"fullname\":\""+ name+"\",\"eid\":\""+eid+"\", \"accesscode\":\""+getAccessToken()+"\"}";
                  getResult().success(JSON_STRING);
                }
            }
        });
}


private void clearData() {
  
  CookieManager.getInstance().removeAllCookies(new ValueCallback<Boolean>() {
      @Override
      public void onReceiveValue(Boolean value) {
        getResult().success("1");
      }
  });
  CookieManager.getInstance().flush();
}

public String getAccessToken() {
  return accessToken;
}

public void setAccessToken(String accessToken) {
  this.accessToken = accessToken;
}

public Result getResult() {
  return result;
}

public void setResult(Result result) {
  this.result = result;
}
}
