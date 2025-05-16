//
//  Entity+CoreDataProperties.swift
//  TodayDiary
//
//  Created by 서정원 on 5/12/25.
//
//

import Foundation
import CoreData


extension Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var currentDay: Date?
    @NSManaged public var emoji: String?
    @NSManaged public var good: String?
    @NSManaged public var howToday: String?
    @NSManaged public var improve: String?

}

extension Entity : Identifiable {

}
