//
//  MyGroupsController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 20.02.22.
//

import UIKit

class MyGroupsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "reuseIdentifier"
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()

    }
  
}


extension MyGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(Storage.shared.getMyGroups()[indexPath.row].name) group")
    }
}



extension MyGroupsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.getMyGroups().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.systemOrange
        } else {
            cell.backgroundColor = UIColor.green
        }
        cell.configure(group: Storage.shared.getMyGroups()[indexPath.row])
        return cell
    }
    
    
}
