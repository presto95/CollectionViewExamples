//
//  CustomFlowLayoutViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomFlowLayoutViewController: UIViewController {
  var collectionView: UICollectionView!
  var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: CustomFlowLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    view.addSubview(collectionView)
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

extension CustomFlowLayoutViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    nil
  }

  func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    nil
  }

  func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration:   UIContextMenuConfiguration) -> UITargetedPreview? {
    nil
  }

  func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {

  }
}
