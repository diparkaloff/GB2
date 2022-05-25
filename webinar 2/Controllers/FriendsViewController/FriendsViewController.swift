//
//  FriendsViewController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 20.02.22.
//

import UIKit

class FriendsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var friendsArray = [Friend]()
    let reuseIdentifier = "reuseIdentifier"
    let fromFriendsToGallery = "fromFriendsToGallery"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        createFriendsArray()
        tableView.reloadData()
    }
    
    func createFriendsArray() {
        
        let friend1 = Friend(name: "Squid fans", avatar: "1", fotos: ["1", "2", "15", "16"])
        friendsArray.append(friend1)
        
        let friend2 = Friend(name: "Bob fans", avatar: "2", fotos: ["3", "4", "5", "10"])
        friendsArray.append(friend2)
        
        let friend3 = Friend(name: "puh", avatar: "3", fotos: ["6", "7", "8", "14"])
        friendsArray.append(friend3)
        
        let friend4 = Friend(name: "space laptop", avatar: "4", fotos: ["9", "10", "11", "17"])
        friendsArray.append(friend4)
        
        let friend5 = Friend(name: "cat", avatar: "8", fotos: ["12", "13", "14", "15"])
        friendsArray.append(friend5)
        
        let friend6 = Friend(name: "linux", avatar: "15", fotos: ["1", "15", "16", "17"])
        friendsArray.append(friend6)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallery {
            guard let destinationViewController = segue.destination as? GalleryViewController,
                  let fotoArray = sender as? [String]
            else {return}
        
            destinationViewController.fotoArray = fotoArray
                        
        }
        
    }
    
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected \(friendsArray[indexPath.row].name) friend")
//        performSegue(withIdentifier: fromFriendsToGallery, sender: friendsArray[indexPath.row].fotos)
//    }
}



extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cyan
        } else {
            cell.backgroundColor = UIColor.green
        }
        cell.configure(friend: friendsArray[indexPath.row], completion: {[weak self] in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.fromFriendsToGallery, sender: self.friendsArray[indexPath.row].fotos)
        })
        return cell
    }
}
