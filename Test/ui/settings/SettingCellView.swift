//
//  SettingCellView.swift
//  Test
//
//  Created by Marco Maddalena on 10/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class SettingCellView: UITableViewCell {

    @IBOutlet weak var labelDistance:UILabel!
    
    var distance: String?{
        didSet{
            self.viewModel = SettingCellViewModel(distance: distance)
        }
    }
    
    var viewModel: SettingCellViewModel?{
        didSet{
            self.setUpLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.backgroundColor = UIColor.clear.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelDistance.text = ""
    }
    
    // MARK: private implementation
    
    private func setUpLayout() {
        self.labelDistance.text = self.viewModel?.distanceText
    }

}
