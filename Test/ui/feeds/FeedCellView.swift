//
//  FeedCellView.swift
//  Hubrick
//
//  Created by Marco Maddalena on 06/08/2017.
//  Copyright © 2017 Hubrick. All rights reserved.
//

import UIKit

class FeedCellView: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var imwAvatar: UIImageView! {
        didSet{
            imwAvatar.layer.cornerRadius = imwAvatar.frame.size.height/2
            imwAvatar.layer.masksToBounds = true
            imwAvatar.layer.borderWidth = 0
        }
    }
    @IBOutlet weak var imwFeed: UIImageView! {
        didSet{
            imwFeed.alpha = 0.0
        }
    }
    @IBOutlet weak var labelCaption: UILabel!
    @IBOutlet weak var labelNoContent: UILabel!
    @IBOutlet weak var indicatorFeed: UIActivityIndicatorView!
    
    var feed: Feed?{
        didSet{
            self.viewModel = FeedCellViewModel(feed: feed)
        }
    }
    
    var viewModel: FeedCellViewModel?{
        didSet{
            self.setUpLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.feed = nil
        self.labelUsername.text = ""
        self.imwAvatar.image = nil
        self.imwFeed.image = nil
    }
        
    // MARK: private implementation
    
    private func setUpLayout() {
    
        self.labelUsername.text = self.viewModel?.usernameText
        self.labelCaption.text = self.viewModel?.captionText
        
        let reachableAvatarBlock: ConnectivitySuccessBlock = {
            if let urlAvatar = self.viewModel?.imgAvatarURL {
                self.viewModel?.loadImage(at: urlAvatar, success: { (downloadedImage) in
                    DispatchQueue.main.async {
                        self.imwAvatar.image = downloadedImage
                    }
                }, failure:{
                    DispatchQueue.main.async {
                        self.imwAvatar.image = UIImage(named: "defaultAvatar")
                    }
                })
            }
        }
        
        let unReachableAvatarBlock: ConnectivityFailureBlock = {
            DispatchQueue.main.async {
                self.imwAvatar.image = UIImage(named: "defaultAvatar")
            }
        }
        
        ConnectivityManager.sharedInstance.executeBlockIfConnectionIsAvailable(success: reachableAvatarBlock, failure: unReachableAvatarBlock)
        
        
        let reachableFeedBlock: ConnectivitySuccessBlock = {
            if let urlFeed = self.viewModel?.imgFeedURL {
                self.viewModel?.loadImage(at: urlFeed, success: { (downloadedImage) in
                    DispatchQueue.main.async {
                        self.imwFeed.image = downloadedImage
                        self.indicatorFeed.stopAnimating()
                        self.labelNoContent.isHidden = true
                        UIView.animate(withDuration: 0.5, animations: { 
                            self.imwFeed.alpha = 1.0
                        })
                    }
                }, failure: {
                    DispatchQueue.main.async {
                        self.indicatorFeed.stopAnimating()
                        self.imwFeed.alpha = 0.0
                        self.imwFeed.image = nil
                        self.labelNoContent.isHidden = false
                    }
                })
            }
        }
        
        let unReachableFeedBlock: ConnectivityFailureBlock = {
            DispatchQueue.main.async {
                self.indicatorFeed.stopAnimating()
                self.labelNoContent.isHidden = false
            }
        }
        
        ConnectivityManager.sharedInstance.executeBlockIfConnectionIsAvailable(success: reachableFeedBlock, failure: unReachableFeedBlock)
        
    }
}
