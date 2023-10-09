//
//  ColorComponents+CoreDataProperties.swift
//  test
//
//  Created by Dálnoky Berci on 08/10/2023.
//
// swiftlint: disable: all

import Foundation
import CoreData


extension ColorComponents {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorComponents> {
        return NSFetchRequest<ColorComponents>(entityName: "ColorComponents")
    }

    @NSManaged public var wAlpha: Double
    @NSManaged public var wBlue: Double
    @NSManaged public var wGreen: Double
    @NSManaged public var wRed: Double
    @NSManaged public var wTask: Task?

    public var alpha: Double { wAlpha }
    public var blue: Double { wBlue }
    public var green: Double { wGreen }
    public var red: Double { wRed }

}

extension ColorComponents : Identifiable {

}
