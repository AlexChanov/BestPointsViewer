//
//  ChartView.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

final class ChartView: UIScrollView, UIScrollViewDelegate {

    // MARK: - Views

    private let canvasView = CanvasView()

    // MARK: - Properties

    var points: [Point] = [] {
        didSet {
            canvasView.points = points
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Private functions

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

    // MARK: - Public functions

    func saveToFile(completion: @escaping (URL?, Error?) -> Void) {
        canvasView.saveToFile(completion: completion)
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

