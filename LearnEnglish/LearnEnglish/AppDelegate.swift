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

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let assembly = AssemblyBuilder()
    let networkService = NetworkService()
    let stack = Container.shared.coreDataStack
    let dataService = DataService(networkService: networkService, stack: stack)
    let startRouter = StartRouter(assembly: assembly, dataService: dataService)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = startRouter.getStartViewController()
    window?.makeKeyAndVisible()
    return true
  }
}
