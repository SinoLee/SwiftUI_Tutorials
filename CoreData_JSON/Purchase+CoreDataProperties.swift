//
//  Purchase+CoreDataProperties.swift
//  CoreData_JSON
//
//  Created by Taeyoun Lee on 2023/03/05.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var amountSpent: Double

}

extension Purchase : Identifiable {

}
