//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setNavigationBarAppearance()
        setCoordinator()
        return true
    }

    private func setCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
        MainCoordinator(navigationController).routeTo(target: .mainList)
    }
    
    func setNavigationBarAppearance() {
        if #available(iOS 13, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor.black
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor = UIColor.black
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
            UITabBar.appearance().standardAppearance = tabBarApperance
        }
    }
}

