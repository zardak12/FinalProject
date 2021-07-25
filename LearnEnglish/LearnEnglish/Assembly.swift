//
//  Assembly.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

  // MARK: - AssemblyBuilderProtocol
protocol AssemblyBuilderProtocol {
    func createMainVC() -> UIViewController
    func createCards() -> UIViewController
    func createWorkout() -> UIViewController
    func createProfile() -> UIViewController
    func createAboutUs() -> UIViewController
    func createSlider(with navigationContoller: UINavigationController,
                      lesson: Lesson) -> UIViewController
    func createSettings(words: [Word], lesson: Lesson,
                        delegate: UpdateCollectionViewDelegate) -> UIViewController
    func createTraining(with words: [Word]) -> UIViewController
}

  // MARK: - AssemblyBuilder
final class AssemblyBuilder: AssemblyBuilderProtocol {

    var tabBarCnt = UITabBarController()

    func createMainVC() -> UIViewController {
        let attrs = [
              NSAttributedString.Key.foregroundColor: UIColor.white,
              NSAttributedString.Key.font: UIFont(name: "Rockwell-Bold", size: 30)
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs as [NSAttributedString.Key: Any]
        let tabBarCnt = UITabBarController()
        tabBarCnt.tabBar.barStyle = .default
        let cardsVC = createCards()
        let cardsTabBarItem = UITabBarItem(title: "Карточки", image: UIImage(named: "cards"), tag: 0)
        cardsVC.tabBarItem = cardsTabBarItem
        let workoutVC = createWorkout()
        let workoutTabBarItem = UITabBarItem(title: "Тренировка", image: UIImage(named: "workout"), tag: 1)
        workoutVC.tabBarItem = workoutTabBarItem
        let profileVc = createProfile()
        let profileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 2)
        profileVc.tabBarItem = profileTabBarItem
        tabBarCnt.viewControllers = [cardsVC, workoutVC, profileVc]
        return tabBarCnt
    }

    func createCards() -> UIViewController {
        let view = CardsViewController()
        let navigationController = UINavigationController(rootViewController: view)
        let router = MenuRouter(navigationContoller: navigationController, assemblyBuilder: self)
        let stack = Container.shared.coreDataStack
        let coreDataService = CoreDataService(stack: stack)
        let presenter = CardsPresenter(view: view, router: router, coreDataService: coreDataService)
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
        let router = MenuRouter(navigationContoller: navigationController, assemblyBuilder: self)
        let stack = Container.shared.coreDataStack
        let coreDataService = CoreDataService(stack: stack)
        let presenter = CardsPresenter(view: view, router: router, coreDataService: coreDataService)
        view.presenter = presenter
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }

    func createSlider(with navigationContoller: UINavigationController,
                      lesson: Lesson) -> UIViewController {
        let view = SliderViewController()
        let router = SliderRouter(navigationContoller: navigationContoller, assemblyBuilder: self)
        let stack = Container.shared.coreDataStack
        let coreDataService = CoreDataService(stack: stack)
        let presenter = SliderPresenter(view: view, lesson: lesson, router: router, coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }

    func createSettings(words: [Word], lesson: Lesson,
                        delegate: UpdateCollectionViewDelegate) -> UIViewController {
        let view = SettingsViewController()
        let stack = Container.shared.coreDataStack
        let coreDataService = CoreDataService(stack: stack)
        let presenter = SettingsPresenter(view: view, words: words, lesson: lesson,
                                          delegate: delegate, coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }

    func createTraining(with words: [Word]) -> UIViewController {
        let view = TrainingViewController()
        let presenter = TrainingPresenter(view: view, words: words)
        view.presenter = presenter
        return view
    }

    func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter(assemblyBuilder: self, view: view)
        let presenter = ProfilePresenter(view: view, with: router)
        view.presenter = presenter
        return view
    }

    func createAboutUs() -> UIViewController {
        let view = AboutUsViewController()
        let networkService = NetworkService()
        let router = ProfileRouter(assemblyBuilder: self, view: view)
        let presenter = AboutUsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
