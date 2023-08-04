//
//  RequestPointsModuleAssembly.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

final class RequestPointsModuleAssembly {
    func configureRequestPointsModule() -> UIViewController {
        let networkService = NetworkServiceImpl()
        let interactor = RequestPointsInteractor(networkService: networkService)
        let presenter = RequestPointsPresenter(interactor: interactor)
        let view = RequestPointsViewController(presenter: presenter)
        let router = RequestPointsRouter(view: view)
        interactor.output = presenter
        presenter.view = view
        presenter.router = router

        return view
    }
}
