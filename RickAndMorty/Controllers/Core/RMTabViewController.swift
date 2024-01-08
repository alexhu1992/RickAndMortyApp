//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import UIKit

final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }

    private func setupView() {
        let cv = RMCharacterViewController()
        let lv = RMLocationViewController()
        let ev = RMEpisodeViewController()
        let sv = RMSettingsViewController()
        
        
        let nav1 = UINavigationController(rootViewController: cv)
        let nav2 = UINavigationController(rootViewController: lv)
        let nav3 = UINavigationController(rootViewController: ev)
        let nav4 = UINavigationController(rootViewController: sv)
        
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "location"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv.circle.fill"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}
