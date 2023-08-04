//
//  PointsInteractor.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 05.08.2023.
//

import UIKit

final class PointsInteractor: PointsInteractorProtocol {

    // MARK: - Properties

    weak var presenter: PointsInteractorOutputProtocol?

    // MARK: - PointsInteractorProtocol

    func saveChartImage(chartView: ChartView) {
        chartView.saveToFile { [weak self] url, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.presenter?.chartImageSaveFailed(with: error)
                } else if let url = url {
                    self?.presenter?.chartImageSaved(with: url)
                }
            }
        }
    }
}
