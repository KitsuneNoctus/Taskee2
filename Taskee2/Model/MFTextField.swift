//
//  MFTextField.swift
//  Taskee2
//
//  Created by Henry Calderon on 7/11/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit

class MFTextField: UITextField {

    var placeholderText: String?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder : String) {
        super.init(frame: .zero)
        self.placeholderText = placeholder
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        placeholder = self.placeholderText
        textColor = .black
        font = .systemFont(ofSize: 25)
        
    }

}
