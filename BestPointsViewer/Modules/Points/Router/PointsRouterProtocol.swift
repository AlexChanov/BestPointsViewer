//
//  PointsRouterProtocol.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 05.08.2023.
//

import Foundation

protocol PointsRouterProtocol: AnyObject {
    func presentImageViewController(with url: URL)
    func presentAlert(with error: Error)
}
