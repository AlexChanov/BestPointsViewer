//
//  CanvasView.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 04.08.2023.
//

import UIKit

final class CanvasView: UIView {

    // MARK: - Properties

    var points: [Point] = [] {
        didSet {
            setNeedsLayout()
        }
    }

    private let shapeLayer = CAShapeLayer()

    // MARK: - UIView lifecycle

    override func draw(_ rect: CGRect) {
        shapeLayer.removeFromSuperlayer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        animateDrawing()
    }

    // MARK: - Private functions

    private func animateDrawing() {
        guard !points.isEmpty else { return }

        let values = points.map { $0.y }
        let minValue = CGFloat(values.min() ?? 0)
        let maxValue = CGFloat(values.max() ?? 0)
        let pointDistance = bounds.width / CGFloat(points.count - 1)
        let heightMultiplier = bounds.height / (maxValue - minValue)

        let path = UIBezierPath()
        for (i, point) in points.enumerated() {
            let pointX = CGFloat(i) * pointDistance
            let pointY = bounds.height - ((CGFloat(point.y) - minValue) * heightMultiplier)
            if i == 0 {
                path.move(to: CGPoint(x: pointX, y: pointY))
            } else {
                let controlPoint1 = CGPoint(x: (CGFloat(i - 1) * pointDistance + pointX) / 2, y: bounds.height - (CGFloat(points[i - 1].y - minValue) * heightMultiplier))
                let controlPoint2 = CGPoint(x: (CGFloat(i - 1) * pointDistance + pointX) / 2, y: pointY)
                path.addCurve(to: CGPoint(x: pointX, y: pointY), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            }
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(shapeLayer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        shapeLayer.add(animation, forKey: "line")
    }
}

// MARK: - File Saving Functions

extension CanvasView {
    func saveToFile(completion: @escaping (URL?, Error?) -> Void) {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("chart.png")
            do {
                try data.write(to: filename)
                completion(filename, nil)
            } catch {
                completion(nil, error)
            }
        } else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create PNG data"]))
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
