//
//  PointsViewController.swift
//  BestPointsViewer
//
//  Created by Alexey Chanov on 02.08.2023.
//

import UIKit

final class PointsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PointCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let chartView: ChartView = {
        let view = ChartView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let points: [Point]

    init(points: [Point]) {
        self.points = points
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        chartView.points = points
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Image", style: .plain, target: self, action: #selector(saveChartImage))
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(chartView)

        // конфигурация tableView
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            tableView.topAnchor.constraint(equalTo: chartView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func saveChartImage() {
        chartView.saveToFile { [weak self] url, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showAlert(with: error)
                } else if let url = url {
                    let imageVC = ImageViewController()
                    imageVC.imageURL = url
                    self?.navigationController?.pushViewController(imageVC, animated: true)
                }
            }
        }
    }

    func showAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

// MARK: UITableViewDataSource

extension PointsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath)
        let point = points[indexPath.row]
        cell.textLabel?.text = "X: \(point.x), Y: \(point.y)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
