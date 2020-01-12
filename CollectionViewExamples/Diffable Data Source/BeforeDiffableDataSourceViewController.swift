//
//  BeforeDiffableDataSourceViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class BeforeDiffableDataSourceViewController: UIViewController {
  var collectionView: UICollectionView!
  var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: makeLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    view.addSubview(collectionView)

    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
      self.collectionView.performBatchUpdates({
        self.items.removeSubrange(0 ..< 5)
        self.collectionView.deleteItems(at: Array(0 ..< 5).map { IndexPath(item: $0, section: 0)})
      })
    }
  }

  private func makeLayout() -> UICollectionViewLayout {
    let length = view.bounds.width / 5
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = .init(width: length, height: length)
    layout.minimumLineSpacing = .zero
    layout.minimumInteritemSpacing = .zero
    return layout
  }
}

extension BeforeDiffableDataSourceViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
    cell.label.text = "\(items[indexPath.item])"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
}
