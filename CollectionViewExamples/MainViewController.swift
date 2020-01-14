//
//  MainViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/13.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  var viewControllers: [[UIViewController.Type]] = [
    [
      TableLikeCollectionViewController.self,
      InteractiveReorderingCollectionViewController.self,
    ],
    [
      CustomFlowLayoutViewController.self,
      CustomLayoutViewController.self
    ],
    [
      BeforeDiffableDataSourceViewController.self,
      AfterDiffableDataSourceViewController.self
    ],
    [
      SimpleCompositionalLayoutViewController.self,
      OrthogonalScrollBehaviorCompositionalLayoutViewController.self
    ]
  ]
  var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = .init(frame: view.bounds, style: .grouped)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let viewControllerType = viewControllers[indexPath.section][indexPath.item]
    cell.textLabel?.text = NSStringFromClass(viewControllerType).components(separatedBy: ".").last!
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers[section].count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return viewControllers.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Basic"
    case 1:
      return "Basic Layout"
    case 2:
      return "Diffable Data Source"
    case 3:
      return "Compositional Layout"
    default:
      return nil
    }
  }
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let viewControllerType = viewControllers[indexPath.section][indexPath.item]
    present(viewControllerType.init(), animated: true, completion: nil)
  }
}
