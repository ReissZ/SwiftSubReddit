//
//  RedditDetailViewController.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-02.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import UIKit

class RedditDetailViewController: UIViewController {
    
    var redditTitle: RedditData?
    var redditArticle: RedditData?
    var redditImage: RedditData?
    
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var redditImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        articleTextView.text = redditArticle?.data.selftext
        
        self.navigationController?.navigationBar.topItem?.title = redditTitle?.data.title
        
        let redditImageURLFromData = redditImage?.data.preview?.images.first?.source.url
        print("optional image: \(redditImageURLFromData)")

        if let redditImageURL = redditImageURLFromData?.absoluteURL {
            print("image url1: \(redditImageURL)")
            //redditImageView.loadImage(from: imageURL)
            UIImage.loadFrom(url: redditImageURL) { image in
                self.redditImageView.image = image
            }
        }
    }
}

extension UIImage {
    
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
