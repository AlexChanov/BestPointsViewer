//
//  PointsModuleAssembly.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 05.08.2023.
//

import UIKit

final class PointsModuleAssembly {

    func configurePointsModule(_ points: [Point]) -> UIViewController {
        let interactor = PointsInteractor()
        let presenter = PointsPresenter()
        let view = PointsViewController(points: points, presenter: presenter)
        let router = PointsRouter(view: view)

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
