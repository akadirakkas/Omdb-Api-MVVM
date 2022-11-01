//
//  SplashViewModel.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//

import Foundation
import Network
import FirebaseRemoteConfig

struct SplashState {
    
    enum Change: StateChange {
        case checkConnection
        case connected
        case noConnect
        case fetchingRemote
        case fetchedRemote
    }
    
}

class SplashViewModel: StatefulViewModel<SplashState.Change> {
    
    private(set) var state: SplashState
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    private let remoteConfig = RemoteConfig.remoteConfig()
    var remoteText: String?
    // MARK: - Initialization
    
    init(state: SplashState) {
        self.state = state
        super.init()
        
    }
    
    // MARK: - Actions
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.emit(change: .checkConnection)
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            if path.status == .satisfied {
                self?.emit(change: .connected)
            } else {
                self?.emit(change: .noConnect)
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func confgiureRemoteConfig() {
        self.emit(change: .fetchingRemote)
        DispatchQueue.main.async {
            self.remoteConfig.fetch(withExpirationDuration: 0) { [self] status, error in
                guard error == nil else { return }
                remoteConfig.activate()
                self.remoteText =  remoteConfig.configValue(forKey: "LoodosApp").stringValue ?? "dfasdfsfds"
                self.emit(change: .fetchedRemote)
            }
        }
        
    }
}
