import Flutter
import UIKit
import Paldesk

public class SwiftFlutterPaldeskPlugin: NSObject, FlutterPlugin {
    private static let METHOD_INIT = "init"
    private static let METHOD_START_CONVERSATION = "startConversation"
    private static let METHOD_CLEAR = "clear"
    private static let METHOD_CREATE_ANONYMOUS_CLIENT = "createAnonymousClient"
    private static let METHOD_CREATE_CLIENT = "createClient"
    private let registrar: FlutterPluginRegistrar
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_paldesk", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterPaldeskPlugin(registrar: registrar)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    private var vc: UIViewController {
        get {
            return UIApplication.shared.keyWindow!.rootViewController!
        }
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case SwiftFlutterPaldeskPlugin.METHOD_INIT:
            let arguments = call.arguments as! [String: Any]
            let apiKey = arguments["apiKey"] as! String
            PaldeskSDK.initialize(apiKey: apiKey);
            result(true)
            break;
        case SwiftFlutterPaldeskPlugin.METHOD_START_CONVERSATION:
            PaldeskSDK.startConversation(viewController: vc)
            result(true)
            break;
        case SwiftFlutterPaldeskPlugin.METHOD_CLEAR:
            PaldeskSDK.clear()
            result(true)
            break;
        case SwiftFlutterPaldeskPlugin.METHOD_CREATE_ANONYMOUS_CLIENT:
            PaldeskSDK.createAnonymousClient()
            result(true)
            break;
        case SwiftFlutterPaldeskPlugin.METHOD_CREATE_CLIENT:
            let arguments = call.arguments as! [String: Any]
            let email = arguments["email"] as! String
            let externalId = arguments["externalId"] as! String
            let firstName = arguments["firstName"] as! String
            let lastName = arguments["lastName"] as! String
            result(true)
            break;
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            break;
        default:
            result(false)
        }
    }
}
