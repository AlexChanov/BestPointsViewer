//
//  PointsInteractorOutputProtocol.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 05.08.2023.
//

import Foundation

protocol PointsInteractorOutputProtocol: AnyObject {
    func chartImageSaved(with url: URL)
    func chartImageSaveFailed(with error: Error)
}
