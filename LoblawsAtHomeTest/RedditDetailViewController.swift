//
//  RedditDetailViewController.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-02.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import UIKit

class RedditDetailViewController: UIViewController {
    
    var redditTitle: String?
    var redditArticle: RedditData?
    var redditImage: UIImage?

    @IBOutlet weak var articleTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        articleTextView.text = redditArticle?.data.selftext

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
