//
//  TaskViewController.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    var tasks = [Task]()
    var theProject: Project?
    
    var projectTitle: String = "Project Name"
    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
//        print(fetchedResultsController)
        
        return fetchedResultsController
    }()
    
    let todoSelector: UISegmentedControl = {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = .systemGreen
        return control
    }()
    
    let taskTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(TasksCell.self, forCellReuseIdentifier: TasksCell.identifier)
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        return table
    }()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = projectTitle
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Task", style: .plain, target: self, action: #selector(addTask))
        setupControl()
        setupTable()
        fetchTodoTasks()
        taskTable.reloadData()
    }
        
    
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchResults()
        taskTable.reloadData()
    }
    
    //MARK: Setup
    func setupTable(){
        taskTable.delegate = self
        taskTable.dataSource = self
        self.view.addSubview(taskTable)
        NSLayoutConstraint.activate([
            taskTable.topAnchor.constraint(equalTo: self.todoSelector.bottomAnchor, constant: 20),
            taskTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            taskTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            taskTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setupControl(){
        todoSelector.insertSegment(withTitle: "TODO", at: 0, animated: true)
        todoSelector.insertSegment(withTitle: "DONE", at: 1, animated: true)
        todoSelector.selectedSegmentIndex = 0
        todoSelector.addTarget(self, action: #selector(changeUp), for: .valueChanged)
        self.view.addSubview(todoSelector)
        NSLayoutConstraint.activate([
            todoSelector.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            todoSelector.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            todoSelector.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            todoSelector.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    //MARK: Fetch - Urgent
    
    func fetchTodoTasks(){
        let projectPredicate = NSPredicate(format: "project == %@", theProject!)
        let statusTodoPredicate = NSPredicate(format: "status = false")
        fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [projectPredicate, statusTodoPredicate])
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print(error)
        }
    }
    
    func fetchDoneTasks(){
        let projectPredicate = NSPredicate(format: "project == %@", theProject!)
        let statusDonePredicate = NSPredicate(format: "status = true")
        fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [projectPredicate, statusDonePredicate])
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print(error)
        }
    }
    
    //MARK: @OBJC
    @objc func addTask(){
        let vc = NewEditTaskViewController()
        vc.coreDataStack = coreDataStack
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeUp(){
        switch todoSelector.selectedSegmentIndex {
        case 0:
            fetchTodoTasks()
        case 1:
            fetchDoneTasks()
        default:
            break
        }
        taskTable.reloadData()
    }

}

//MARK: Configure
extension TaskViewController{
    func configure(cell: UITableViewCell, for indexPath: IndexPath){
        guard let cell = cell as? TasksCell else { return }
        let task = fetchedResultsController.object(at: indexPath)
//        let project = fetchedResultsController.object(at: indexPath)
        cell.check.isChecked = task.status
        cell.taskLabel.text = task.title
    }
}

//MARK: TableView Delegate and Data Source
extension TaskViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo =
            fetchedResultsController.sections?[section] else {
                return 0
        }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksCell.identifier, for: indexPath) as! TasksCell
        configure(cell: cell, for: indexPath)
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell = tableView.cellForRow(at: indexPath) as! TasksCell
    //
    //    }
    
    
}
//MARK: Fetched Results Controller
extension TaskViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      taskTable.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
      
      switch type {
      case .insert:
        taskTable.insertRows(at: [newIndexPath!], with: .automatic)
      case .delete:
        taskTable.deleteRows(at: [indexPath!], with: .automatic)
      case .update:
        let cell = taskTable.cellForRow(at: indexPath!) as! TasksCell
        configure(cell: cell, for: indexPath!)
      case .move:
        taskTable.deleteRows(at: [indexPath!], with: .automatic)
        taskTable.insertRows(at: [newIndexPath!], with: .automatic)
      }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      taskTable.endUpdates()
    }
}


