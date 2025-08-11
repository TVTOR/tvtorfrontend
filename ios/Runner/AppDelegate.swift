import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        //FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // This method will be called when app received push notifications in foreground
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
}
