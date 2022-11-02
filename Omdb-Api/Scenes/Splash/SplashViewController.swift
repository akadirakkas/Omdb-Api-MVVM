//
//  SplashViewController.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import UIKit
import Loaf
import NVActivityIndicatorView

class SplashViewController: UIViewController {
    
    let viewModel = SplashViewModel(state:.init())
    let router = SplashRouter()
    
    private var indicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: .red , padding: 0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - IBOutlets
    @IBOutlet weak var remoteLabel: UILabel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        setupUI()
        configureViewModel()
        viewModel.startMonitoring()
        viewModel.confgiureRemoteConfig()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = Theme.color.accent
        remoteLabel.backgroundColor = Theme.color.background
        remoteLabel.textColor = Theme.color.textColor
        remoteLabel.layer.masksToBounds = true
        remoteLabel.layer.cornerRadius = 5
        
        self.view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 60),
            indicator.heightAnchor.constraint(equalToConstant: 60),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        self.navigationItem.title = "OMDB"
       
    }
    
    private func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                    
                case .connected:
                    Loaf(
                        "Internet connection is on.",
                        state: .custom(.init(backgroundColor: .blue)),
                        sender: self
                    ).show()
                case .noConnect:
                    Loaf(
                        "There's no internet connection.",
                        state: .custom(.init(backgroundColor: .red)),
                        sender: self
                    ).show()
                case .fetchingRemote:
                    self.indicator.startAnimating()
                case .fetchedRemote:
                    Loaf.dismiss(sender: self)
                    self.indicator.stopAnimating()
                    self.remoteLabel.text = self.viewModel.remoteText
                    self.router.routeToMain()
                  
                }
            }
        }
    }
    
}
