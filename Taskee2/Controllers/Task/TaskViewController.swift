//
//  TaskViewController.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    var projectTitle: String = "Project Name"
    
    let dummyData: [TaskItem] = [
        TaskItem(name: "Task 1", checked: false),
        TaskItem(name: "Task 2", checked: false),
        TaskItem(name: "Task 3", checked: false),
        TaskItem(name: "Task 4", checked: true)
    ]
    
    private var doneTask: [TaskItem] = []
    private var todoTask: [TaskItem] = []
    
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
    
    //MARK: @OBJC
    @objc func addTask(){
        navigationController?.pushViewController(NewEditTaskViewController(), animated: true)
    }
    
    @objc func changeUp(){
        taskTable.reloadData()
    }

}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch self.todoSelector.selectedSegmentIndex {
        case 0:
            for t in dummyData{
                if t.checked == false{
                    count += 1
                    todoTask.append(t)
                }
            }
        default:
            for t in dummyData{
                if t.checked == true{
                    count += 1
                    doneTask.append(t)
                }
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksCell.identifier, for: indexPath) as! TasksCell
        switch self.todoSelector.selectedSegmentIndex {
        case 0:
            cell.taskLabel.text = todoTask[indexPath.row].name
            cell.check.isChecked = todoTask[indexPath.row].checked
        default:
            cell.taskLabel.text = doneTask[indexPath.row].name
            cell.check.isChecked = doneTask[indexPath.row].checked
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! TasksCell
//
//    }
    
    
}

