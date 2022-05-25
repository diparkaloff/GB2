//
//  AllGroupsController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 16.02.22.
//

import UIKit

class AllGroupsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let reuseIdentifier = "reuseIdentifier"
    var sourceGroupsArray = [Group]()
    
    var groupsArray = [Group]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        createGroupsArray()
        groupsArray = sourceGroupsArray
        tableView.reloadData()
        }

    func createGroupsArray() {
        let group1 = Group(avatarImagePath: "1", name: "Squid fans", discription: "описание группы")
        sourceGroupsArray.append(group1)
        
        let group2 = Group(avatarImagePath: "2", name: "Bob fans", discription: "описание группы")
        sourceGroupsArray.append(group2)
        
        let group3 = Group(avatarImagePath: "3", name: "Puh fans", discription: "описание группы")
        sourceGroupsArray.append(group3)
        
        let group4 = Group(avatarImagePath: "4", name: "Among fans", discription: "описание группы")
        sourceGroupsArray.append(group4)
        
        let group5 = Group(avatarImagePath: "5", name: "Roblox fans", discription: "описание группы")
        sourceGroupsArray.append(group5)
        
        let group6 = Group(avatarImagePath: "6", name: "car fans", discription: "описание группы")
        sourceGroupsArray.append(group6)
        
        let group7 = Group(avatarImagePath: "7", name: "Corgi fans", discription: "описание группы")
        sourceGroupsArray.append(group7)
        
        let group8 = Group(avatarImagePath: "8", name: "Cat fans", discription: "описание группы")
        sourceGroupsArray.append(group8)
        
        let group9 = Group(avatarImagePath: "9", name: "Money fans", discription: "описание группы")
        sourceGroupsArray.append(group9)
        
        let group10 = Group(avatarImagePath: "10", name: "Radiation fans", discription: "описание группы")
        sourceGroupsArray.append(group10)
        
        let group11 = Group(avatarImagePath: "11", name: "Timon fans", discription: "описание группы")
        sourceGroupsArray.append(group11)
        
        let group12 = Group(avatarImagePath: "12", name: "Wolf fans", discription: "описание группы")
        sourceGroupsArray.append(group12)
        
        let group13 = Group(avatarImagePath: "13", name: "Operator fans", discription: "описание группы")
        sourceGroupsArray.append(group13)
        
        let group14 = Group(avatarImagePath: "14", name: "Child fans", discription: "описание группы")
        sourceGroupsArray.append(group14)
        
        let group15 = Group(avatarImagePath: "15", name: "Linux fans", discription: "описание группы")
        sourceGroupsArray.append(group15)
        
        let group16 = Group(avatarImagePath: "16", name: "Minion fans", discription: "описание группы")
        sourceGroupsArray.append(group16)
        
        let group17 = Group(avatarImagePath: "17", name: "Rose fans", discription: "описание группы")
        sourceGroupsArray.append(group17)
        
    }

    
}


extension AllGroupsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            groupsArray = sourceGroupsArray
        }
        else {
            groupsArray = sourceGroupsArray.filter({ groupItem in
                groupItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}



extension AllGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
        func isContain(group: Group) -> Bool {
            for item in Storage.shared.getMyGroups() {
                if item.name == group.name {
                    return true
                }
            }
            return false
        }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(groupsArray[indexPath.row].name) group")
        if !isContain(group: groupsArray[indexPath.row]) {
            Storage.shared.addGroups(group: groupsArray[indexPath.row])
        }
    }
}


extension AllGroupsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.systemOrange
        } else {
            cell.backgroundColor = UIColor.green
        }
        cell.configure(group: groupsArray[indexPath.row])
        return cell
    }
    
    
}
