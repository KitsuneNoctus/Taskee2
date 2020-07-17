//
//  ProjectCell.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    static var identifier = "ProjectCell"
    
    let colorTag: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.frame.size.width/2
        return view
    }()
    
    let projectTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "System", size: 20)
        return label
    }()
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "System", size: 12)
        label.textColor = .systemGray
        return label
    }()
    
    init(color: String, title:String, tasks: Int) {
        super.init(style: .default, reuseIdentifier: "ProjectCellFinal")
        colorTag.backgroundColor = UIColor(named: color)
        projectTitle.text = title
        taskLabel.text = "\(tasks) tasks left"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configure(){
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(colorTag)
        contentView.addSubview(projectTitle)
        contentView.addSubview(taskLabel)
        NSLayoutConstraint.activate([
            //Color
            colorTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorTag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            colorTag.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            colorTag.widthAnchor.constraint(equalToConstant: 50),
            //Project
            projectTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            projectTitle.leadingAnchor.constraint(equalTo: colorTag.trailingAnchor, constant: 20),
            projectTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            projectTitle.heightAnchor.constraint(equalToConstant: contentView.frame.height/2),
            //Tasks
            taskLabel.leadingAnchor.constraint(equalTo: colorTag.trailingAnchor, constant: 20),
            taskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            taskLabel.topAnchor.constraint(equalTo: projectTitle.bottomAnchor, constant: 5)
            
            
        ])
    }

}
