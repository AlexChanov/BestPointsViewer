//
//  CanvasView.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 04.08.2023.
//

import UIKit

final class CanvasView: UIView {
    var points: [Point] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard !points.isEmpty else { return }

        let values = points.map { $0.y }
        let minValue = CGFloat(values.min() ?? 0)
        let maxValue = CGFloat(values.max() ?? 0)
        let pointDistance = bounds.width / CGFloat(points.count - 1)
        let heightMultiplier = bounds.height / (maxValue - minValue)

        let path = UIBezierPath()
        path.lineWidth = 2.0
        UIColor.red.setStroke()

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

        path.stroke()
    }
}

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

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
