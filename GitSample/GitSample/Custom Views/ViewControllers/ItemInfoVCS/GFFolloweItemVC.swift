//
//  GFFolloweItemVC.swift
//  GitSample
//
//  Created by master on 4/29/22.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        
        actionButton.setBackgroundColor(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
