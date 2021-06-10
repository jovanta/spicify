//
//  SpiceModel.swift
//  Spicify
//
//  Created by Dian Dinihari on 10/06/21.
//

import Foundation
import UIKit

enum SpiceType: String, CaseIterable {
    case ginger         = "Ginger"
    case galangal       = "Galangal"
    case turmeric       = "Turmeric"
    case aromaticGinger = "Aromatic Ginger"
    
    func getImage() -> UIImage {
        switch self {
        case .ginger:
            return #imageLiteral(resourceName: "Ginger Main")
        case .galangal:
            return #imageLiteral(resourceName: "Galangal Main")
        case .turmeric:
            return #imageLiteral(resourceName: "Turmeric Main")
        case .aromaticGinger:
            return #imageLiteral(resourceName: "Aromatic Ginger Main")
        }
    }
}

class Spice {
    var name        : String?
    var indoName    : String?
    var bioName     : String?
    var aroma       : String?
    var taste       : String?
    var usage       : UIImage?
    var usageLabel  : String?
    var type        : SpiceType?
    
    init(name: String?, indoName: String?, bioName: String?, type: SpiceType?) {
        self.name       = name
        self.indoName   = indoName
        self.bioName    = bioName
        self.type       = type
    }
}
