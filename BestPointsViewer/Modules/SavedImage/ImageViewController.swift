//
//  ImageViewController.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 04.08.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    private let imageView = UIImageView()

    var imageURL: URL? {
        didSet {
            guard let url = imageURL else { return }
            let data = try? Data(contentsOf: url)
            imageView.image = UIImage(data: data!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
