//
//  Assembly.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainVC() -> UIViewController
    func createCards() -> UIViewController
    func createSlider( words: [Word], lesson: Lesson) -> UIViewController
    func createWorkout() -> UIViewController
    func createProfile() -> UIViewController
    func createAboutUs() -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    
    var tabBarCnt =  UITabBarController()
    let dataManager = DataManager()
    
    func createMainVC() -> UIViewController{
        let attrs = [
              NSAttributedString.Key.foregroundColor: UIColor.white,
              NSAttributedString.Key.font: UIFont(name: "Rockwell-Bold", size: 30)
          ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        let tabBarCnt =  UITabBarController()
        tabBarCnt.tabBar.barStyle = .default
        let cardsVC = createCards()
        let cardsTabBarItem = UITabBarItem(title: "Карточки", image: UIImage(named: "cards"), tag: 0)
        cardsVC.tabBarItem = cardsTabBarItem
        let workoutVC = createWorkout()
        let workoutTabBarItem = UITabBarItem(title: "Тренировка", image: UIImage(named: "workout"), tag: 1)
        workoutVC.tabBarItem = workoutTabBarItem
        let profileVc =  createProfile()
        let profileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 2)
        profileVc.tabBarItem =  profileTabBarItem
        tabBarCnt.viewControllers = [cardsVC, workoutVC,profileVc]
        return tabBarCnt
    }
    
    func createCards() -> UIViewController {
        let view = CardsViewController()
        let navigationController = UINavigationController(rootViewController: view)
        let router = CardsRouter(navigationContoller: navigationController, assemblyBuilder: self)
        let presenter = CardsPresenter(view: view,router: router)
        view.presenter = presenter
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
    
    func createWorkout() -> UIViewController {
        let view = WorkoutViewController()
        let navigationController = UINavigationController(rootViewController: view)
        let router = CardsRouter(navigationContoller: navigationController, assemblyBuilder: self)
        let presenter = CardsPresenter(view: view, router: router)
        view.presenter = presenter
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
    
    func createSlider(words: [Word], lesson: Lesson) -> UIViewController {
        let view = SliderViewController()
        let presenter = SliderPresenter(view: view, words: words, lesson: lesson)
        view.presenter = presenter
        return view
    }
    
    func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createAboutUs() -> UIViewController {
        let view = AboutUsViewController()
        let networkService = NetworkService()
        let presenter = AboutUsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
