//
//  CoreDataStack.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String //create a private property to store the modelName
    
    //we always need this
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    //    modelName: String
    init() {
        self.modelName = "Taskee2" //initializer needed to save the modelName into the private property
    }
    
    //lazy instantiate the NSPersistentContainer, passing the modelName
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores {(storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    //MARK: Save
    func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Fetch Tasks
    //Stolen from Cao - Ask Permission or Delete - This doesn't work with my code
    func fetchTasks(with request: NSFetchRequest<Task> = Task.fetchRequest(), predicate: NSPredicate? = nil, project: String, completion: @escaping(Result<[Task]>) -> Void) {
        
        let categoryPredicate = NSPredicate(format: "theProject.title MATCHES %@", project)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            let tasks = try managedContext.fetch(request)
            completion(.success(tasks))
        } catch {
            completion(.failure(error))
        }
        
        
    }
    
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
