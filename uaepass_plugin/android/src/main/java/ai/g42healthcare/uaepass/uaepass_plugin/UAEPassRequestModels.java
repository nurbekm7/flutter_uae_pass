package ai.g42healthcare.uaepass.uaepass_plugin;

import static ae.sdg.libraryuaepass.business.Environment.PRODUCTION;
import static ae.sdg.libraryuaepass.business.Environment.QA;
import static ae.sdg.libraryuaepass.business.Environment.STAGING;

import android.content.Context;
import android.content.pm.PackageManager;

import java.io.File;
import java.util.Objects;

import ae.sdg.libraryuaepass.business.Environment;
import ae.sdg.libraryuaepass.business.authentication.model.UAEPassAccessTokenRequestModel;
import ae.sdg.libraryuaepass.business.documentsigning.model.DocumentSigningRequestParams;
import ae.sdg.libraryuaepass.business.documentsigning.model.UAEPassDocumentDownloadRequestModel;
import ae.sdg.libraryuaepass.business.documentsigning.model.UAEPassDocumentSigningRequestModel;
import ae.sdg.libraryuaepass.business.profile.model.UAEPassProfileRequestModel;
import ae.sdg.libraryuaepass.utils.Utils;

/**
 * Created by Farooq Arshed on 12/11/18.
 */
public class UAEPassRequestModels {


    //TODO move all values to config
    //UAE PASS START -- ADD BELOW FIELDS
    private static final String UAE_PASS_CLIENT_ID = "sandbox_stage";//todo
    private static final String UAE_PASS_CLIENT_SECRET = "sandbox_stage";
    private static final String REDIRECT_URL = "flutter_uae_pass://success";//todo this can be wrong
    private static final Environment UAE_PASS_ENVIRONMENT = STAGING;

    //UAE PASS END -- ADD BELOW FIELDS

    private static final String DOCUMENT_SIGNING_SCOPE = "urn:safelayer:eidas:sign:process:document";
    private static final String RESPONSE_TYPE = "code";
    private static final String SCOPE = "urn:uae:digitalid:profile";
    private static final String ACR_VALUES_MOBILE = "urn:digitalid:authentication:flow:mobileondevice";
    private static final String ACR_VALUES_WEB = "urn:safelayer:tws:policies:authentication:level:low";
    private static final String UAE_PASS_PACKAGE_ID = "ae.uaepass.mainapp";
    private static final String UAE_PASS_QA_PACKAGE_ID = "ae.uaepass.mainapp.qa";
    private static final String UAE_PASS_STG_PACKAGE_ID = "ae.uaepass.mainapp.stg";

    private static final String SCHEME = "flutter_uae_pass";
    private static final String FAILURE_HOST = "failure";
    private static final String SUCCESS_HOST = "success";
    private static final String STATE = Utils.INSTANCE.generateRandomString(24);

    private static Context content;
    private static boolean isPackageInstalled(PackageManager packageManager) {

        String packageName = null;
        if (UAEPassRequestModels.UAE_PASS_ENVIRONMENT == PRODUCTION) {
            packageName = UAE_PASS_PACKAGE_ID;
        } else if (UAEPassRequestModels.UAE_PASS_ENVIRONMENT == STAGING) {
            packageName = UAE_PASS_STG_PACKAGE_ID;
        } else if (UAEPassRequestModels.UAE_PASS_ENVIRONMENT == QA) {
            packageName = UAE_PASS_QA_PACKAGE_ID;
        }

        boolean found = true;
        try {
            packageManager.getPackageInfo(packageName, 0);
        } catch (PackageManager.NameNotFoundException e) {
            found = false;
        }
        return found;
    }

    public static UAEPassAccessTokenRequestModel getAuthenticationRequestModel(Context context) {
        
        String ACR_VALUE = "";
        if (isPackageInstalled(context.getPackageManager())) {
            ACR_VALUE = ACR_VALUES_MOBILE;
        } else {
            ACR_VALUE = ACR_VALUES_WEB;
        }
        System.out.println("ACR_VALUE: " + ACR_VALUE);
        return new UAEPassAccessTokenRequestModel(
                UAE_PASS_ENVIRONMENT,
                UAE_PASS_CLIENT_ID,
                UAE_PASS_CLIENT_SECRET,
                SCHEME,
                FAILURE_HOST,
                SUCCESS_HOST,
                REDIRECT_URL,
                SCOPE,
                RESPONSE_TYPE,
                ACR_VALUE,
                STATE
        );
    }

    public static UAEPassProfileRequestModel getProfileRequestModel(Context context) {
        String ACR_VALUE = "";
        if (isPackageInstalled(context.getPackageManager())) {
            ACR_VALUE = ACR_VALUES_MOBILE;
        } else {
            ACR_VALUE = ACR_VALUES_WEB;
        }

        return new UAEPassProfileRequestModel(
                UAE_PASS_ENVIRONMENT,
                UAE_PASS_CLIENT_ID,
                UAE_PASS_CLIENT_SECRET,
                SCHEME,
                FAILURE_HOST,
                SUCCESS_HOST,
                REDIRECT_URL,
                SCOPE,
                RESPONSE_TYPE,
                ACR_VALUE,
                STATE);
    }
      
}

