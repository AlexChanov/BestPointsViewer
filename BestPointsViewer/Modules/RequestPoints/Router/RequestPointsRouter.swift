//
//  RequestPointsRouter.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

final class RequestPointsRouter: RequestPointsRouterProtocol {
    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func showPointsScreen(_ points: [Point]) {
        let pointsViewController = PointsViewController(points: points)
        view?.navigationController?.pushViewController(pointsViewController, animated: true)
    }
}
