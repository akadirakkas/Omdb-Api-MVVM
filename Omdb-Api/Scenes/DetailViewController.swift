//
//  DetailViewController.swift
//  Omdb-Api
//
//  Created by kadir on 1.11.2022.
//

import UIKit

class DetailViewController: BaseViewController {

    let viewModel : DetailViewModel
    let router = DetailRouter()
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var writersLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    // MARK: - Initialization
    init(movieId: String) {
        self.viewModel = DetailViewModel(state: .init(moviId: movieId))
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
        viewModel.movieDetail()
    }

    // MARK: - Setup

    private func setupUI() {
        movieImage.layer.cornerRadius = 12
        movieImage.layer.masksToBounds = true
    }
    
    func configureUI() {
        movieNameLabel.text = viewModel.moveDetail.title
        synopsisLabel.text = viewModel.moveDetail.plot
        actorsLabel.text = viewModel.moveDetail.actors
        writersLabel.text = viewModel.moveDetail.writer
        movieImage.sd_setImage(
            with: URL(string: viewModel.moveDetail.poster!),
            placeholderImage:  UIImage(named: "movie")
        )
    }

    private func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                case .fetchDetail:
                    self.configureUI()
                    FirebaseManager.shared.logFilmDetails(
                        title: self.viewModel.moveDetail.title ?? "",
                        year: self.viewModel.moveDetail.year ?? ""
                    )
                }
            }
        }
    }

}
