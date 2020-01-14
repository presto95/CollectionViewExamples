//
//  CustomLayout.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomLayout: UICollectionViewLayout {
  enum Direction {
    case up
    case down
  }

  var contentBounds = CGRect.zero
  var cachedAttributes = [UICollectionViewLayoutAttributes]()
  let itemLength: CGFloat = 50

  override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else { return }
    cachedAttributes.removeAll()
    contentBounds = .init(origin: .zero, size: collectionView.bounds.size)

    var direction = Direction.down
    let maxHeight = collectionView.bounds.height
    let count = collectionView.numberOfItems(inSection: 0)
    var currentIndex = 0
    var lastFrame = CGRect.zero

    while currentIndex < count {
      if lastFrame.maxY + itemLength >= maxHeight {
        direction = .up
      } else if lastFrame.minY - itemLength <= 0 {
        direction = .down
      }

      let segmentFrame: CGRect = {
        switch direction {
        case .up:
          return .init(x: lastFrame.maxX, y: lastFrame.minY - itemLength, width: itemLength, height: itemLength)
        case .down:
          return .init(x: lastFrame.maxX, y: lastFrame.maxY, width: itemLength, height: itemLength)
        }
      }()
      let attributes = UICollectionViewLayoutAttributes(forCellWith: .init(item: currentIndex, section: 0))
      attributes.frame = segmentFrame
      cachedAttributes.append(attributes)
      contentBounds = contentBounds.union(lastFrame)
      currentIndex += 1
      lastFrame = segmentFrame
    }
  }

  override var collectionViewContentSize: CGSize {
    return contentBounds.size
  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cachedAttributes.filter { $0.frame.intersects(rect) }
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.item]
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionView = collectionView else { return false }
    return !newBounds.size.equalTo(collectionView.bounds.size)
  }
}
