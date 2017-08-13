//
//  FeedViewController.swift
//  Test
//
//  Created by Marco Maddalena on 10/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import MBProgressHUD

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FeedsViewModelDelegate, SettingsViewControllerDelegate {

    @IBOutlet weak var tableFeed: UITableView!
    @IBOutlet weak var labelNoContent: UILabel!
    
    var viewModel = FeedsViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.delegate = self
        self.addPullToRefresh()
        self.startGetFeeds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IBActions
    
    @IBAction func didSelectSettings(_ sender: AnyObject) {
        self.performSegue(withIdentifier: Constant.kFeedToSettingsSegue, sender: nil)
    }
    
    // MARK: Private implementation
    
    private func addPullToRefresh() {
        
        let color = UIColor(red:17.0/255.0, green:86.0/255.0, blue:136.0/255.0, alpha:1.0)
        let attributes = [NSForegroundColorAttributeName: color]
        
        refreshControl.tintColor = color
        refreshControl.attributedTitle = NSAttributedString(string: Constant.kFeedPullToRefreshMessage, attributes: attributes)
        refreshControl.addTarget(self, action: #selector(refreshFeeds(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            self.tableFeed.refreshControl = refreshControl
        } else {
            self.tableFeed.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshFeeds(_ sender: Any) {
        self.startGetFeeds()
    }
    
    private func startGetFeeds() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let reachableBlock: ConnectivitySuccessBlock = {
            self.viewModel.startGetFeeds()
        }
        
        let unReachableBlock: ConnectivityFailureBlock = {
            self.showUnReachableAlert()
        }
        
        ConnectivityManager.sharedInstance.executeBlockIfConnectionIsAvailable(success: reachableBlock, failure: unReachableBlock)
    }
    
    private func showUnReachableAlert() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: AlertMessages.kAlert_ConnectionLost_Message, preferredStyle: UIAlertControllerStyle.alert)
            
            let retryButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_Retry, style: UIAlertActionStyle.default,     handler: { (action) in
                self.startGetFeeds()
            })
            alert.addAction(retryButton)
            
            self.present(alert, animated: true, completion: { 
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    private func showLocationSettingAlert() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: AlertMessages.kAlert_Settings_Message, preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_Cancel, style: UIAlertActionStyle.default,handler: nil)
            
            let settingsButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_Settings, style: UIAlertActionStyle.default, handler: { (action) in
            
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
                }
                
            })
            alert.addAction(cancelButton)
            alert.addAction(settingsButton)
            
            self.present(alert, animated: true, completion: {
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.feedsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCellView = tableView.dequeueReusableCell(withIdentifier: "FeedCellView", for: indexPath) as! FeedCellView
        cell.feed = self.viewModel.feed(at: indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constant.kFeedRowHeight)
    }

    // MARK: - FeedsViewModelDelegate call back
    
    func feedViewModelDidFindsFeeds(viewModel: FeedsViewModel) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.refreshControl.endRefreshing()
            self.tableFeed.reloadData()
            self.labelNoContent.isHidden = true
        }
    }
    
    func feedViewModelDidFindsNoFeeds(viewModel:FeedsViewModel) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.refreshControl.endRefreshing()
            self.tableFeed.reloadData()
            self.labelNoContent.isHidden = false
        }
    }
    
    func feedViewModelDidDainedLocation(viewModel:FeedsViewModel) {
    
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showLocationSettingAlert()
            self.tableFeed.reloadData()
            self.labelNoContent.isHidden = false
        }
        
    }
    func feedViewModelDidFailedLocation(viewModel:FeedsViewModel) {
    
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showLocationSettingAlert()
            self.tableFeed.reloadData()
            self.labelNoContent.isHidden = false
        }
    }
    
    // MARK: SettingsViewControllerDelegate call back
    func settingView(settingsVC: SettingsViewController, didSelectDistance:String) {
        self.startGetFeeds()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier != nil && segue.identifier == Constant.kFeedToSettingsSegue {
            let settingsViewController: SettingsViewController = segue.destination as! SettingsViewController
            settingsViewController.delegate = self
        }
    }

}
