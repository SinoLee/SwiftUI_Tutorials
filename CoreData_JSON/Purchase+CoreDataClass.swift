//
//  Purchase+CoreDataClass.swift
//  CoreData_JSON
//
//  Created by Taeyoun Lee on 2023/03/05.
//
//

import Foundation
import CoreData

@objc(Purchase)
public class Purchase: NSManagedObject, Codable {
    required convenience public init(from decoder: Decoder) throws {
        // First we need to extract managed object context to initialize
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw ContextError.NoContextFound
        }
        self.init(context: context)
        
        // Decoding Item
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        dateOfPurchase = try values.decode(Date.self, forKey: .dateOfPurchase)
        title = try values.decode(String.self, forKey: .title)
        amountSpent = try values.decode(Double.self, forKey: .amountSpent)
    }
    
    // Conforming encoding
    public func encode(to encoder: Encoder) throws {
        // Encoding Item
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(id, forKey: .id)
        try values.encode(dateOfPurchase, forKey: .dateOfPurchase)
        try values.encode(title, forKey: .title)
        try values.encode(amountSpent, forKey: .amountSpent)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case dateOfPurchase
        case amountSpent
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum ContextError: Error {
    case NoContextFound
}
