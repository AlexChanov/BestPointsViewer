//
//  PointsPresenter.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 05.08.2023.
//

import Foundation

final class PointsPresenter: PointsPresenterProtocol, PointsInteractorOutputProtocol {

    // MARK: - Properties

    weak var view: PointsViewProtocol?
    var interactor: PointsInteractorProtocol?
    var router: PointsRouterProtocol?

    // MARK: - PointsPresenterProtocol

    func saveChartImage(chartView: ChartView) {
        interactor?.saveChartImage(chartView: chartView)
    }

    // MARK: - PointsInteractorOutputProtocol

    func chartImageSaved(with url: URL) {
        router?.presentImageViewController(with: url)
    }

    func chartImageSaveFailed(with error: Error) {
        router?.presentAlert(with: error)
    }
}

