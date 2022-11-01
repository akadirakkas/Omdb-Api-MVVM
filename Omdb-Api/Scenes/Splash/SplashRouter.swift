//
//  SplashRouter.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import UIKit

class SplashRouter: BaseRouter {
    
    weak var viewController: UIViewController?
    
    func routeToMain() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc = MainViewController()
            let nav = BaseNavigationController(rootViewController: vc)
            self.viewController?.present(nav, animated: true)
        }
    }
    
}
