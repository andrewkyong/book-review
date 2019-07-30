//
//  AppDelegate.swift
//  BaseExam
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        let vc = BookListViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isTranslucent = false
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}
