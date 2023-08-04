//
//  ImageViewController.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 04.08.2023.
//

import UIKit

final class ImageViewController: UIViewController {

    // MARK: - Views

    private let imageView = UIImageView()

    // MARK: - Properties

    var imageURL: URL? {
        didSet {
            guard let url = imageURL else { return }
            let data = try? Data(contentsOf: url)
            imageView.image = UIImage(data: data!)
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved image"
        view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
