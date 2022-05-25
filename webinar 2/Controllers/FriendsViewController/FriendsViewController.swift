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
        
        let friend1 = Friend(name: "Squid fans", avatar: "1", fotos: ["1", "2"])
        friendsArray.append(friend1)
        
        let friend2 = Friend(name: "Bob fans", avatar: "3", fotos: ["3", "4", "5"])
        friendsArray.append(friend2)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(friendsArray[indexPath.row].name) friend")
        performSegue(withIdentifier: fromFriendsToGallery, sender: friendsArray[indexPath.row].fotos)
    }
}



extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.systemBlue
        } else {
            cell.backgroundColor = UIColor.magenta
        }
        cell.configure(friend: friendsArray[indexPath.row])
        return cell
    }
}
