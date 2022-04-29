//
//  GFRepoItemVC.swift
//  GitSample
//
//  Created by master on 4/29/22.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.setBackgroundColor(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
