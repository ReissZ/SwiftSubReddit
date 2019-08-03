//
//  RedditCollectionViewCell.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-02.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import UIKit

class RedditCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var redditImageView: UIImageView!
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
      
            print("author: \(reddit.data.author_fullname)")
            redditTitleLabel.text = reddit.data.author_fullname
    
            if let imageURL = reddit.data.preview?.images.first?.source.url {
                print("imageurl: \(imageURL)")
                //redditImageView.loadImage(from: imageURL)
                UIImage.loadFrom(url: imageURL) { image in
                    self.redditImageView.image = image
                }
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.viewCenterConstraint.constant += self.shadowView.bounds.width
                self.shadowView.layoutIfNeeded()
            }) { (done) in
                self.isAnimated = true
                print("repeat \(self.isAnimated)")
            }
         
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                self.labelCenterConstraint.constant += self.redditTitleLabel.bounds.width
                self.redditTitleLabel.layoutIfNeeded()
                
            }) { (done) in
                self.isAnimated = true
                print("repeat2 \(self.isAnimated)")
            }
        }
       
        redditImageView.layer.masksToBounds = false
        redditImageView.layer.cornerRadius = redditImageView.frame.height/2
        redditImageView.clipsToBounds = true
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.cornerRadius = shadowView.frame.width / 2
    }
}
