//
//  MainTabBarController.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureAppearance()
        configureTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let items = tabBar.items else { return }
        items[0].title = "Меню"
        items[1].title = "Контаты"
        items[2].title = "Пофиль"
        items[3].title = "Корзина"
    }
    
    private func style() {
        view.backgroundColor = .white
    }
    
    private func configureAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        let navBarAppearance = UINavigationBarAppearance()
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    private func configureTabBarController() {
        let menuViewController = createNavController(
            viewController: MenuViewController(),
            itemImage: "fork.knife"
        )
        
        let contactsViewController = createNavController(
            viewController: ContactsViewController(),
            itemImage: "location.north.fill"
        )
        
        let profileViewController = createNavController(
            viewController: ProfileViewController(),
            itemImage: "person"
        )
        
        let trashViewController = createNavController(
            viewController: TrashViewController(),
            itemImage: "trash"
        )
        
        viewControllers = [menuViewController,
                           contactsViewController,
                           profileViewController,
                           trashViewController]
    }
    
    private func createNavController(
        viewController: UIViewController,
        itemImage: String
    ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(systemName: itemImage)
        tabBar.tintColor = .red
        return navController
    }
}

