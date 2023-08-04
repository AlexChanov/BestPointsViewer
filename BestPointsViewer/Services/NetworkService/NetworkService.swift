//
//  NetworkService.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

protocol NetworkService {
    func fetchPoints(endpoint: Endpoint, completion: @escaping (Result<PointsResponse, Error>) -> Void)
}

