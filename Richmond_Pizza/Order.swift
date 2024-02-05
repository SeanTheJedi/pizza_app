//
//  Order.swift
//  Richmond_Pizza
//
//  Created by Richmond Gyimah on 02/02/2024.
//

import Foundation

struct Order {
    var isVegeterian: Bool = false
    var quantity: Int = 1
    var selectedSize: Size = .medium
    var customerName: String = ""
    var customerPhone: String = ""
    var couponCode: String = ""
    var orderDetails: String {
        
        var details = "Vegetarian: \(self.isVegeterian ? "Yes" : "No")\n" +
        "Quantity of Pizzas: \(self.quantity)\n" +
        "Size: \(self.selectedSize)\n" +
        "Discount: \(self.couponCode == "" ? "0%" : "20%")"
        
                
        return details
    }
    
    func calculateCost() -> Double {
        var pretaxCost = 0.0
        
        if isVegeterian == true {
            switch self.selectedSize {
            case .small:
                pretaxCost = Double(self.quantity) * 5.99
            case .medium:
                pretaxCost = Double(self.quantity) * 7.99
            case .large:
                pretaxCost = Double(self.quantity) * 10.99
            case .extraLarge:
                pretaxCost = Double(self.quantity) * 13.99
            }
        } else {
            switch self.selectedSize {
            case .small:
                pretaxCost = Double(self.quantity) * 6.99
            case .medium:
                pretaxCost = Double(self.quantity) * 8.99
            case .large:
                pretaxCost = Double(self.quantity) * 12.99
            case .extraLarge:
                pretaxCost = Double(self.quantity) * 15.00
            }
        }
        
        
        
        if self.couponCode == "" {
            return pretaxCost
        } else {
            let discountValue = pretaxCost * 0.2
            pretaxCost -= discountValue
            return pretaxCost
        }
             
        
        
        
    }
    
    
    
    //convenience init
    
}
