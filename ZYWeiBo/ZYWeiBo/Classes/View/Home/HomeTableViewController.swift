//
//  HomeTableViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/16.
//

import UIKit
import Alamofire
import ZKProgressHUD

class HomeTableViewController: VisitorTableViewController {
    
    private let StatusCellNormalId = "StatusCellNormalId"
    var dataList:[Status]?
    private lazy var listViewModel = StatusListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
        
        if !UserAccountViewModel.sharedUserAccount.userLogon {
            visitorView?.setupInfo(imageName: nil, title: "关注一些人,回这里看看有什么惊喜")
            return
        }
        loadData()
    }
    
    
    private func prepareTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StatusCellNormalId)
    }
    
    
    
    private func loadData() {
        listViewModel.loadStatus { (isSuccessed) in
            if !isSuccessed {
                ZKProgressHUD.showMessage("加载数据失败，请稍后再试")
//                rootVC.window?.rootViewController = MainVC()
                
                return
            }
            print(self.listViewModel.statusList)
            self.tableView.reloadData()
        }
    }

}

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath)
        cell.textLabel?.text = self.listViewModel.statusList[indexPath.row].user?.screen_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
