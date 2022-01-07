//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Юрий Егоров on 05.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LocationService.shared.updateLocation()
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController:mainViewController)
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        return true
    }


}

