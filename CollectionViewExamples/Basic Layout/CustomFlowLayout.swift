//
//  CustomFlowLayout.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomFlowLayout: UICollectionViewFlowLayout {
  override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else { return }
    let length = collectionView.bounds.width / 5
    itemSize = .init(width: length, height: length)
    minimumLineSpacing = .zero
    minimumInteritemSpacing = .zero
  }
}
