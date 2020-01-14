//
//  CustomFlowLayoutViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomFlowLayoutViewController: UIViewController {
  private var collectionView: UICollectionView!
  private var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: CustomFlowLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    view.addSubview(collectionView)

    var reference = 100

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      self.collectionView.performBatchUpdates({
        self.items.insert(reference, at: 0)
        self.items.remove(at: 4)
        self.collectionView.insertItems(at: [.init(item: 0, section: 0)])
        self.collectionView.deleteItems(at: [.init(item: 4, section: 0)])
      }, completion: { _ in
        reference += 1
      })
    }
  }
}

extension CustomFlowLayoutViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
    cell.label.text = "\(items[indexPath.item])"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
}
