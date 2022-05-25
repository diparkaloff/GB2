//
//  Storage.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 20.02.22.
//

import UIKit

class Storage: NSObject {

    static let shared = Storage()
    
    private override init() {
        super.init()
    }
    
    private var myGroups = [Group]()
    
    func getMyGroups() -> [Group] {
        return myGroups
    }
    
    func addGroups(group: Group) {
        myGroups.append(group)
    }
    
    
    
}
