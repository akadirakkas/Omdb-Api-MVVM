//
//  DetailViewController.swift
//  Omdb-Api
//
//  Created by kadir on 1.11.2022.
//

import UIKit

class DetailViewController: BaseViewController {

    let viewModel = DetailViewModel(state: .init())
    let router = DetailRouter()
    private(set) var movieId: String 
    
    // MARK: - IBOutlets
    @IBOutlet weak var testLabel: UILabel!
    
    
    // MARK: - Initialization
    init(movieId: String) {
        self.movieId = movieId
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        setupUI()
        configureViewModel()
       print("movieee id is: \(movieId)")
    }

    // MARK: - Setup

    private func setupUI() {

    }

    private func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                case .fetchDetail:
                    self.testLabel.text = self.viewModel.moveDetail.title
                    FirebaseManager.shared.logFilmDetails(
                        title: self.viewModel.moveDetail.title ?? "",
                        year: self.viewModel.moveDetail.year ?? ""
                    )
                }
            }
        }
    }

}
