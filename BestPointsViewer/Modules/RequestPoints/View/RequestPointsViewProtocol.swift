//
//  PointsViewProtocol.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

protocol RequestPointsViewProtocol: AnyObject {
    func displayError(_ error: Error)
    func displayIncorrectText(_ text: String)
}
