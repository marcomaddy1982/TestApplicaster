//
//  SettingsViewController.swift
//  Test
//
//  Created by Marco Maddalena on 09/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate:NSObjectProtocol {
    func settingView(settingsVC: SettingsViewController, didSelectDistance:String)
}

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableSettings: UITableView!
    
    var provider = SettingsProvider.sharedInstance
    weak var delegate : SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IBActions
    
    @IBAction func didSelectCloseButton(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK - Private implementation
    
    private func reloadDistanceTable() {
        DispatchQueue.main.async {
            self.tableSettings.reloadData()
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.provider.distancesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingCellView = tableView.dequeueReusableCell(withIdentifier: "SettingCellView", for: indexPath) as! SettingCellView
        if let distance = self.provider.distance(at: indexPath.row) {
            cell.distance = distance
            cell.accessoryType = self.provider.isSelectedDistace(distance: distance) ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.provider.setSelectDistace(at: indexPath.row)
        self.reloadDistanceTable()
        
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.delegate?.settingView(settingsVC: self, didSelectDistance: self.provider.selectedDistace)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
