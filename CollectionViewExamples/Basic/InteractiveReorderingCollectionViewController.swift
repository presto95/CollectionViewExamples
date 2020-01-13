//
//  InteractiveReorderingCollectionViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/13.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class InteractiveReorderingCollectionViewController: UIViewController {
  var collectionView: UICollectionView!
  var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = .init(width: view.bounds.width / 5, height: view.bounds.width / 5)
    layout.minimumLineSpacing = .zero
    layout.minimumInteritemSpacing = .zero
    collectionView = .init(frame: view.bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    view.addSubview(collectionView)

    let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                  action: #selector(longPressGestureRecognizerDidRecognize(_:)))
    collectionView.addGestureRecognizer(longPressGestureRecognizer)
  }

  @objc func longPressGestureRecognizerDidRecognize(_ recognizer: UILongPressGestureRecognizer) {
    let recognizedItemindexPath = collectionView.indexPathForItem(at: recognizer.location(in: collectionView))!
    switch recognizer.state {
    case .began:
      collectionView.beginInteractiveMovementForItem(at: recognizedItemindexPath)
    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(recognizer.location(in: collectionView))
    case .ended:
      collectionView.endInteractiveMovement()
    case .cancelled:
      collectionView.cancelInteractiveMovement()
    default:
      collectionView.endInteractiveMovement()
    }
  }
}

extension InteractiveReorderingCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
    cell.label.text = "\(items[indexPath.item])"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return true
  }

  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let sourceData = items[sourceIndexPath.item]
    let destinationData = items[destinationIndexPath.item]
    items[sourceIndexPath.item] = destinationData
    items[destinationIndexPath.item] = sourceData
  }
}
