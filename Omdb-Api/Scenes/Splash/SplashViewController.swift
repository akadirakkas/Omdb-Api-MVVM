//
//  SplashViewController.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import UIKit

class SplashViewController: UIViewController {

    let viewModel = SplashViewModel(state: .init())
    let router = SplashRouter()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        setupUI()
        configureViewModel()
    }

    // MARK: - Setup

    private func setupUI() {

    }

    private func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                // TODO: 
            }
        }
    }

}