//
//  NetworkServiceImpl.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

final class NetworkServiceImpl: NetworkService {

    enum NetworkError: Error {
        case invalidURL
        case emptyData
        case statusCode(Int)
        case dataDecodingFailed
    }

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func fetchPoints(endpoint: Endpoint, completion: @escaping (Result<PointsResponse, Error>) -> Void) {
        guard let url = buildURL(from: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = buildRequest(from: url, endpoint: endpoint)

        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.statusCode(-1)))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let pointsResponse = try decoder.decode(PointsResponse.self, from: data)
                completion(.success(pointsResponse))
            } catch {
                completion(.failure(NetworkError.dataDecodingFailed))
            }
        }
        dataTask.resume()
    }

    private func buildURL(from endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents(string: endpoint.baseUrl)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.urlParameters
        return urlComponents?.url
    }

    private func buildRequest(from url: URL, endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        return request
    }
}

