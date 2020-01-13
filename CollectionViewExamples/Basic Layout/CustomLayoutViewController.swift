//
//  CustomLayoutViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class CustomLayoutViewController: UIViewController {
  var collectionView: UICollectionView!
  var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: CustomLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.dataSource = self
  }
}

extension CustomLayoutViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    .init()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    0
  }
}
