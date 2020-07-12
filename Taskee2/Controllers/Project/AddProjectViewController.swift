//
//  AddProjectViewController.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit
import CoreData

class AddProjectViewController: UIViewController {
    
    let colors: [UIColor] = [UIColor(named: "softRed")!,UIColor(named: "almostPink")!,UIColor(named: "Lavender")!,UIColor(named: "SkyBlue")!,UIColor(named: "ForrestGreen")!,UIColor(named: "lightOrange")!,UIColor(named: "black")!,UIColor(named: "grey")!,UIColor(named: "lightGrey")!]
    
    var coreDataStack: CoreDataStack?
    var project: Project?
    var setColor: UIColor? = nil
    var delegate: ProjectHomeViewController?
    
//    let titleField: UITextField = {
//        let text = UITextField()
//        text.placeholder = "Name Your Project"
//        text.translatesAutoresizingMaskIntoConstraints = false
//        text.font = UIFont(name: "System", size: 25)
//        return text
//    }()
    
    //Directly taken from Mondale
    let titleField = MFTextField(placeholder: "Name Your Project")
    
    let colorCollect = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    
//    let colorCollect: UICollectionView = {
//        let collect = UICollectionView()
//        collect.collectionViewLayout = UICollectionViewFlowLayout.init()
//        collect.translatesAutoresizingMaskIntoConstraints = false
//        collect.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
//        return collect
//    }()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Project or Edit"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        setup()
//        ifEdit()
        isNew()
    }
    
    //MARK: Setup
    func setup(){
        self.view.addSubview(titleField)
        self.view.addSubview(colorCollect)
        
        colorCollect.translatesAutoresizingMaskIntoConstraints = false
        colorCollect.backgroundColor = .systemBackground
        colorCollect.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
        colorCollect.delegate = self
        colorCollect.dataSource = self
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            titleField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
            titleField.heightAnchor.constraint(equalToConstant: 50),
            
            colorCollect.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            colorCollect.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            colorCollect.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            colorCollect.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: Edit
    func ifEdit(){
        
    }
    
    //MARK: New
    func isNew(){
        
    }
    
    //MARK: Touch Action - Save
    @objc func save(){
        guard let title = titleField.text, !title.isEmpty else { return }
        guard let project = project else {
            let newProject = Project(context: coreDataStack!.managedContext)
            newProject.title = title
            newProject.color = setColor
            self.navigationController?.popViewController(animated: true)
            return
        }
        
//        if project.color == nil { //user did not select any colors
//
//        }
        project.title = title
        project.color = setColor
        coreDataStack?.saveContext()
//        if project != nil{
//            project?.setValue(titleField.text, forKey: "title")
//            if setColor != nil{
//                project?.setValue(setColor, forKey: "color")
//            }
//            coreDataStack?.saveContext()
//        }else{
//            let newProject = Project(context: coreDataStack!.managedContext)
//            newProject.title = titleField.text
//            newProject.color = setColor
//            coreDataStack?.saveContext()
//        }
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: Collection View Del & data
extension AddProjectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        cell.layer.cornerRadius = cell.frame.size.width/2
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.setColor = colors[indexPath.row]
        print(colors[indexPath.row])
        print(indexPath)
    }
    
    
}


//MARK: Setting flow layut
//Courtesy of Mondale
extension AddProjectViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60  , height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 20 , left: 20  ,  bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}
