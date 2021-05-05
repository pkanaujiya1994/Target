//
//  Product.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import Foundation

struct ProductModelResponse: Codable {
    
    var products:[Product] = [Product]()
    
    
}

struct Product: Codable {
    private(set) var id: Int
    private(set) var title: String
    private(set) var aisle: String?
    private(set) var description: String?
    private(set) var imageUrl: String?
    private(set)  var regularPrice: RegularPrice
    private(set) var salePrice: SalePrice?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case aisle
        case imageUrl = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
    }
}

struct RegularPrice: Codable {
    private(set) var amount: Int
    private(set) var currency: String
    private(set) var displayString: String
    enum CodingKeys: String, CodingKey {
        case amount = "amount_in_cents"
        case currency = "currency_symbol"
        case displayString = "display_string"
    }
}


struct SalePrice: Codable {
    private(set) var amount: Int
    private(set) var currency: String
    private(set) var displayString: String
    enum CodingKeys: String, CodingKey {
        case amount = "amount_in_cents"
        case currency = "currency_symbol"
        case displayString = "display_string"
    }
}
