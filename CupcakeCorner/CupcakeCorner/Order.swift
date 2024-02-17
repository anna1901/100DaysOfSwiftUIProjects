//
//  Order.swift
//  CupcakeCorner
//
//  Created by Anna Olak on 06/02/2024.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _extraFrosting = "extraFrosting"
        case _addSprincles = "addSprincles"
        case _name = "addSprinamencles"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprincles = false
            }
        }
    }
    var extraFrosting = false
    var addSprincles = false
    
    var name = UserDefaults.standard.string(forKey: "orderAddressName") ?? "" {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "orderAddressName")
        }
    }
    var streetAddress = UserDefaults.standard.string(forKey: "orderStreetAddress") ?? "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "orderStreetAddress")
        }
    }
    var city = UserDefaults.standard.string(forKey: "orderAddressCity") ?? "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "orderAddressCity")
        }
    }
    var zip = UserDefaults.standard.string(forKey: "orderAddressZip") ?? "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "orderAddressZip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        //complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.5/cake for sprinkles
        if addSprincles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
