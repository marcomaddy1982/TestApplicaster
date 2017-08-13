//
//  SettingsViewModel.swift
//  Test
//
//  Created by Marco Maddalena on 09/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

private let _sharedInstance = SettingsProvider()

class SettingsProvider: NSObject {

    var distaces: [String] = ["100","200","500","1000","2000","3000","4000","5000"]
    var selectedDistace: String = "500"
    var currentDistanceIndex = 2
    
    var distancesCount: Int {
        return self.distaces.count
    }
    
    class var sharedInstance: SettingsProvider {
        return _sharedInstance
    }
    
    //MARK: public implementation
    
    func distance(at index: Int) -> String? {
        return self.distaces[index]
    }
    
    func isSelectedDistace(distance: String) -> Bool {
        return distance == self.selectedDistace
    }
    
    func setSelectDistace(at index: Int) {
        if let distance = self.distance(at: index) {
            self.selectedDistace = distance
            self.currentDistanceIndex = index
        }
    }
}
