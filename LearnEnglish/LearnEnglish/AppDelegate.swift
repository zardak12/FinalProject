//
//  AppDelegate.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let dataManager = DataManager()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    dataManager.load()
    let assembly = AssemblyBuilder()
    let router = StartRouter(assembly: assembly)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = router.getStartViewController()
    window?.makeKeyAndVisible()
    return true
  }
}

