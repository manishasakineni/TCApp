//
//  AppDelegate.swift
//  SamplePageMenu
//
//  Created by Mac OS on 05/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//import FBSDKLoginKit
//import FacebookCore
//import Google
//import GoogleSignIn
//import FBSDKLoginKit
import SystemConfiguration
import Localize
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var customizedLaunchScreenView: UIView?

    var window: UIWindow?
    var messge : String = ""
    
    var isFirstTime : Bool!

     var countryInfoDetails : [splashmsgResultVO] = Array<splashmsgResultVO>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        isFirstTime = true
        
        IQKeyboardManager.sharedManager().enable = true
    
        FirebaseApp.configure()
  
         //   IQKeyboardManager.sharedManager().toolbarTintColor = UIColor.red
//        let notificationTypes : UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
//        let notificationsettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
//        application.registerForRemoteNotifications()
//        application.registerUserNotificationSettings(notificationsettings)
//        
        
        if #available(iOS 10, *) {
            
            //Notifications get posted to the function (delegate):  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void)"
            
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                
                guard error == nil else {
                    //Display Error.. Handle Error.. etc..
                    return
                }
                
                if granted {
                    //Do stuff here..
                    // For iOS 10 display notification (sent via APNS)
                    UNUserNotificationCenter.current().delegate = self
                    //FIRMessaging.messaging().remoteMessageDelegate = self
                    
                    //Register for RemoteNotifications. Your Remote Notifications can display alerts now :)
                    application.registerForRemoteNotifications()
                }
                else {
                    //Handle user denying permissions..
                }
            }
            
            //Register for remote notifications.. If permission above is NOT granted, all notifications are delivered silently to AppDelegate.
        }
        else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        
        printFCMToken()
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotificaiton),
                                               name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
        let localize = Localize.shared
        localize.update(provider: .json)
        localize.update(fileName: "lang")
        print(localize.language())
        print(localize.availableLanguages())
       // IQKeyboardManager.sharedManager().accessibilityElementsHidden = false
      // Override point for customization after application launch.
     //   if UserDefaults.standard.value(forKey: KFirstTimeLogin) as? String == "true" {
            UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
            UserDefaults.standard.synchronize()
            let homeNav : SWRevealViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.window?.rootViewController = homeNav
        
        
      getsplashmsgAPICall()
        
    //   lunchScreenView()
        
     //   }
            
