//
//  SliderCollectionViewCell.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 16/6/21.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell, ParallaxCardCell, SliderViewCellInput {

  // MARK: - Identifier
    static let identifier = "identifier"

  // MARK: - Private Properities

    private var tapToFlipGesture: UITapGestureRecognizer?
    private var cornerRadius: CGFloat = 10 { didSet { update() } }
    private var shadowOpacity: CGFloat = 0.3 { didSet { update() } }
    private var shadowColor: UIColor = .black { didSet { update() } }
    private var shadowRadius: CGFloat = 20 { didSet { update() } }
    private var shadowOffset: CGSize = CGSize(width: 0, height: 20) { didSet { update() } }
    private var zoom: CGFloat = 0
    private var shadeOpacity: CGFloat = 0
    private var firstValue: String?
    private var secondValue: String?
    private var isSelect: Bool = false
    private var shadeView = UIView()
    private var highlightView = UIView()
    private var latestBounds: CGRect?
    var presenter: SliderViewOutput?

    private lazy var tapGesture: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(tap))
        return recognizer
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Georgia-Bold", size: 25)
        label.sizeToFit()
        return label
    }()

    var maxZoom: CGFloat {
        return 1.3
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(label)
        getConstraint()
        contentView.addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setShadeOpacity(progress: CGFloat) {
        shadeOpacity = progress
        updateShade()
    }

    func setZoom(progress: CGFloat) {
        zoom = progress
    }

    override var bounds: CGRect {
        didSet {
            guard latestBounds != bounds else { return }
            latestBounds = bounds
            update()
        }
    }

    func configure(with item: Word) {
        firstValue = item.value
        secondValue = item.translate
        if presenter?.isSelect == false {
            label.text = item.value
        } else {
            label.text = item.translate
        }
    }

    private func update() {
        updateMask()
    }

    func updateShade() {
        shadeView.frame = bounds.insetBy(dx: -2, dy: -2)
        shadeView.alpha = 1 - shadeOpacity
    }

    func updateMask() {
        let mask = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        mask.path = path
        contentView.layer.mask = mask
    }

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            UIView.animate(withDuration: newValue ? 0 : 0.3) {
                self.highlightView.alpha = newValue ? 0.2 : 0
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setShadeOpacity(progress: 0)
    }

    func getConstraint() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    @objc func tap() {
        presenter?.rotate()

    }
    func rotateFirst() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]

        UIView.transition(with: contentView, duration: 1.0, options: transitionOptions, animations: {
            self.label.text = self.firstValue
        })
    }

    func rotateSecond() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]

        UIView.transition(with: contentView, duration: 1.0, options: transitionOptions, animations: {
            self.label.text = self.secondValue
        })
        isSelect = true
    }
}
