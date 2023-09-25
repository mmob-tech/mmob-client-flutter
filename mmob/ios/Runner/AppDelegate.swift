import UIKit
import SwiftUI
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var navigationController: UINavigationController!
  let METHOD_CHANNEL_NAME = "com.client.mmob/methodChannel"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

              
    linkNativeCode(controller: controller)
      
      
    self.navigationController = UINavigationController(rootViewController: controller)
    self.window.rootViewController = self.navigationController
    self.navigationController.setNavigationBarHidden(false, animated: false)
    self.window.makeKeyAndVisible()
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}


extension AppDelegate {
    
    func linkNativeCode(controller: FlutterViewController) {
        setupMethodChannelForMmobBoot(controller: controller)
    }
    
    private func setupMethodChannelForMmobBoot(controller: FlutterViewController) {
        
        let methodChannel = FlutterMethodChannel.init(name: self.METHOD_CHANNEL_NAME, binaryMessenger:controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler { (call, result) in
            
            if call.method == "boot" {
                let vc = UIStoryboard.init(name: "Main", bundle: .main)
                    .instantiateViewController(withIdentifier: "MmobViewController") as! MmobViewController
                
                self.navigationController.pushViewController(vc, animated: true)
            }
            if call.method == "passData" {
                if let arguments = call.arguments as? [String: Any],
                   let integrationConfiguration = arguments["integration_configuration"] as? [String: Any],
                   let customerInfo = arguments["customer_info"] as? [String: Any] {
//                    print(arguments)
                    // Now you can work with the data from Flutter
                    print("Received cpid: \(integrationConfiguration["cp_id"] ??  "test"), firstName: \(customerInfo["first_name"] ?? "")")
                    
                    // Perform any native iOS actions with the data here.
                    
                    result(nil)
                } else {
                    result(FlutterError(code: "Invalid arguments", message: nil, details: nil))
                }
            }
            
            func getMessage(result: FlutterResult){
                let message = "HI FROM IOS"
                
                result(message)
            }
        }
    }}


