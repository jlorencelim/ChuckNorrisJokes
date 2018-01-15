//
//  CNJManagedObject+CoreDataClass.swift
//  ChuckNorrisJokes
//
//  Created by Lorence Lim on 21/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CNJJokeManagedObject)
public class CNJJokeManagedObject: NSManagedObject {

    func toString() -> String {
        return "[\(self.id)] \(self.content)"
    }
}
