//
//  SpiceModel.swift
//  Spicify
//
//  Created by Dian Dinihari on 10/06/21.
//

import Foundation
import UIKit

let usageList : [SpiceUsage] = [
    SpiceUsage(usageImage: #imageLiteral(resourceName: "Infusion Icon"), usageLabel : "Drinks"),
    SpiceUsage(usageImage: #imageLiteral(resourceName: "Soup Icon"), usageLabel : "Soup"),
    SpiceUsage(usageImage: #imageLiteral(resourceName: "StirFry Icon"), usageLabel : "Stir Fry"),
    SpiceUsage(usageImage: #imageLiteral(resourceName: "Marinate Icon"), usageLabel : "Marinate"),
    SpiceUsage(usageImage: #imageLiteral(resourceName: "Curry Icon"), usageLabel : "Curry"),
    SpiceUsage(usageImage: #imageLiteral(resourceName: "Dressing Icon"), usageLabel : "Sauce"),
    SpiceUsage(usageImage: #imageLiteral(resourceName: "Salad Icon"), usageLabel : "Salad")
]

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
    
    func getRelatedImage() -> UIImage {
        switch self {
        case .ginger:
            return #imageLiteral(resourceName: "RelatedGinger")
        case .galangal:
            return #imageLiteral(resourceName: "RelatedGalangal")
        case .turmeric:
            return #imageLiteral(resourceName: "RelatedTurmeric")
        case .aromaticGinger:
            return #imageLiteral(resourceName: "RelatedAromaticGinger")
        }
    }
    
    func getUsage() -> [SpiceUsage] {
        var listUsage : [SpiceUsage] = []
        switch self {
        case .ginger:
            listUsage.removeAll()
            listUsage.append(usageList[0])
            listUsage.append(usageList[1])
            listUsage.append(usageList[2])
            listUsage.append(usageList[4])
            return listUsage
        case .galangal:
            listUsage.removeAll()
            listUsage.append(usageList[3])
            listUsage.append(usageList[1])
            listUsage.append(usageList[4])
            listUsage.append(usageList[2])
            listUsage.append(usageList[5])
            return listUsage
        case .turmeric:
            listUsage.removeAll()
            listUsage.append(usageList[4])
            listUsage.append(usageList[0])
            listUsage.append(usageList[1])
            listUsage.append(usageList[6])
            return listUsage
        case .aromaticGinger:
            listUsage.removeAll()
            listUsage.append(usageList[1])
            listUsage.append(usageList[4])
            listUsage.append(usageList[5])
            listUsage.append(usageList[0])
            return listUsage
        }
    }
}

class SpiceUsage {
    var usageImage: UIImage?
    var usageLabel: String?
    
    init(usageImage: UIImage?, usageLabel: String?){
        self.usageImage = usageImage
        self.usageLabel = usageLabel
    }
}

public class Spice {
    var name        : String?
    var indoName    : String?
    var bioName     : String?
    var aroma       : String?
    var taste       : String?
    var image       : UIImage?
    var relatedImage : UIImage?
    var type        : SpiceType?
    var usageList   : [SpiceUsage]?
    var discovered : String?
    
    init(name: String?, indoName: String?, bioName: String?, aroma: String?, taste: String?, type: SpiceType?) {
        self.name       = name
        self.indoName   = indoName
        self.bioName    = bioName
        self.type       = type
        self.aroma = aroma
        self.taste = taste
        self.image = type?.getImage()
        self.relatedImage = type?.getRelatedImage()
        self.usageList = type?.getUsage()
    }
}
