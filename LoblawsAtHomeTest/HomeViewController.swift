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
    
    private var reddits: [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.layer.cornerRadius = 0.5
        let nib = UINib(nibName: "RedditsCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "RedditsCollectionViewCell")
        
        NetworkingService.shared.getReddits { [weak self] (response) in
            
            
            self?.reddits = [response]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reddits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:CGFloat(collectionView.frame.size.width * 0.46), height: collectionView.frame.size.height * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "UserDetailVC", sender: indexPath.row)
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
                                    let bounceImageView = redditCell.redditImage
                                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                                    bounceView?.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                                    }, completion: { (success: Bool) in
                                        if success {
                                            bounceView?.bounds = bounds
                                        }
                                    })
                    
                                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                                        bounceImageView?.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                                    }, completion: { (success: Bool) in
                                        if success {
                                            bounceImageView?.bounds = bounds
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