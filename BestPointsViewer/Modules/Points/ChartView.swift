//
//  ChartView.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

ffinal class ChartView: UIScrollView, UIScrollViewDelegate {

    private let canvasView = CanvasView()

    var points: [Point] = [] {
        didSet {
            canvasView.points = points
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        delegate = self
        minimumZoomScale = 1.0
        maximumZoomScale = 5.0
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        canvasView.backgroundColor = .clear
        canvasView.frame = bounds
        addSubview(canvasView)
        canvasView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // MARK: - UIScrollViewDelegate

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return canvasView
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            scrollView.setZoomScale(1.0, animated: false)
        }
    }
}

private final class CanvasView: UIView {
    var points: [Point] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard !points.isEmpty, let context = UIGraphicsGetCurrentContext() else { return }

        let values = points.map { $0.y }
        let minValue = CGFloat(values.min() ?? 0)
        let maxValue = CGFloat(values.max() ?? 0)
        let pointDistance = bounds.width / CGFloat(points.count - 1)
        let heightMultiplier = bounds.height / (maxValue - minValue)

        context.beginPath()
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)

        for (i, point) in points.enumerated() {
            let pointX = CGFloat(i) * pointDistance
            let pointY = bounds.height - ((CGFloat(point.y) - minValue) * heightMultiplier)
            if i == 0 {
                context.move(to: CGPoint(x: pointX, y: pointY))
            } else {
                context.addLine(to: CGPoint(x: pointX, y: pointY))
            }
        }

        context.strokePath()
    }
}
