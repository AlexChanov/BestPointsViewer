//
//  MockURLSessionDataTask.swift
//  BestPointsViewerTests
//
//  Created by Alexey Chanov on 05.08.2023.
//

import UIKit

final class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
