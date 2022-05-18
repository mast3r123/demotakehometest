//
//  GFTextField.swift
//  GitSample
//
//  Created by master on 4/2/22.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        returnKeyType = .go
        clearButtonMode = .whileEditing
        
        placeholder = "Enter a username"
    }
    
    private func addToolBar() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        resignFirstResponder()
    }
}
