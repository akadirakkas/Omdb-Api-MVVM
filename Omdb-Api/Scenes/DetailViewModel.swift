//
//  DetailViewModel.swift
//  Omdb-Api
//
//  Created by kadir on 1.11.2022.
//

import Foundation


struct DetailState {

    enum Change: StateChange {
        case fetchDetail
    }

}

class DetailViewModel: StatefulViewModel<DetailState.Change> {

    private(set) var state: DetailState
    var moveDetail = MovieDetail()
    

    // MARK: - Initialization

    init(state: DetailState) {
        self.state = state
        super.init()
    }

    // MARK: - Functions

    func movieDetail(wit id: String){
        OmdbRequest.shared.movieDetail(with: id) { [weak self] result in
            switch result{
            case .success(let movies):
                self?.moveDetail = movies
                self?.emit(change: .fetchDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
}
