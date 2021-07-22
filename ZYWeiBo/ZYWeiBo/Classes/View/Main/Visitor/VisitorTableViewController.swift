//
//  VisitorTableViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/19.
//

import UIKit

class VisitorTableViewController: UITableViewController {

    private var userLogon = false
    var visitorView:VisitorView?


    override func loadView() {
        userLogon ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView() {
        visitorView = VisitorView()
        view = visitorView
        visitorView?.registerButton.addTarget(self, action: #selector(visitorViewDidRegister), for: .touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(visitorViewDidLogin), for: .touchUpInside)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VisitorTableViewController {
    @objc func visitorViewDidRegister() {
        print("注册")
    }
    
    @objc func visitorViewDidLogin() {
        print("登录")
        let vc = ZYOAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}
