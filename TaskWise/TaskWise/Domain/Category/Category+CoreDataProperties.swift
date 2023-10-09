//
//  Category+CoreDataProperties.swift
//  test
//
//  Created by Dálnoky Berci on 08/10/2023.
//
// swiftlint: disable: all

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var wId: UUID?
    @NSManaged public var wName: String?
    @NSManaged public var wTasks: NSSet?

    public var id: UUID { wId ?? UUID() }
    public var name: String { wName ?? "" }

}

// MARK: Generated accessors for wTasks
extension Category {

    @objc(addWTasksObject:)
    @NSManaged public func addToWTasks(_ value: Task)

    @objc(removeWTasksObject:)
    @NSManaged public func removeFromWTasks(_ value: Task)

    @objc(addWTasks:)
    @NSManaged public func addToWTasks(_ values: NSSet)

    @objc(removeWTasks:)
    @NSManaged public func removeFromWTasks(_ values: NSSet)

}

extension Category : Identifiable {

}
