//
//  SettingCellViewModel.swift
//  Test
//
//  Created by Marco Maddalena on 10/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class SettingCellViewModel: NSObject {

    private(set) var distance: String?
    
    init(distance: String?) {
        self.distance = distance
    }
    
    // MARK: public implementation
    
    var distanceText: String {
        guard let distance = self.distance, distance != "", let distanceValue = Int(distance) else { return ""}
        
        if distanceValue >= 0, distanceValue < 1000  {
            return String(format: "%@ meters", distance)
        }else{
            return String(format: "%d km", distanceValue/1000)
        }
    }
}
