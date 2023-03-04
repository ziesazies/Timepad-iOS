//
//  HomeViewController.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 17/01/23.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController {
    weak var tableView: UITableView!
    
    var tasks: Results<Task>!
    var token: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
        let realm = try! Realm()
        tasks = realm.objects(Task.self)
        token = tasks.observe { [weak self] (changes) in
            guard let `self` = self else {return}
            switch changes {
            case .initial:
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Quiery results have changed
                print("Deleted indices: ", deletions)
                print("Inserted indices: ", insertions)
                print("Modified modifications: ", modifications)
                self.tableView.reloadData()
                
            case .error(let error):
                // An error occured while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    deinit {
        token.invalidate()
    }
    
    func setup() {
        title = "Task"
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: "taskCellId")
        tableView.register(HistoryViewCell.self, forCellReuseIdentifier: "historyCellId")
        tableView.showsVerticalScrollIndicator = false
    }
    
    func unfinishedTask() -> [Task] {
        let filteredTasks = tasks.filter { task in
            return task.start == nil || task.finish == nil
        }
        return Array(filteredTasks)
    }
    
    func finishedTask() -> [Task] {
        let filteredTasks = tasks.filter { task in
            return task.start != nil && task.finish != nil
        }
            .sorted { $0.finish! > $1.finish! }
        
        return Array(filteredTasks)
    }
    
    
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return unfinishedTask().count
        }else {
            return finishedTask().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellId", for: indexPath) as! TaskViewCell
            
            let task = unfinishedTask()[indexPath.row]
            let tag = task.tagType
            cell.timeLabel.text = "00:32:10"
            cell.categoryButton.setTitle(tag?.name, for: .normal)
            cell.categoryButton.setTitleColor(tag?.titleColor, for: .normal)
            cell.categoryButton.layer.borderColor = tag?.titleColor.cgColor
            cell.nameLabel.text = task.title
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellId", for: indexPath) as! HistoryViewCell
            
            let task = finishedTask()[indexPath.row]
            let category = task.categoryType
            cell.iconImageView.image = category?.icon
            cell.nameLabel.text = category?.name
            cell.timeLabel.text = "00:32:10"
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else {
            let view = UIView(frame: .zero)
            view.backgroundColor = UIColor.clear
            
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            label.text = "Task"
            
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            ])
            return view
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        }else {
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
