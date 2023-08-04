//
//  NetworkServiceImplTests.swift
//  BestPointsViewerTests
//
//  Created by Alexey Chanov on 05.08.2023.
//

import XCTest
@testable import BestPointsViewer

final class NetworkServiceImplTests: XCTestCase {

    private let json = """
    {
      "points": [
        {
          "x": 1,
          "y": 2
        },
        {
          "x": 3,
          "y": 4
        }
      ]
    }
    """

    var networkService: NetworkServiceImpl!
    var mockSession: MockURLSession!

     override func setUp() {
         super.setUp()
         mockSession = MockURLSession()
         networkService = NetworkServiceImpl(session: mockSession)
     }

    func testFetchPointsSuccess() {
        let endpoint = PointsEndpoint(count: "2")
        mockSession.nextData = json.data(using: .utf8)
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://example.com/points")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)

        let expect = expectation(description: "Fetch points success")

        networkService.fetchPoints(endpoint: endpoint) { result in
            switch result {
            case .success(let pointsResponse):
                XCTAssertEqual(pointsResponse.points.count, 2)
                XCTAssertEqual(pointsResponse.points[0].x, 1)
                XCTAssertEqual(pointsResponse.points[0].y, 2)
                XCTAssertEqual(pointsResponse.points[1].x, 3)
                XCTAssertEqual(pointsResponse.points[1].y, 4)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            expect.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchPoints_APIReturns404Error_ShouldReturnNetworkErrorStatusCode404() {
        let mockSession = MockURLSession()
        let networkService = NetworkServiceImpl(session: mockSession)
        let endpoint = PointsEndpoint(count: "2")

        let response = HTTPURLResponse(url: URL(string: endpoint.baseUrl)!, statusCode: 404, httpVersion: nil, headerFields: nil)
        mockSession.nextResponse = response

        let expect = expectation(description: "API response expectation")

        networkService.fetchPoints(endpoint: endpoint) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                guard let networkError = error as? NetworkServiceImpl.NetworkError else {
                    XCTFail("Expected NetworkError, but got \(error)")
                    return
                }
                switch networkError {
                case .statusCode(let statusCode):
                    XCTAssertEqual(statusCode, 404)
                default:
                    XCTFail("Expected NetworkError.statusCode, but got \(networkError)")
                }
            }

            expect.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }
}
