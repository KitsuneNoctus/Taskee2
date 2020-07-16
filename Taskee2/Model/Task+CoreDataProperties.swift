//
//  Task+CoreDataProperties.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/15/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var duedate: Date?
    @NSManaged public var status: Bool
    @NSManaged public var title: String?
    @NSManaged public var project: Project?

}
