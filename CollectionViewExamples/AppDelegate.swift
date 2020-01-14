//
//  AppDelegate.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let rootViewController = MainViewController()
    rootViewController.navigationItem.title = "CV Examples"
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.navigationBar.prefersLargeTitles = true
    window = .init()
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }
}
