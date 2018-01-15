//
//  CNJManagedObject+CoreDataProperties.swift
//  ChuckNorrisJokes
//
//  Created by Lorence Lim on 21/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//
//

import Foundation
import CoreData


extension CNJJokeManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CNJJokeManagedObject> {
        return NSFetchRequest<CNJJokeManagedObject>(entityName: "Joke")
    }

    @NSManaged public var content: String
    @NSManaged public var id: Int32

}
