//
//  MainViewModel.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import Foundation

struct MainState {

    enum Change: StateChange {
        case showIndicator
        case hideIndicator
        case reloadData
        case noMovie
    }

}

class MainViewModel: StatefulViewModel<MainState.Change> {

    private(set) var state: MainState
    var searchQuery: String = ""
    var moviesList: [Movie] = []

    // MARK: - Initialization

    init(state: MainState) {
        self.state = state
        super.init()
    }

    // MARK: - Functions
    
    func searchMovie(){
        self.emit(change: .showIndicator)
        OmdbRequest.shared.getSearch(with: self.searchQuery) { [weak self] result in
            switch result{
            case .success(let movies):
                if  movies.isEmpty {
                    self?.emit(change: .noMovie)
                }
                self?.moviesList = movies
                self?.emit(change: .reloadData)
                self?.emit(change: .hideIndicator)
            case .failure(let error):
                print(error)
                self?.emit(change: .showIndicator)
                
            }
        }
    }
}
