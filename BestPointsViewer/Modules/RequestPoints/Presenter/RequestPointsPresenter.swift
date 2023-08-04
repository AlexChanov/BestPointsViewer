//
//  RequestPointsPresenter.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

final class RequestPointsPresenter {

    // MARK: - Properties

    private let interactor: RequestPointsInteractorProtocol
    weak var view: RequestPointsViewProtocol?
    var router: RequestPointsRouterProtocol?

    // MARK: - Initialization

    init(interactor: RequestPointsInteractorProtocol) {
        self.interactor = interactor
    }
}

// MARK: - RequestPointsPresenterProtocol

extension RequestPointsPresenter: RequestPointsPresenterProtocol {
    func fetchPoints(for countText: String?) {
        guard let countText = countText,
              countText != "",
              countText != "0" else {
            view?.displayIncorrectText("Пожалуйста введите число точек 🙂")
            return
        }
        interactor.fetchPoints(count: countText)
    }
}

// MARK: - RequestPointsInteractorOutputProtocol

extension RequestPointsPresenter: RequestPointsInteractorOutputProtocol {
    func didReceivePoints(_ points: [Point]) {
        DispatchQueue.main.async { [weak self] in
            let sortedPoints = points.sorted { $0.x < $1.x }
            self?.router?.showPointsScreen(sortedPoints)
        }
    }

    func didReceiveError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayError(error)
        }
    }
}
