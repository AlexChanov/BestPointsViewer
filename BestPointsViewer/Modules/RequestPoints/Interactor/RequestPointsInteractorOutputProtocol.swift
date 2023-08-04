//
//  RequestPointsInteractorOutputProtocol.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import Foundation

protocol RequestPointsInteractorOutputProtocol: AnyObject {
    func didReceivePoints(_ points: [Point])
    func didReceiveError(_ error: Error)
}
