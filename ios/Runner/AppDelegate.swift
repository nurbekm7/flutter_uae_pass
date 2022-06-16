 import UIKit
 import Flutter
 import FirebaseCore
 import WebKit

//import FirebaseAuth



 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {

   private var flutterController: FlutterViewController!
   private var uaePassAccessToken: String!
   private var flutterResult: FlutterResult? = nil
     

   override func application(
     _ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
   ) -> Bool {
         FirebaseApp.configure()
        
       print("<><><><> start app")
       
       flutterController = window?.rootViewController as? FlutterViewController
     let uaepassChannel = FlutterMethodChannel(name: "uaepass_plugin", binaryMessenger: flutterController.binaryMessenger)
     
     uaepassChannel.setMethodCallHandler({
         [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
       // Note: this method is invoked on the UI thread.
         self?.flutterResult = result
       guard call.method == "login" || call.method == "logout" else {
           result(FlutterMethodNotImplemented)
         return
       }
         if (call.method == "login") {
             self?.loginUAEPass()
         } else if(call.method == "logout") {
             self?.logoutUAEPass()
             result("1")
         }
     })
       
       
   GeneratedPluginRegistrant.register(with: self)
   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
       

   }

     
     override func application(_: UIApplication, handleOpen url: URL) -> Bool {
         print("<><><><> appDelegate URL : \(url.absoluteString)")
         if url.absoluteString.contains(HandleURLScheme.externalURLSchemeSuccess()) {
             if let topViewController = UserInterfaceInfo.topViewController() {
                 if let webViewController = topViewController as? UAEPassWebViewController {
                     webViewController.forceReload()
                 }
             }
             return true
         }

         else if url.absoluteString.contains(HandleURLScheme.externalURLSchemeFail()) {
             guard let webViewController = UserInterfaceInfo.topViewController() as? UAEPassWebViewController  else {
                 return false
             }
             webViewController.foreceStop()
             let alertController = UIAlertController(title: "Failed to login with UAE PASS Login", message: "Try again later", preferredStyle: .actionSheet)
             let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                 _ in
                 NSLog("OK Pressed")
                 webViewController.navigationController?.popViewController(animated: true)
             }
             alertController.addAction(okAction)
             self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
             return false
         }

         return true
     }
     
     private func loginUAEPass() {
         UAEPASSRouter.shared.spConfig = SPConfig(redirectUriLogin: "https://g42healthcare.ai/",
                                                  scope: "urn:uae:digitalid:profile:general",
                                                  state: "12kdjwals31jf04ksxvao234",  //Randomly Generated Code 24 alpha numeric.
                                                  successSchemeURL: "flutter_uae_pass://success", //client success url scheme.
                                                  failSchemeURL: "flutter_uae_pass://failure", //client failure url scheme.
                                                  signingScope: "urn:safelayer:eidas:sign:process:document") // client signing scope.

         UAEPASSRouter.shared.environmentConfig = UAEPassConfig(clientID: "sandbox_stage", clientSecret: "sandbox_stage", env: .staging)
         
       
         print("LOGIN ios pressed")
         UAEPASSNetworkRequests.shared.getUAEPASSConfig(completion: {
             if let webVC = UAEPassWebViewController.instantiate() as? UAEPassWebViewController {
                 webVC.reloadwithURL(url: UAEPassConfiguration.getServiceUrlForType(serviceType: .loginURL))
                 webVC.onUAEPassSuccessBlock = { statusCode in
                     self.getUaePassTokenForCode(code: statusCode)
                 }
                 webVC.onUAEPassFailureBlock = { recv in
                     print(recv)
                 }
                 
                 self.flutterController.present(webVC, animated: true) {
                 }
             }
             
         })
     }
     
     private func logoutUAEPass() {
         print("LOGOUT pressed")
         URLCache.shared.removeAllCachedResponses()

        // Delete any associated cookies
         if let cookies = HTTPCookieStorage.shared.cookies {
             for cookie in cookies {
                 HTTPCookieStorage.shared.deleteCookie(cookie)
             }
         }

         HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
              print("[WebCacheCleaner] All cookies deleted")
              
              WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                  records.forEach { record in
                      WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                      print("[WebCacheCleaner] Record \(record) deleted")
                  }
              }
          
     }
     
     
     
     func getUaePassTokenForCode(code: String) {
         UAEPASSNetworkRequests.shared.getUAEPassToken(code: code, completion: { (uaePassToken) in
             self.uaePassAccessToken = uaePassToken?.accessToken ?? ""
             self.getUaePassProfileForToken()
         }) { (error) in
         }
     }
     
     func getUaePassProfileForToken() {
         UAEPASSNetworkRequests.shared.getUAEPassUserProfile(token: self.uaePassAccessToken, completion: { (userProfile) in
             if let userProfile = userProfile {
                 let firstName = userProfile.firstnameEN ?? ""
                 let lastName = userProfile.lastnameEN ?? ""
                 let eid = userProfile.idn ?? ""
                 let code = self.uaePassAccessToken ?? ""
                 var  JSON_STRING = "{\"fullname\":\"\(firstName) \(lastName)\",\"eid\":\"\(String(describing: eid))\",\"accesscode\":\"\(code)\"}"
                 self.flutterController.dismiss(animated: true, completion: nil)
                 self.flutterResult?(JSON_STRING)
             } else {
             }
         }) { (error) in
         }
     }
 }
