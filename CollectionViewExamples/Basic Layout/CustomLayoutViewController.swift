//
//  CustomLayoutViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomLayoutViewController: UIViewController {
  private var collectionView: UICollectionView!
  private var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: CustomLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    view.addSubview(collectionView)
  }
}

extension CustomLayoutViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
    cell.label.text = "\(items[indexPath.item])"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
}
