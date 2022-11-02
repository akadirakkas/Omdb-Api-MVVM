//
//  MainViewController.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import UIKit
import NVActivityIndicatorView
import Loaf

class MainViewController: UIViewController {

    let viewModel = MainViewModel(state: .init())
    let router = MainRouter()
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var indicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(
            frame: .zero,
            type: .ballPulseSync,
            color: Theme.color.indicator ,
            padding: 0
        )
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        setupUI()
        configureViewModel()
    }

    // MARK: - Setup

    private func setupUI() {
        tableView.layer.cornerRadius = 18
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.register(
            MainTableViewCell.nib(),
            forCellReuseIdentifier: MainTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
      
        searchBar.searchTextField.textColor = Theme.color.textColor
        searchBar.barTintColor = Theme.color.accent
        view.backgroundColor = Theme.color.accent
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 60),
            indicator.heightAnchor.constraint(equalToConstant: 60),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        self.navigationItem.title = "Movies"
        self.indicator.startAnimating()
    }

    private func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                case .showIndicator:
                    self.indicator.startAnimating()
                case .hideIndicator:
                    self.indicator.stopAnimating()
                case .reloadData:
                    self.tableView.reloadData()
                case .noMovie:
                    Loaf(
                        "Upps Something wrong.",
                        state: .custom(.init(backgroundColor: .red)),
                        location: .top,
                        sender: self
                    ).show()
                }
            }
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier , for: indexPath) as! MainTableViewCell
        cell.configure(with: viewModel.moviesList[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = indexPath.row % 2 != 0 ? UIColor(named: "Cell1Bg") : UIColor(named: "Cell2Bg")
        return cell
    }
    
}
// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.routeToDetail(movieId: viewModel.moviesList[indexPath.row].imdbID!)
        FirebaseManager.shared.logFilmDetails(
            title: viewModel.moviesList[indexPath.row].title ?? "",
            year: viewModel.moviesList[indexPath.row].year ?? ""
        )
    }
    
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
      

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text, !searchBarText.isEmpty  else { return }
        viewModel.searchQuery = searchBarText
        viewModel.searchMovie()
        self.searchBar.endEditing(true)
        
    }
    
}
