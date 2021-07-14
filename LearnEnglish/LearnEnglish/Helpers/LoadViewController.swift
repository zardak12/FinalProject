//
//  LoadViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 2/7/21.
//

import UIKit

final class LoadViewController: UIViewController {
    var tabBarCnt =  UITabBarController()
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.load()
        setFontNavigationBar()
        tabBarCnt.tabBar.barStyle = .default
        let vc1 = UINavigationController(rootViewController: AssemblyBuilder().createCards())
        let cardsTabBarItem = UITabBarItem(title: "Карточки", image: UIImage(named: "cards"), tag: 0)
        vc1.tabBarItem = cardsTabBarItem
        vc1.navigationBar.tintColor = UIColor.white
        vc1.navigationBar.barStyle = .black
        vc1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc1.navigationBar.shadowImage = UIImage()
        vc1.navigationBar.isTranslucent = true
        let vc2 = UINavigationController(rootViewController: AssemblyBuilder().createWorkout())
        let workoutTabBarItem = UITabBarItem(title: "Тренировка", image: UIImage(named: "workout"), tag: 1)
        vc2.tabBarItem = workoutTabBarItem
        vc2.navigationBar.tintColor = UIColor.white
        vc2.navigationBar.barStyle = .black
        vc2.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc2.navigationBar.shadowImage = UIImage()
        vc2.navigationBar.isTranslucent = true
        let vc3 = AssemblyBuilder().createProfile()
        let profileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 2)
        vc3.tabBarItem =  profileTabBarItem
        tabBarCnt.viewControllers = [vc1, vc2,vc3]
        self.view.addSubview(tabBarCnt.view)
    }
    
    func setFontNavigationBar() {
        let attrs = [
              NSAttributedString.Key.foregroundColor: UIColor.white,
              NSAttributedString.Key.font: UIFont(name: "Rockwell-Bold", size: 30)
          ]
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
}
