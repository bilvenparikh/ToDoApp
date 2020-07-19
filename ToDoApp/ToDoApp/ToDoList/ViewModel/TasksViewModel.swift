//
//  TasksViewModel.swift
//  ToDoApp
//
//  Created by 3Embed on 19/07/20.
//  Copyright © 2020 Bilven. All rights reserved.
//

import UIKit

class TasksViewModel: NSObject {
    
    static var obj: TasksViewModel? = nil
    static var shared: TasksViewModel {
        if obj == nil {
            obj = TasksViewModel()
        }
        return obj!
    }

    
    func getTasks()-> [Task]{
        let userDefaults = UserDefaults.standard
        do {
            let tasks = try userDefaults.GetObject(forKey: "ToDoList", castTo: [Task].self)
            return tasks
        } catch {
            return []
        }
    }
    
    func addTask(task : Task){
        var addedTasks = getTasks()
        addedTasks.append(task)
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.SetObject(addedTasks, forKey: "ToDoList")
        } catch {
            print("Unable to save Tasks")
        }
    }
    
    func updateTask(task : Task){
        
        var arrTasks = getTasks()
        if let index = arrTasks.firstIndex(where: {$0.id == task.id}){
            arrTasks[index] = task
        }
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.SetObject(arrTasks, forKey: "ToDoList")
        } catch {
            print("Unable to save Tasks")
        }

    }
    
    func deleteTask(index : Int){
        var arrTasks = getTasks()
        arrTasks.remove(at: index)
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.SetObject(arrTasks, forKey: "ToDoList")
        } catch {
            print("Unable to save Tasks")
        }
    }

}
