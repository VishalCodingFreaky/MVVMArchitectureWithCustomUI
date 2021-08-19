//
//  UIView+Autolayout.swift
//
//  Created by Vishal on 15/08/21.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func addWidthConstraint(_ const: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: self,
                                       attribute: .width,
                                       relatedBy: relation,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1.0,
                                       constant: const)
        width.isActive = true
        return width
    }
    
    @discardableResult
    func addHeightConstraint(_ const: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: self,
                                        attribute: .height,
                                        relatedBy: relation,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: const)
        height.isActive = true
        return height
    }
    
    func fillInSuperview(lead: CGFloat = 0, trail: CGFloat=0, top: CGFloat=0, bottom: CGFloat=00) {
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: lead).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trail).isActive = true
    }
}

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, spacing: Float) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = CGFloat(spacing)
    }
    
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}

