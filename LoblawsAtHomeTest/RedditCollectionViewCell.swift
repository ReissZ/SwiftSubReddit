//
//  RedditCollectionViewCell.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-02.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import UIKit

class RedditCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var redditImage: UIImageView!
    @IBOutlet weak var redditTitleLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var viewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelCenterConstraint: NSLayoutConstraint!
    
    public var isAnimated: Bool = false
    
   // private var source: [ImageURL] = []
    
    func updateCell(with reddit: RedditData) {
        print("cell123 \(isAnimated)")
        if isAnimated == false {
                        viewCenterConstraint.constant -= shadowView.layer.bounds.width
            //labelCenterConstraint.constant -= nameLabel.bounds.width
            
            //        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            //            self.viewCenterConstraint.constant += self.shadowView.bounds.width
            //            self.shadowView.layoutIfNeeded()
            //        }, completion: nil)
            // idLabel.text = "\(user.id)"
            print("author: \(reddit.data.author_fullname)")
            redditTitleLabel.text = reddit.data.author_fullname
          
            // redditTitleLabel.text = reddit.selftext
            // userNameLabel.text = user.userName
            //createdDateLabel.text = "\(user.createdDate)"
            
            if let imageURL = reddit.data.preview?.images.first?.source.url {
                redditImage.loadImage(from: imageURL)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.viewCenterConstraint.constant += self.shadowView.bounds.width
                self.shadowView.layoutIfNeeded()
            }) { (done) in
                self.isAnimated = true
                print("repeat \(self.isAnimated)")
            }
            
            //        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
            //            self.labelCenterConstraint.constant += self.nameLabel.bounds.width
            //            self.nameLabel.layoutIfNeeded()
            //        }, completion: nil)
            //    }
            
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                self.labelCenterConstraint.constant += self.redditTitleLabel.bounds.width
                self.redditTitleLabel.layoutIfNeeded()
                
            }) { (done) in
                self.isAnimated = true
                print("repeat2 \(self.isAnimated)")
            }
        }
        //redditImage.loadImage(from: reddit.url)
        //profileImage.layer.borderWidth = 1
        redditImage.layer.masksToBounds = false
        // profileImage.layer.borderColor = UIColor.black.cgColor
        redditImage.layer.cornerRadius = redditImage.frame.height/2
        redditImage.clipsToBounds = true
        
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.cornerRadius = shadowView.frame.width / 2
    }
}

extension UIImageView {
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
            }.resume()
    }
}
