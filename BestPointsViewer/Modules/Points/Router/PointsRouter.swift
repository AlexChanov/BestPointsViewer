//
//  PointsRouter.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 05.08.2023.
//

import UIKit

final class PointsRouter: PointsRouterProtocol {

    // MARK: - Properties

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    // MARK: - PointsRouterInput

    func presentImageViewController(with url: URL) {
        let imageVC = ImageViewController()
        imageVC.imageURL = url
        view?.navigationController?.pushViewController(imageVC, animated: true)
    }

    func presentAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        view?.present(alertController, animated: true, completion: nil)
    }
}
