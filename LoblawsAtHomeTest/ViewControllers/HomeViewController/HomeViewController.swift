//
//  HomeViewController.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-01.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var reddits: [RedditData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.layer.cornerRadius = 0.5
        let nib = UINib(nibName: "RedditCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "RedditCollectionViewCell")
        
        NetworkingService.shared.getReddits { [weak self] (response) in
            
            self?.reddits = response.data.children
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reddits.count
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RedditDetailViewController") as! RedditDetailViewController
        
        let redditDetailData: RedditData?
       
        performSegue(withIdentifier: "redditDetailSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let redditCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RedditCollectionViewCell", for: indexPath) as? RedditCollectionViewCell {
            
            if redditCell.isAnimated == false {
                print("collection1 \(redditCell.isAnimated)")
                redditCell.backgroundColor = UIColor.clear
                
                redditCell.updateCell(with: reddits[indexPath.row])
                
                UIView.animate(withDuration: 0.5, delay: 0.5 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 0.5 , options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
                    if indexPath.row % 2 == 0 {
                        AnimationUtility.viewSlideInFromLeft(toRight: redditCell)
                        print("collection2 \(redditCell.isAnimated)")
                    }
                    else {
                        AnimationUtility.viewSlideInFromRight(toLeft: redditCell)
                        print("collection3 \(redditCell.isAnimated)")
                        
                    }
                }, completion: { (done) in
                    print("finito")
                    redditCell.isAnimated = true
                    redditCell.isAnimated = true
                    print("collection \(redditCell.isAnimated)")
                    //self.animateBounceView()
                    let bounds = redditCell.shadowView.bounds
                    let bounceView = redditCell.shadowView
                    let bounceImageView = redditCell.redditImageView
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                        bounceView?.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                    }, completion: { (success: Bool) in
                        if success {
                        }
                    })
                    
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                        bounceImageView?.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                    }, completion: { (success: Bool) in
                        if success {
                        }
                    })
                })
                
            }
            redditCell.isAnimated = true
            
            return redditCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            RedditDetailViewController, let index =
            collectionView.indexPathsForSelectedItems?.first {
            destination.redditArticle = reddits[index.row]
            destination.redditTitle = reddits[index.row]
            destination.redditImage = reddits[index.row]
        }
        }
}
    extension UICollectionView {
        
        func dropShadow() {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.layer.shadowRadius = 1
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    extension UICollectionView {
        func reloadData(_ completion: @escaping () -> Void) {
            reloadData()
            DispatchQueue.main.async { completion() }
        }
}
