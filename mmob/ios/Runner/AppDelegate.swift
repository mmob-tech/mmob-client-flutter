import UIKit
import MmobClient
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
      
    GeneratedPluginRegistrant.register(with: self)

    self.navigationController = UINavigationController(rootViewController: controller)
    self.window.rootViewController = self.navigationController
    self.navigationController.setNavigationBarHidden(false, animated: false)
    self.window.makeKeyAndVisible()
      
      
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
                if let arguments = call.arguments as? [String: Any]{
                    // Now you can work with the data from Flutter
                    // Perform any native iOS actions with the data here.
                    struct MmobView: UIViewControllerRepresentable {
                        var arguments: [String: Any]!
                        func makeUIViewController(context: Context) -> MmobViewController {
                            let ViewController = MmobViewController()
                            ViewController.arguments=arguments
                            return ViewController
                        }

                        func updateUIViewController(_ uiViewController: MmobViewController, context: Context) {
                            // Updates the state of the specified view controller with new information from SwiftUI.
                        }
                    }
                    if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                       let viewController = keyWindow.rootViewController {
                        let swiftUIView = MmobView(arguments: arguments)
                        let hostingController = UIHostingController(rootView: swiftUIView)
                        viewController.present(hostingController, animated: true, completion: nil)
                        result(nil)
                    }
                } else {
                    result(FlutterError(code: "Invalid arguments", message: nil, details: nil))
                }
            }
        }
    }}


