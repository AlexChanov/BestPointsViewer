//
//  ChartView.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

final class ChartView: UIView {
    var points: [Point] = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        guard !points.isEmpty else { return }

        let values = points.map { $0.y }
        let minValue = values.min() ?? 0
        let maxValue = values.max() ?? 0

        let pointDistance = self.bounds.width / CGFloat(points.count - 1)
        let heightMultiplier = self.bounds.height / CGFloat(maxValue - minValue)

        context.beginPath()
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)

        for (i, point) in points.enumerated() {
            let pointX = CGFloat(i) * pointDistance
            let pointY = self.bounds.height - CGFloat(point.y - minValue) * heightMultiplier
            if i == 0 {
                context.move(to: CGPoint(x: pointX, y: pointY))
            } else {
                context.addLine(to: CGPoint(x: pointX, y: pointY))
            }
        }

        context.strokePath()
    }
}
