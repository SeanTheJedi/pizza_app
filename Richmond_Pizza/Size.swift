//
//  Size.swift
//  Richmond_Pizza
//
//  Created by Richmond Gyimah on 02/02/2024.
//

import Foundation

enum Size: String, CaseIterable, Identifiable {
    case small, medium, large, extraLarge
    var id: Self { self }
}
