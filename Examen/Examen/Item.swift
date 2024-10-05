//
//  Item.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
