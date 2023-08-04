//
//  RequestPointsInteractor.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

final class RequestPointsInteractor: RequestPointsInteractorProtocol {
    weak var output: RequestPointsInteractorOutputProtocol!
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchPoints(count: String) {
        let pointsEndpoint = PointsEndpoint(count: count)
        networkService.fetchPoints(endpoint: pointsEndpoint) { [weak self] result in
            switch result {
            case .success(let pointsResponse):
                self?.output.didReceivePoints(pointsResponse.points)
            case .failure(let error):
                self?.output.didReceiveError(error)
            }
        }
    }
}
