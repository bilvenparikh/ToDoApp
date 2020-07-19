//
//  TasksViewController.swift
//  ToDoApp
//
//  Created by 3Embed on 19/07/20.
//  Copyright © 2020 Bilven. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    class func instantiate() -> TasksViewController{
        let vc : TasksViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "TasksViewController") as! TasksViewController
        return vc
    }
    
    @IBOutlet weak var vwNoTasks: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            
        }
    }
    
    var tasks: [Task] = TasksViewModel.shared.getTasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        vwNoTasks.isHidden = tasks.count > 0
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }
    

}

// MARK: - TableView DataSource
extension TasksViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        cell.checkBoxOutlet.isSelected = tasks[indexPath.row].checked
        
        cell.delegate = self
        cell.tasks = tasks
        cell.indexP = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let alert = UIAlertController.init(title: nil, message: "Are you sure you want to delete this task?", preferredStyle: .alert)
            let alertActionOK = UIAlertAction.init(title: "OK", style: .destructive) { (action) in
                TasksViewModel.shared.deleteTask(index: indexPath.row)
                self.tasks.remove(at: indexPath.row)
                tableView.reloadData()
                self.vwNoTasks.isHidden = self.tasks.count > 0
            }
            let alertActionCancel = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
                
            }
            alert.addAction(alertActionOK)
            alert.addAction(alertActionCancel)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension TasksViewController : CheckBox{
    func checkBox(state: Bool, index: Int?) {
        if let index = index{
            tasks[index].checked = state
            TasksViewModel.shared.updateTask(task: tasks[index])
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
}


extension TasksViewController : AddTask{
    func addTask(name: String) {
        let task = Task(name: name)
        tasks.append(task)
        TasksViewModel.shared.addTask(task: task)
        tableView.reloadData()
    }
}
