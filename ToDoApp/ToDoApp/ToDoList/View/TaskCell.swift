//
//  TasksViewModel.swift
//  ToDoApp
//
//  Created by 3Embed on 19/07/20.
//  Copyright © 2020 Bilven. All rights reserved.
//

import UIKit

protocol CheckBox {
    func checkBox(state: Bool, index: Int?)
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    var indexP: Int?
    var delegate: CheckBox?
    var tasks: [Task]?
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if let tasks = tasks, let indexP = indexP, let delegate = delegate{
            delegate.checkBox(state: !tasks[indexP].checked, index: indexP)
        }
    }

}
