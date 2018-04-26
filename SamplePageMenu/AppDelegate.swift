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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var customizedLaunchScreenView: UIView?

    var window: UIWindow?
     

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        FirebaseApp.configure()
     
        let notificationTypes : UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let notificationsettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerForRemoteNotifications()
        application.registerUserNotificationSettings(notificationsettings)
        
        
        
        
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
        
        
  
        
       lunchScreenView()
        

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
    
    
    func lunchScreenView(){
        
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
                
    var str = "Jesus answered, “I am the way and the truth and the life. No one comes to the Father except through me."
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
                
    var str = "Jesus answered, “I am the way and the truth and the life. No one comes to the Father except through me."
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
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print("MessageID : \(userInfo["gcd_message_ID"]!)")
        print(userInfo)
    }

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

