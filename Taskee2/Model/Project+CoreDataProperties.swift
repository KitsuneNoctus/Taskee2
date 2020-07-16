//
//  Project+CoreDataProperties.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/15/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit.UIColor

extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var title: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Project {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
