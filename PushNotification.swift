//
//  PushNotification.swift
//  
//
//  Created by Ossama Abdelwahab on 17/12/20.
//

import Foundation
import UserNotificationsUI

// #1 set the UNUserNotificationCenterDelegate
// # 2 set the delegate in didFinishLaunchingWithOptions
// # 3 create two func
1- userNotificationCenter "willPresent"
2- userNotificationCenter "didReceive"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate /*#1*/ {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //#2
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    // #3 userNotificationCenter "willPresent"
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // add completionHandler
        completionHandler([.alert,.badge,.sound])
        
    }
    
    // #3 userNotificationCenter "didReceive"
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // create userIfo to get notification details es"id,title,description...."
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        if let data = (userInfo["custom"] as? [String:Any])? ["a"] as? [String:Any] {
            let id = data["id"] as? String ?? "0"
            let category = data["category"] as? String ?? ""
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeNavigation = mainStoryboard.instantiateViewController(withIdentifier: "homeNavigation") as! UINavigationController
            let notificationController = mainStoryboard.instantiateViewController(withIdentifier: "NotificheController") as! UINavigationController
            
                //homeNavigation.pushViewController(notificationController, animated: false)
                // u can use pushViewController but you should comment *
                UIApplication.shared.keyWindow?.rootViewController = homeNavigation
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                homeNavigation.present(notificationController, animated: false, completion: nil) // To commet #*#
            
        }
        
        completionHandler()
    }
    
    
    
    
}
