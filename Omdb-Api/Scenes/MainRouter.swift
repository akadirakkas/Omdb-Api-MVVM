//
//  MainRouter.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import UIKit

class MainRouter: BaseRouter {

    weak var viewController: UIViewController?
    func routeToDetail(movieId: String) {
        let vc = DetailViewController(movieId: movieId)
            let nav = BaseNavigationController(rootViewController: vc)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
