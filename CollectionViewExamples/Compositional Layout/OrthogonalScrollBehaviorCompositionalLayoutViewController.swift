//
//  OrthogonalScrollBehaviorCompositionalLayoutViewController.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/12.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class OrthogonalScrollBehaviorCompositionalLayoutViewController: UIViewController {
  enum Section: Int, CaseIterable {
    case continuous
    case continuousGroupLeadingBoundary
    case paging
    case groupPaging
    case groupPagingCentered
    case none

    var orthogonalScrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
      switch self {
      case .continuous:
        return .continuous
      case .continuousGroupLeadingBoundary:
        return .continuousGroupLeadingBoundary
      case .paging:
        return .paging
      case .groupPaging:
        return .groupPaging
      case .groupPagingCentered:
        return .groupPagingCentered
      case .none:
        return .none
      }
    }
  }

  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = .init(frame: view.bounds, collectionViewLayout: makeLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    view.addSubview(collectionView)

    dataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
      cell.label.text = "\(item)"
      return cell
    }

    var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    var reference = 0
    Section.allCases.forEach { section in
      snapshot.appendSections([section])
      snapshot.appendItems(Array(reference ..< reference + 100), toSection: section)
      reference += 100
    }
    dataSource.apply(snapshot)
  }

  func makeLayout() -> UICollectionViewLayout {
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.6))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = Section(rawValue: sectionIndex)!.orthogonalScrollBehavior
      return section
    }, configuration: config)
    return layout
  }
}
