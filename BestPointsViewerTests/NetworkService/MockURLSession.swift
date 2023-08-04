//
//  MockURLSession.swift
//  BestPointsViewerTests
//
//  Created by Alexey Chanov on 05.08.2023.
//

import UIKit

final class MockURLSession: URLSession {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.nextData, self.nextResponse, self.nextError)
        }
    }
}
