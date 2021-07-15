//
//  TrainingCollectionViewLayout.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 3/7/21.
//

import UIKit

class TrainingCollectionViewLayout: UICollectionViewLayout {

  var itemSize: CGSize = .zero {
      didSet { invalidateLayout() }
  }

  var collectionBounds: CGRect {
      return collectionView.bounds
  }

  var itemsCount: CGFloat {
      return CGFloat(collectionView.numberOfItems(inSection: 0))
  }

  private var itemCount = 0

  private var layoutAttributes: [UICollectionViewLayoutAttributes?] = []

  private var adjustedLayoutAttributes: [UICollectionViewLayoutAttributes] = []

  override var collectionViewContentSize: CGSize {
      return CGSize(width: collectionBounds.width, height: collectionBounds.height)
  }

  override var collectionView: UICollectionView {
      return super.collectionView!
  }

  private var didInitialSetup = false

  open override func prepare() {
    guard !didInitialSetup else { return }
    didInitialSetup = true

    itemCount = collectionView.numberOfItems(inSection: 0)

    let width = collectionBounds.width * 0.5
    let height = width / 0.6
    itemSize = CGSize(width: width, height: height)
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    attributes.size = itemSize
    attributes.center = CGPoint(x: collectionBounds.midX, y: collectionBounds.midY)
    return attributes
     }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

    for item in 0..<itemCount {
      let indexPath = IndexPath(item: item, section: 0)
      let attributes = layoutAttributesForItem(at: indexPath)
      layoutAttributes.append(attributes)
    }

    adjustedLayoutAttributes = layoutAttributes.compactMap { $0 }

    return adjustedLayoutAttributes
  }

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        return layout
    }
}
