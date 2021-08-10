//
//  HomeTableViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/16.
//

import UIKit
import Alamofire
import ZKProgressHUD

let StatusCellNormalId = "StatusCellNormalId"
let StatusCellRetweetedId = "StatusCellRetweetedId"

class HomeTableViewController: VisitorTableViewController {
    
    var dataList:[StatusViewModel]?
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
        tableView.register(StatusNormalCell.self, forCellReuseIdentifier: StatusCellNormalId)
        tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedId)
        tableView.estimatedRowHeight = 400
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 400
        tableView.separatorStyle = .none
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
        let vm = listViewModel.statusList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellId, for: indexPath) as! StatusCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellRetweetedId, for: indexPath) as! StatusRetweetedCell
        cell.viewModel = vm
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = listViewModel.statusList[indexPath.row]
        let cell = StatusCell.init(style: .default, reuseIdentifier: vm.cellId)
//        let cell = StatusRetweetedCell.init(style: .default, reuseIdentifier: StatusCellRetweetedId)
        cell.viewModel = vm
        return cell.rowHeights
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
