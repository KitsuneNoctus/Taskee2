//
//  TasksCell.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit

class TasksCell: UITableViewCell {
    static var identifier = "TasksCell"
    
    var tapCheck: (()->Void)?
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    let check = CheckBox.init()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup(){
        check.frame = CGRect(x: 25, y: 25, width: 35, height: 35)
        check.style = .tick
        check.borderStyle = .roundedSquare(radius: 8)
        check.addTarget(self, action: #selector(todoChecked(_:)), for: .valueChanged)
        self.contentView.addSubview(check)
        
        self.contentView.addSubview(taskLabel)
        
        NSLayoutConstraint.activate([
            check.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            taskLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            check.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            taskLabel.leadingAnchor.constraint(equalTo: check.trailingAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func todoChecked(_ sender: CheckBox) {
        tapCheck!()
    }
    
}
