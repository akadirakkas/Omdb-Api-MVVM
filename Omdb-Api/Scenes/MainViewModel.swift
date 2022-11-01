//
//  MainViewModel.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import Foundation

struct MainState {

    enum Change: StateChange {
        case reloadData
    }

}

class MainViewModel: StatefulViewModel<MainState.Change> {

    private(set) var state: MainState
    var searchQuery: String = ""
    var moviesTest: [Movie] = []

    // MARK: - Initialization

    init(state: MainState) {
        self.state = state
        super.init()
    }

    // MARK: - Functions
    
    func searchMovie(){
        OmdbRequest.shared.getSearch(with: self.searchQuery) { [weak self] result in
            switch result{
            case .success(let movies):
                self?.moviesTest = movies
                self?.emit(change: .reloadData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
