//
//  AppDelegate.swift
//  DemoHcl
//
//  Created by Vishal on 15/08/21.
//
//
import UIKit

class RedditListCell: UITableViewCell {
    
    // Properties
    private var imageHeightConstraint: NSLayoutConstraint? = nil
    
    private let topTitleLabel: UILabel = {
        return UILabel().setProperties(color: .darkGray, font: .boldSystemFont(ofSize: 14), line: 1)
    }()
    
    private let topDotButton: UIButton = {
        return UIButton().setProperties(imageName: "more")
    }()
    
    private lazy var profileImageView: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill // image will never be stretched vertically or horizontally
        
        if imageHeightConstraint == nil {
            imageHeightConstraint = img.addHeightConstraint(CGFloat(Constants.RedditListCell.imageViewHeight))
        }
        return img
    }()
    
    private let scoreLabel: UILabel = {
        return UILabel().setProperties(font: .systemFont(ofSize: 12), line: 1)
    }()
    
    private let commentNumberLabel: UILabel = {
        return UILabel().setProperties(font: .systemFont(ofSize: 12), line: 1)
    }()
    
    private let titleLabel: UILabel = {
        return UILabel().setProperties()
    }()
    
    private let likeButton: UIButton = {
        return UIButton().setProperties(imageName: "like")
    }()
    
    // Set Data in Cell
    var item: ChildData? {
        didSet {
            guard let dataItem = item else {return}
            loadCell(dataItem)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initializeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Initialize UI
    private func initializeUI() {
        
        let parentStack = UIStackView(axis: .vertical, spacing: 10.0)
        self.contentView.addSubview(parentStack)
        
        parentStack.fillInSuperview(lead: 10, trail: 10,top: 10)
        
        let topStack = UIStackView(axis: .horizontal, spacing: 0.0)
        topStack.addArrangedSubviews(views: [topTitleLabel, UIView.blank(), topDotButton])
        
        let headerStack = UIStackView(axis: .horizontal, spacing: 0.0)
        headerStack.addArrangedSubviews(views: [titleLabel])
        
        let imgStack = UIStackView(axis: .horizontal, spacing: 0.0)
        imgStack.addArrangedSubviews(views: [profileImageView])
        
        let likeStack = UIStackView(axis: .horizontal, spacing: 0.0)
        likeStack.addArrangedSubviews(views: [likeButton, UIView.blank()])
        
        let bottomStack = UIStackView(axis: .horizontal, distribution: .fillEqually, spacing: 0.0)
        bottomStack.addArrangedSubviews(views: [leftView(), middleView(), rightView()])
        
        let bottomMarginView = UIView.blank()
        bottomMarginView.backgroundColor = .systemGray5
        bottomMarginView.addHeightConstraint(8)
        
        parentStack.addArrangedSubviews(views: [topStack, headerStack, imgStack, likeStack, bottomStack, bottomMarginView])
    }
    
    // Set LeftView for Bottom Stack
    private func leftView() -> UIView {
        
        let _view = UIView()
        let parentStack = UIStackView(axis: .vertical, alignment: .leading, spacing: 0.0)
        
        _view.addSubview(parentStack)
        parentStack.fillInSuperview()
        
        let childStack = UIStackView(axis: .horizontal, spacing: 4)
        let up = UIImageView(width: 20)
        up.image = #imageLiteral(resourceName: "up")
        
        let down = UIImageView(width: 20)
        down.image = #imageLiteral(resourceName: "down")
        
        childStack.addArrangedSubviews(views: [up, scoreLabel, down])
        parentStack.addArrangedSubview(childStack)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scoresAction))
        _view.addGestureRecognizer(tapGesture)
        
        return _view
    }
    
    // Set MiddleView for Bottom Stack
    private func middleView() -> UIView {
        
        let _view = UIView()
        let parentStack = UIStackView(axis: .vertical, alignment: .center, spacing: 0.0)
        
        _view.addSubview(parentStack)
        parentStack.fillInSuperview()
        
        let childStack = UIStackView(axis: .horizontal, spacing: 4)
        let imageView = UIImageView(width: 20)
        imageView.image = #imageLiteral(resourceName: "comment")
        
        childStack.addArrangedSubviews(views: [imageView, commentNumberLabel])
        parentStack.addArrangedSubview(childStack)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(commentsAction))
        _view.addGestureRecognizer(tapGesture)
        
        return _view
    }
    
    // Set RightView for Bottom Stack
    private func rightView() -> UIView {
        
        let _view = UIView()
        let parentStack = UIStackView(axis: .vertical, alignment: .trailing, spacing: 0.0)
        
        _view.addSubview(parentStack)
        parentStack.fillInSuperview()
        
        let childStack = UIStackView(axis: .horizontal, spacing: 4)
        let imageView = UIImageView(width: 20)
        imageView.image = #imageLiteral(resourceName: "share")
        
        let share = UILabel()
        share.text = Constants.RedditListCell.share
        childStack.addArrangedSubviews(views: [imageView, share])
        parentStack.addArrangedSubview(childStack)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareAction))
        _view.addGestureRecognizer(tapGesture)
        
        return _view
    }
    
    // Set Cell Data
    fileprivate func loadCell(_ dataItem: ChildData) {
        
        titleLabel.text = item?.title
        scoreLabel.text = item?.score?.roundedWithAbbreviations
        
        if let commentNo = item?.numberOfComments {
            commentNumberLabel.text = String(commentNo)
        }
        
        topTitleLabel.text = Constants.RedditListCell.entertainment
        
        if let urlString = dataItem.thumbnail {
            profileImageView.image = #imageLiteral(resourceName: "PlaceHolderImage")
            profileImageView.displayImageFrom(link: urlString, contentMode: .scaleAspectFill)
            imageHeightConstraint?.constant = getImageheight(widthImage: dataItem.thumbnailWidth, heightImage: dataItem.thumbnailHeight, urlString: urlString)
            imageHeightConstraint?.priority = UILayoutPriority(750)
        }
    }
    
    private func getImageheight(widthImage: Int?, heightImage: Int?, urlString: String) -> CGFloat {
        
        if let width = widthImage, let height = heightImage, urlString.checkValidImageUrl() {
            let ratio = width / height
            let newImageHeight = CGFloat(Int(UIScreen.main.bounds.width) * ratio)
            return newImageHeight
        } else {
            return CGFloat(Constants.RedditListCell.imageViewHeight)
        }
    }
    
    // TODO Comment Action
    @objc func commentsAction() {}
    
    // TODO Share Action
    @objc func shareAction() {}
    
    // TODO Scores Action
    @objc func scoresAction() {}
}
