//
//  BaseNavigationController.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//


import UIKit

class BaseNavigationController: UINavigationController {

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .fullScreen }
        set {}
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup
    private func setup() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Theme.color.accent
            appearance.shadowColor = .clear

            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationBar.barTintColor = Theme.color.accent
            navigationBar.isTranslucent = false
        }
        navigationBar.tintColor = .white
    }

}
