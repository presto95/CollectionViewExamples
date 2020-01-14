//
//  AfterDiffableDataSourceViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class AfterDiffableDataSourceViewController: UIViewController {
  enum Section {
    case main
  }

  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
  private var timer: Timer!

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: makeLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    view.addSubview(collectionView)

    dataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
      cell.label.text = "\(item)"
      return cell
    }

    var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    snapshot.appendSections([.main])
    snapshot.appendItems(Array(0 ..< 100))
    dataSource.apply(snapshot)

    timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
      var currentSnapshot = self.dataSource.snapshot()
      guard currentSnapshot.numberOfItems != 0 else {
        self.dismiss(animated: true, completion: nil)
        return
      }
      let deletingItems = Array(currentSnapshot.itemIdentifiers[0 ..< 5])
      currentSnapshot.deleteItems(deletingItems)
      self.dataSource.apply(currentSnapshot)
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timer.invalidate()
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
