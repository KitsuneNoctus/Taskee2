//
//  NewEditTaskViewController.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit
import CoreData

class NewEditTaskViewController: UIViewController {
    
    var project: Project!
    var task: Task?
    var coreDataStack: CoreDataStack?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Due Date"
        return label
    }()
    
    let titleField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "e.g. Create repository"
        return field
    }()
    
    let dateField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "mm/dd/yyyy"
        return field
    }()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Task or Edit"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Task", style: .plain, target: self, action: #selector(saveTask))
        setup()
        if task != nil{
            config()
        }
        
    }
    
    //MARK: Setup
    func setup(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleField)
        self.view.addSubview(dateLabel)
        self.view.addSubview(dateField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: self.titleField.bottomAnchor, constant: 30),
            dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            dateField.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10),
            dateField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    func config(){
        
    }
    
    //MARK: Save Task
    @objc func saveTask(){
        print("Saving")
        if task == nil{
            
        }else{
            
        }
    }

}
