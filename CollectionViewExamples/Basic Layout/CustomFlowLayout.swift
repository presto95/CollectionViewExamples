//
//  CustomFlowLayout.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomFlowLayout: UICollectionViewFlowLayout {
  private var insertingIndexPaths: [IndexPath] = []
  private var deletingIndexPaths: [IndexPath] = []

  override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else { return }
    if collectionView.bounds.size.width < 600 {
      let length = collectionView.bounds.width / 5
      itemSize = .init(width: length, height: length)
    } else {
      let length = collectionView.bounds.width / 8
      itemSize = .init(width: length, height: length)
    }
    minimumLineSpacing = .zero
    minimumInteritemSpacing = .zero
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionView = collectionView else { return false }
    return !newBounds.size.equalTo(collectionView.bounds.size)
  }

  override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
    super.prepare(forCollectionViewUpdates: updateItems)
    for update in updateItems {
      switch update.updateAction {
      case .insert:
        guard let indexPath = update.indexPathAfterUpdate else { return }
        insertingIndexPaths.append(indexPath)
      case .delete:
        guard let indexPath = update.indexPathBeforeUpdate else { return }
        deletingIndexPaths.append(indexPath)
      case .move:
        guard let indexPathBeforeUpdate = update.indexPathBeforeUpdate,
          let indexPathAfterUpdate = update.indexPathAfterUpdate
          else { return }
        deletingIndexPaths.append(indexPathBeforeUpdate)
        insertingIndexPaths.append(indexPathAfterUpdate)
      default:
        break
      }
    }
  }

  override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else { return nil }
    if !insertingIndexPaths.isEmpty {
      if insertingIndexPaths.contains(itemIndexPath) {
        attributes.transform = CGAffineTransform(rotationAngle: .pi).scaledBy(x: 0.1, y: 0.1)
        attributes.alpha = 0
      }
    }
    return attributes
  }

  override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else { return nil }
    if !deletingIndexPaths.isEmpty {
      if deletingIndexPaths.contains(itemIndexPath) {
        attributes.transform = CGAffineTransform(rotationAngle: -.pi).scaledBy(x: 0.1, y: 0.1)
        attributes.alpha = 0
      }
    }
    return attributes
  }

  override func finalizeCollectionViewUpdates() {
    super.finalizeCollectionViewUpdates()
    deletingIndexPaths.removeAll()
    insertingIndexPaths.removeAll()
  }
}
