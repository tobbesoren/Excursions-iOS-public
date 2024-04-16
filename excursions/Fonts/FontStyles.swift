//
//  FontStyles.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-23.
//

import Foundation
import SwiftUI

struct PolestarUnica77TT {
    let fontName = "Unica77Polestar-Regular"
    
    var size12: Font { // CarPlay
        get {
            Font.custom(fontName, size: 12)
        }
    }
    
    var size14: Font { // Not used
        get {
            Font.custom(fontName, size: 14)
        }
    }
    
    var size16: Font { // Regular
        get {
            Font.custom(fontName, size: 16)
        }
    }
    var size18: Font { // Not used
        get {
            Font.custom(fontName, size: 18)
        }
    }
    
    var size20: Font { // Not used
        get {
            Font.custom(fontName, size: 20)
        }
    }
    
    var size22: Font { // Not used
        get {
            Font.custom(fontName, size: 22)
        }
    }
    
    var size24: Font { // Not used
        get {
            Font.custom(fontName, size: 24)
        }
    }
    
    var size26: Font { // PlaceListItem
        get {
            Font.custom(fontName, size: 26)
        }
    }
    
    var size28: Font { // Not used
        get {
            Font.custom(fontName, size: 28)
        }
    }
    
    var size30: Font { // Heading
        get {
            Font.custom(fontName, size: 30)
        }
    }
}
