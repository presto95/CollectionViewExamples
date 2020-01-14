//
//  BeforeDiffableDataSourceViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class BeforeDiffableDataSourceViewController: UIViewController {
  private var collectionView: UICollectionView!
  private var items = Array(0 ..< 100)
  private var timer: Timer!

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    view.addSubview(collectionView)

    timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
      guard !self.items.isEmpty else {
        self.dismiss(animated: true, completion: nil)
        return
      }
      self.collectionView.performBatchUpdates({
        self.items.removeSubrange(0 ..< 5)
        self.collectionView.deleteItems(at: Array(0 ..< 5).map { IndexPath(item: $0, section: 0)})
      })
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timer.invalidate()
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

extension BeforeDiffableDataSourceViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let length = view.bounds.width / 5
    return .init(width: length, height: length)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
}
