//
//  BaseRouter.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//


import UIKit

protocol BaseRouter {
    associatedtype VC: UIViewController
    var viewController: VC? { get set }
}

extension BaseRouter {

    func back(animated: Bool = true) {
        viewController?.navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool = true) {
        viewController?.dismiss(animated: animated)
    }

}
