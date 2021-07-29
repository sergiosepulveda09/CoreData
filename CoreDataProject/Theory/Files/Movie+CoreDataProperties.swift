//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Sergio Sepulveda on 2021-07-28.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }


}

extension Movie : Identifiable {
    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
}
