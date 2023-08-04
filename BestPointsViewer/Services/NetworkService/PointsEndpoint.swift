//
//  PointsEndpoint.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

// Здесь мы определяем конкретный endpoint для получения точек
struct PointsEndpoint: Endpoint {
    var baseUrl: String { "https://hr-challenge.interactivestandard.com" }
    var path: String { "/api/test/points" }
    var method: String { "GET" }
    var headers: [String: String] { ["accept": "application/json"] }
    var urlParameters: [URLQueryItem] { [URLQueryItem(name: "count", value: count)] }
    private let count: String

    init(count: String) {
        self.count = count
    }
}

