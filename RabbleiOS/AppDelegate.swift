//
//  AppDelegate.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getRootVC()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func getRootVC() -> UIViewController {
        let vc = InviteCodeBuilder.createVC()
        return UINavigationController(rootViewController: vc)
    }


}

