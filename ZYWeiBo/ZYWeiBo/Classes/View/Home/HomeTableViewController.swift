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
    private lazy var pullupView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(style: .large)
        indicator.color = UIColor.lightGray
        return indicator
    }()
    private lazy var pulldownTipLabel: UILabel = {
        let label = UILabel.init(title: " ", fontSize: 18, color: UIColor.white)
        label.backgroundColor = UIColor.orange
        self.navigationController?.navigationBar.insertSubview(label, at: 0)
        return label
    }()
    
    
    private func showPulldownTip() {
        guard let count = listViewModel.pulldownCount else {
            return
        }
        pulldownTipLabel.text = (count == 0) ? "没有新微博" : "刷新到\(count)条微博"
        let height : CGFloat = 44
        let rect = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: height)
        pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
        UIView.animate(withDuration: 1.0) {
            self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: height)
        } completion: { (_) in
            self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
        }

    }
    
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
        tableView.rowHeight = 400
        tableView.separatorStyle = .none
        
        refreshControl = WBRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        tableView.tableFooterView = pullupView
    }
    
    
    
    @objc private func loadData() {
//        refreshControl?.beginRefreshing()
//        // 4.GCD 主线程/子线程
//        self.tableView.backgroundColor = UIColor.green
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.refreshControl?.endRefreshing()
//            self.tableView.backgroundColor = UIColor.red
//        }
        
        
        refreshControl?.beginRefreshing()
        listViewModel.loadStatus(isPullup: pullupView.isAnimating) { (isSuccessed) in
            self.refreshControl?.endRefreshing()
            if !isSuccessed {
                ZKProgressHUD.showMessage("加载数据失败，请稍后再试")
                return
            }
            self.pullupView.stopAnimating()
//            print(self.listViewModel.statusList)
            self.showPulldownTip()
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
        cell.viewModel = vm
        
        if indexPath.row == listViewModel.statusList.count - 1 && !pullupView.isAnimating {
            //开始动画
            pullupView.startAnimating()
            loadData()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = listViewModel.statusList[indexPath.row]
        return vm.rowHeight
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
