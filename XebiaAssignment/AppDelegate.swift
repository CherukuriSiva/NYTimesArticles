//
//  AppDelegate.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 31/03/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let homeVC = navigationController.topViewController as! HomeViewController
        homeVC.viewModel = HomeViewModelFactory.create()
        window?.rootViewController = navigationController
        return true
    }
}

