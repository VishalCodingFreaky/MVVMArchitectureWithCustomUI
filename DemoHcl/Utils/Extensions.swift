//
//  Extensions.swift
//  DemoHcl
//
//  Created by Vishal on 15/08/21.
//

import UIKit

// MARK: - Image load extension
extension UIImageView {
    
    func displayImageFrom(link: String, contentMode: UIView.ContentMode) {
        guard let url = NSURL(string: link) as URL? else { return }
        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

// MARK: - UIViewController extension
extension  UIViewController {
    // Show text alert
    func showAlert(withTitle title: String? = Constants.Alert.title, withMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: Constants.Alert.buttonTitleOk, style: .default, handler: { action in
        })
        
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    // Show Loading
    func showLoading() {
        
        let alert = UIAlertController(title: nil, message: Constants.Alert.loading, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    // Hide Loading
    func hideLoading() {
        
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: false, completion: nil)
        })
    }
}

// MARK: - String extension
extension String {
    // check valid Url String
    func checkValidImageUrl() -> Bool {
        let imageExtensions = ["png", "jpg"]
        let url: URL? = NSURL(fileURLWithPath: self) as URL
        
        if let pathExtention = url?.pathExtension {
            return imageExtensions.contains(pathExtention)
        }
        return false
    }
}

// MARK: - Int extension
extension Int {
    // Get Rounded String
    var roundedWithAbbreviations: String {
        
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

// MARK: - UIView extension
extension UIView {
    
    convenience init(width: Float) {
        self.init()
        self.addWidthConstraint(CGFloat(width))
    }
    
    static func blank() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

// MARK: - UILabel extension
extension UILabel {
    
    func setProperties(color: UIColor = .black, font: UIFont = UIFont.boldSystemFont(ofSize: 18), line: Int = 0) -> Self {
        self.font = font
        self.textColor =  color
        self.numberOfLines = line
        return self
    }
}

// MARK: - UIButton extension
extension UIButton {
    
    func setProperties(imageName: String) -> Self {
        self.backgroundColor = .clear
        self.setImage(UIImage(named: imageName), for: .normal)
        return self
    }
}
