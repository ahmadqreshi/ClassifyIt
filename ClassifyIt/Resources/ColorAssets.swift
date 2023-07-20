//
//  ColorAssets.swift
//  ClassifyIt
//
//  Created by Ahmad Qureshi on 20/07/23.
//

import Foundation
import SwiftUI

enum ColorAssets: String {
    case dodgerBlue
    
    var set: Color {
        Color(self.rawValue)
    }
}
