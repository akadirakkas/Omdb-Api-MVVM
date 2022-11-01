//
//  MainViewController.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {

    let viewModel = MainViewModel(state: .init())
    let router = MainRouter()
    var testData = ["asdasd","asdasd","asdasd","asdasd","asdasd","asdasd","asdasd","asdasd","asdasd"]
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var indicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: .zero, type: .ballPulseSync, color: Theme.color.accent , padding: 0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        setupUI()
        configureViewModel()
        viewModel.searchMovie()
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
        tableView.rowHeight = 80

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
        
    }

    private func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                case .reloadData:
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesTest.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier , for: indexPath) as! MainTableViewCell
        cell.movieNameLabel.text = viewModel.moviesTest[indexPath.row].title
        cell.selectionStyle = .none
        cell.backgroundColor = indexPath.row % 2 != 0 ? UIColor(named: "Cell1Bg") : UIColor(named: "Cell2Bg")
        return cell
    }
    
}
// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.routeToDetail(movieId: viewModel.moviesTest[indexPath.row].imdbID!)
    }
    
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text, !searchBarText.isEmpty  else { return }
        viewModel.searchQuery  = searchBarText
        viewModel.searchMovie()
    }
}
