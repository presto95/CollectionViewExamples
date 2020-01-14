//
//  TableLikeCell.swift
//  CollectionViewExamples
//
//  Created by Presto on 2020/01/14.
//  Copyright © 2020 presto. All rights reserved.
//

import UIKit

final class TableLikeCell: UICollectionViewCell {
  let label = UILabel()
  let separatorView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    label.font = .systemFont(ofSize: 20, weight: .bold)
    separatorView.backgroundColor = .label
    contentView.backgroundColor = .systemBackground
    contentView.addSubview(label)
    contentView.addSubview(separatorView)

    label.translatesAutoresizingMaskIntoConstraints = false
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
    ])
    NSLayoutConstraint.activate([
      separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
      separatorView.heightAnchor.constraint(equalToConstant: 1),
      separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
