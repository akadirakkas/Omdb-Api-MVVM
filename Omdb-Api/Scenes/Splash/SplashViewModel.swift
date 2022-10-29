//
//  SplashViewModel.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import Foundation

struct SplashState {

    enum Change: StateChange {
        // TODO: Define state changes.
    }

}

class SplashViewModel: StatefulViewModel<SplashState.Change> {

    private(set) var state: SplashState

    // MARK: - Initialization

    init(state: SplashState) {
        self.state = state
        super.init()
    }

    // MARK: - Actions

}
