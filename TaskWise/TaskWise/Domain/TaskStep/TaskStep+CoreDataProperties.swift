//
//  TaskStep+CoreDataProperties.swift
//  test
//
//  Created by Dálnoky Berci on 08/10/2023.
//
// swiftlint: disable: all

import Foundation
import CoreData


extension TaskStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskStep> {
        return NSFetchRequest<TaskStep>(entityName: "TaskStep")
    }

    @NSManaged public var wIsDone: Bool
    @NSManaged public var wLabel: String?
    @NSManaged public var wIndex: Int16
    @NSManaged public var wTask: Task?

    public var isDone: Bool { wIsDone }
    public var label: String { wLabel ?? "" }
    public var index: Int { Int(wIndex) }

}

extension TaskStep : Identifiable {

}
