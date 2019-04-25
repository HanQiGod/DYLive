//
//  ProfileViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/25.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kProfileNormalCellID = "kProfileNormalCellID"

private let kProfileHeaderViewH : CGFloat = kScreenH * 3 / 8 + (kIsPhoneX ? 64 : 40)
private let kBarButtonItemW : CGFloat = 40.0


class ProfileViewController: BaseViewController {
    
    // MARK: 定义属性
    fileprivate var sectionOneArray : [[String : Any]] = [["name":"开播提醒","icon_name":"app3DTouch_checkin"]
        ,["name":"务票查询","icon_name":"home_newSeacrhcon"],["name":"设置选项","icon_name":"image_my_settings"]]
    fileprivate var sectionTwoArray : [[String : Any]] = [["name":"手游中心","icon_name":"Image_handle"]]
    
    // MARK: 懒加载属性
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: -(kIsPhoneX ? 88 : 64), width: kScreenW, height: kScreenH), style: .grouped)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 50
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 1
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableProfileNormalCell", bundle: nil), forCellReuseIdentifier: kProfileNormalCellID)
        
        return tableView
        
    }()
    
    fileprivate lazy var profileHeaderView : ProfileHeaderView = {
        
        let profileHeaderView = ProfileHeaderView.profileHeaderView()
        
        profileHeaderView.frame = CGRect(x: 0, y: -kProfileHeaderViewH, width: kScreenW, height: kProfileHeaderViewH)
        
        return profileHeaderView
        
    }()
    
    fileprivate lazy var leftBarItem : UIBarButtonItem = {
        
        let leftBarItem = UIBarButtonItem.init(imageName: "image_my_settings", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW))
        
        return leftBarItem
        
    }()
    
    fileprivate lazy var rightBarItem : UIBarButtonItem = {
        
        let rightBarItem = UIBarButtonItem.init(imageName: "siteMessageUser", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW))
        
        return rightBarItem
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI
        setUpUI()

    }

}


// MARK: 设置 UI 界面
extension ProfileViewController {
    
    override func setUpUI() {
        
        tableView.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        view.addSubview(tableView)
        
        tableView.addSubview(profileHeaderView)
        
        tableView.contentInset = UIEdgeInsets(top: kProfileHeaderViewH, left: 0, bottom: 0, right: 0)
        
        self.loadDataFinished()
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
        
        super.setUpUI()
    }
    
}


// MARK: 设置导航栏
extension ProfileViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏和阴影为透明色
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
}


// MARK: 遵守 UITableViewDataSource 协议
extension ProfileViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section == 0 ? 3 : 1
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kProfileNormalCellID, for: indexPath) as! TableProfileNormalCell
        
        var array = indexPath.section == 0 ? sectionOneArray : sectionTwoArray
        cell.nameLabel.text = array[indexPath.item]["name"] as! String
        cell.iconImageView.image = UIImage(named: array[indexPath.item]["icon_name"] as! String)
        
        return cell
        
    }
    
}

