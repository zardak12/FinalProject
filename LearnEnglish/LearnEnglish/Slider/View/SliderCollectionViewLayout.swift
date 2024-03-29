//
//  SliderCollectionViewLayout.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//
import UIKit

// MARK: - ParallaxCardCell
protocol ParallaxCardCell {
    func setShadeOpacity(progress: CGFloat)
    func setZoom(progress: CGFloat)
}

// MARK: - SliderCollectionViewLayout
final class SliderCollectionViewLayout: UICollectionViewLayout {

    // MARK: - Private Properties
    private var itemSize: CGSize = .zero {
        didSet { invalidateLayout() }
    }

    private var minScale: CGFloat = 1.0 {
        didSet { invalidateLayout() }
    }

    private var visibleItemsCount: Int = 1 {
        didSet { invalidateLayout() }
    }

    private var itemsCount: CGFloat {
        return CGFloat(collectionView.numberOfItems(inSection: 0))
    }

    private var collectionBounds: CGRect {
        return collectionView.bounds
    }

    private var contentOffset: CGPoint {
        return collectionView.contentOffset
    }

    private var currentPage: Int {
        return max(Int(contentOffset.x) / Int(collectionBounds.width), 0)
    }

    private let scale = CGFloat(1.0)

    private let progress = CGFloat(1.0)

    override var collectionView: UICollectionView {
        return super.collectionView ?? UICollectionView()
    }

    // MARK: - shouldInvalidateLayout
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // MARK: - collectionViewContentSize
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionBounds.width * itemsCount, height: collectionBounds.height)
    }

    private var didInitialSetup = false

    // MARK: - Prepare
    override func prepare() {
        guard !didInitialSetup else { return }
        didInitialSetup = true

        let width = collectionBounds.width * 0.7
        let height = width / 0.7
        itemSize = CGSize(width: width, height: height)

        collectionView.setContentOffset(CGPoint(x: collectionViewContentSize.width - collectionBounds.width,
                                                y: 0), animated: false)
    }

    // MARK: - LayoutAttributesForElements
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return nil }

        let minVisibleIndex = max(currentPage - visibleItemsCount + 1, 0)

        let offset = CGFloat(Int(contentOffset.x) % Int(collectionBounds.width))
        let offsetProgress = CGFloat(offset) / collectionBounds.width
        let maxVisibleIndex = max(min(itemsCount - 1, currentPage + 1), minVisibleIndex)

        let attributes: [UICollectionViewLayoutAttributes] = (minVisibleIndex...maxVisibleIndex).map {
            let indexPath = IndexPath(item: $0, section: 0)
            return layoutAttributes(for: indexPath, currentPage, offset, offsetProgress)
        }

        return attributes
    }

    private func layoutAttributes(for indexPath: IndexPath, _ pageIndex: Int, _ offset: CGFloat,
                                  _ offsetProgress: CGFloat) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let visibleIndex = max(indexPath.item - pageIndex + visibleItemsCount, 0)
        attributes.size = itemSize
        attributes.center = CGPoint(x: collectionBounds.midX, y: collectionBounds.midY)
        attributes.zIndex = visibleIndex
        attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        let cell = collectionView.cellForItem(at: indexPath) as? ParallaxCardCell
        cell?.setZoom(progress: scale)
        cell?.setShadeOpacity(progress: progress )

        switch visibleIndex {
        case visibleItemsCount + 1:
            attributes.center.x += collectionBounds.width - offset
            attributes.center.y -= collectionBounds.width - offset
        default:
            attributes.center.x -= offsetProgress
        }

        return attributes
    }

}
