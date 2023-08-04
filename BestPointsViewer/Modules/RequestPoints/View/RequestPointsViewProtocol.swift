//
//  PointsViewProtocol.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

protocol RequestPointsViewProtocol: AnyObject {
    func displayPoints(_ points: [Point])
    func displayError(_ error: Error)
    func displayIncorrectText(_ text: String)
}
