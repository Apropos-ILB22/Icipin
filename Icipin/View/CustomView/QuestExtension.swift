//
//  QuestExtension.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 23/08/22.
//

import SwiftUI

extension Quest {
    var color: UIColor? {
        get {
            guard let hex = hexcolor else { return nil }
            return UIColor(hex: hex)
        }
        
        set(newColor){
            if let newColor = newColor {
                hexcolor = newColor.toHex
            }
        }
    }
}
