//
//  TasksViewModel.swift
//  ToDoApp
//
//  Created by 3Embed on 19/07/20.
//  Copyright © 2020 Bilven. All rights reserved.
//

import UIKit

protocol AddTask {
    func addTask(name: String)
}

class AddTaskController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var taskTextView: UITextView!{
        didSet {
            self.taskTextView.layer.cornerRadius = 5
            self.taskTextView.clipsToBounds = true
            self.taskTextView.layer.borderColor = UIColor.lightGray.cgColor
            self.taskTextView.layer.borderWidth = 0.6
            self.taskTextView.textColor = .lightGray
            self.taskTextView.text = "Type your thoughts here..."
        }
    }
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAction(_ sender: Any) {
        if let delegate = delegate, !taskTextView.text!.isEmpty {
            delegate.addTask(name: taskTextView.text!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if taskTextView.text.isEmpty || taskTextView.text == "" {
            taskTextView.textColor = .lightGray
            taskTextView.text = "Type your thoughts here..."
        }
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if taskTextView.textColor == .lightGray && taskTextView.isFirstResponder {
            taskTextView.text = nil
            taskTextView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let fixedWidth = self.view.frame.size.width - 40 //40 -  both side 20 padding
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        var newHeight = newSize.height
        if newHeight < 35 {
            newHeight = 35
            textView.isScrollEnabled = false
        }
        
        let maxAvailableHeight = self.view.frame.size.height / 3.2
        if newHeight > maxAvailableHeight {
            textView.isScrollEnabled = true
            newHeight = maxAvailableHeight
        }
        
        textFieldHeightConstraint.constant = newHeight
    }
    
}
