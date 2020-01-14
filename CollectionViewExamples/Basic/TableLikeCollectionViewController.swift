//
//  TableLikeCollectionViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/14.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class TableLikeCollectionViewController: UIViewController {
  private var collectionView: UICollectionView!
  private var items = Array(0 ..< 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: makeLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.register(TableLikeCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    view.addSubview(collectionView)
  }

  private func makeLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = .zero
    layout.minimumInteritemSpacing = .zero
    layout.itemSize = .init(width: view.bounds.width, height: 50)
    return layout
  }
}

extension TableLikeCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TableLikeCell
    cell.label.text = "\(items[indexPath.item])"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
}

extension TableLikeCollectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.contentView.backgroundColor = .lightGray
  }

  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.contentView.backgroundColor = .systemBackground
  }

  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    UIView.animate(withDuration: 0.5) {
      cell?.contentView.backgroundColor = .lightGray
    }
  }

  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    UIView.animate(withDuration: 0.5) {
      cell?.contentView.backgroundColor = .systemBackground
    }
  }
}