//        else{
//            
//          //  let launchNav : LaunchScreenViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreenViewController") as! LaunchScreenViewController
//          //  self.window?.rootViewController = launchNav
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let desController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
//            desController.showNav = false
//            let newController = UINavigationController.init(rootViewController:desController)
//            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootloginVC") as! UINavigationController
//            appDelegate.window?.rootViewController = newController
//            lunchScreenView()
//        }
        
               return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // receiving FCM token
        
        
        
        Messaging.messaging().apnsToken = deviceToken
        
           }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
        print("i am not available in simulator \(error)")
    }
    
    
    func printFCMToken() {
        if let token = InstanceID.instanceID().token() {
            
            print("Your FCM token is \(token)")
            
            kUserDefaults.setValue(token, forKey: "DeviceID")
            kUserDefaults.synchronize()
        } else {
            print("You don't yet have an FCM token.")
        }
    }
    
    func tokenRefreshNotificaiton(_ notification: Foundation.Notification)
    {
        // Refreshing FCM token
        
        if let refreshedToken = InstanceID.instanceID().token()
        {
            UserDefaults.standard.setValue(refreshedToken, forKey: "DeviceID")
            UserDefaults.standard.synchronize()
            debugPrint("InstanceID token: \(refreshedToken)")
        }
        connectToFcm()
    }
    func connectToFcm()
    {
        // Won't connect since there is no token
        guard InstanceID.instanceID().token() != nil else
        {
            return;
        }
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().disconnect()
        Messaging.messaging().connect { (error) in
            if (error != nil)
            {
                debugPrint("Unable to connect with FCM. \(String(describing: error))")
            }
            else
            {
                debugPrint("Connected to FCM.")
            }
        }
    }
    
    
    
    // MARK: - Check Internet Connectivity
    
    func checkInternetConnectivity() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
 
    func getsplashmsgAPICall() {
        
        serviceController.getRequest(strURL: GETSPLASHMSGAPI , success: { (result) in
            
            
            let respVO:splashmsgInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.result!
                let desc = listArr.desc!
                self.lunchScreenView(desc)
                
       
                
            }
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    
    

    
    
    func lunchScreenView(_ text : String){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            
            // customized launch screen
    if let window = self.window {
    self.customizedLaunchScreenView = UIView(frame: window.bounds)
         self.customizedLaunchScreenView?.backgroundColor = UIColor.white
//    self.customizedLaunchScreenView?.backgroundColor = UIColor(red: 103.0/255.0, green: 171.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        
    self.window?.makeKeyAndVisible()
                
    var imageView : UIImageView
    imageView  = UIImageView(frame: window.bounds)
    imageView.image = UIImage(named:"Church-logo")
    let codedLabel:UILabel = UILabel()
        
        imageView.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 3.5, y: (customizedLaunchScreenView?.frame.size.height)! / 4, width: 400, height: 400)
        
        codedLabel.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 7, y: (customizedLaunchScreenView?.frame.size.height)! / 2, width: imageView.frame.size.width + 130, height: imageView.frame.size.height)
        
                
    codedLabel.textAlignment = .center
    var stringCount : Double = 0.0
                
    var str = text
    stringCount = Double(str.characters.count)
    print(str.characters.count)
    codedLabel.animate(newText:str, characterDelay: 0.05)
    codedLabel.numberOfLines = 0
    codedLabel.textColor = UIColor.black
    codedLabel.font = UIFont.systemFont(ofSize: 20)
                
        self.customizedLaunchScreenView?.addSubview(imageView)
        self.customizedLaunchScreenView?.addSubview(codedLabel)
        self.window?.addSubview(self.customizedLaunchScreenView!)
        self.window?.bringSubview(toFront: self.customizedLaunchScreenView!)
        UIView.animate(withDuration: 0.2, delay: (stringCount) * 0.1 , options: .curveEaseOut,
        animations: { () -> Void in
        self.customizedLaunchScreenView?.alpha = 0 },
        completion: { _ in
        self.customizedLaunchScreenView?.removeFromSuperview() })
            }
        }
        else {
            
            
            
    if let window = self.window {
    self.customizedLaunchScreenView = UIView(frame: window.bounds)
    self.customizedLaunchScreenView?.backgroundColor = UIColor.white
        
    self.window?.makeKeyAndVisible()
                
    var imageView : UIImageView
    imageView  = UIImageView(frame: window.bounds)
    imageView.image = UIImage(named:"Church-logo")
    let codedLabel:UILabel = UILabel()
                
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height
                
    switch height {
    case 480.0:
      print("iPhone 3,4")
                    
                  
    case 568.0:
        print("iPhone 5")
                    
    imageView.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 4, y: (customizedLaunchScreenView?.frame.size.height)! / 4, width: 200, height: 200)
    codedLabel.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 9, y: (customizedLaunchScreenView?.frame.size.height)! / 2, width: imageView.frame.size.width + 50, height: imageView.frame.size.height)
                    
                    
    case 667.0:
        
       print("iPhone 6")
                    
    imageView.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 4, y: (customizedLaunchScreenView?.frame.size.height)! / 4, width: 200, height: 200)
                    
    codedLabel.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 9, y: (customizedLaunchScreenView?.frame.size.height)! / 2, width: imageView.frame.size.width + 100, height: imageView.frame.size.height)
                  
                    
        case 736.0:
        print("iPhone 6+")
                   
        imageView.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 4, y: (customizedLaunchScreenView?.frame.size.height)! / 4, width: 200, height: 200)
                    
        codedLabel.frame = CGRect(x: (customizedLaunchScreenView?.frame.size.width)!  / 9, y: (customizedLaunchScreenView?.frame.size.height)! / 2, width: imageView.frame.size.width + 130, height: imageView.frame.size.height)

        
        case 1024.0:
        print("iPadAir")
   
        
        default:
        print("not an iPhone")
        
        }

     
        
        
        
    codedLabel.textAlignment = .center
    var stringCount : Double = 0.0
                
    var str = text
    stringCount = Double(str.characters.count)
    print(str.characters.count)
    codedLabel.animate(newText:str, characterDelay: 0.05)
    codedLabel.numberOfLines=0
    codedLabel.textColor=UIColor.black
    codedLabel.font=UIFont.systemFont(ofSize: 12)
                
    self.customizedLaunchScreenView?.addSubview(imageView)
    self.customizedLaunchScreenView?.addSubview(codedLabel)
    self.window?.addSubview(self.customizedLaunchScreenView!)
    self.window?.bringSubview(toFront: self.customizedLaunchScreenView!)
    UIView.animate(withDuration: 1, delay: (stringCount + 0.2) * 0.1 , options: .curveEaseOut,
    animations: { () -> Void in
    self.customizedLaunchScreenView?.alpha = 0 },
    completion: { _ in
    self.customizedLaunchScreenView?.removeFromSuperview() })
            }
        }
        
        
    }
    
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        
//        print("MessageID : \(userInfo["gcd_message_ID"]!)")
//        print(userInfo)
//    }

}


extension String {
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UILabel {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.characters.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
            self.text?.append(character)
                }
            }
        }
}
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        print("aps: \(userInfo)")
        // Showing notification in a popup
        completionHandler([.badge, .alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Called to let your app know which action was selected by the user for a given notification.
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        
//        // Print all of userInfo
//        for (key, value) in userInfo {
//            print("userInfo: \(key) —> value = \(value)")
//        }
//        
//        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
//            // Default printout of info = userInfo["aps"]
//            print("All of info: \n\(info)\n")
//            
//            for (key, value) in info {
//                print("APS: \(key) —> \(value)")
//            }
//            
//            
//            if  let myType = info["type"] as? String {
//                // Printout of (userInfo["aps"])["type"]
//                print("\nFrom APS-dictionary with key \"type\":  \( myType)")
//                
//                // Do your stuff?
//            }
//        }
//    
        
        
        if let currentNavigationController = UIApplication.shared.delegate?.window??.rootViewController as? SWRevealViewController {
            
            let roootNavigation = currentNavigationController.frontViewController as? UINavigationController
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            
            
            let allOrdersDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "VideoSongsViewController") as! VideoSongsViewController
            
            allOrdersDetailsVC.catgoryID = 8
            
            
            roootNavigation?.pushViewController(allOrdersDetailsVC, animated: true)
            
            
        }
        
   
        completionHandler()
    }
    
    
    
}
