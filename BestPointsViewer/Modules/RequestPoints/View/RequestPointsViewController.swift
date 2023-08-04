//
//  RequestPointsViewController.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

final class RequestPointsViewController: UIViewController {

    // MARK: Views

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Информационный текст"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите число точек"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Поехали", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    // MARK: Private properties

    private let presenter: RequestPointsPresenterProtocol

    // MARK: Lifecycle

    init(presenter: RequestPointsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    // MARK: Private functions

    private func setupUI() {
        view.addSubview(infoLabel)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(activityIndicator)

        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            textField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func buttonClicked() {
        activityIndicator.startAnimating()
        textField.isEnabled = false
        button.isEnabled = false
        presenter.fetchPoints(for: textField.text)
    }
}

// MARK: RequestPointsViewProtocol

extension RequestPointsViewController: RequestPointsViewProtocol {

    func displayIncorrectText(_ text: String) {
        resetUI()
        infoLabel.text = text
    }

    func displaySuccess() {
        resetUI()
    }

    func displayError(_ error: Error) {
        infoLabel.text = "An error occurred: \(error.localizedDescription)"
        resetUI()
    }

    private func resetUI() {
        activityIndicator.stopAnimating()
        textField.isEnabled = true
        button.isEnabled = true
    }
}
