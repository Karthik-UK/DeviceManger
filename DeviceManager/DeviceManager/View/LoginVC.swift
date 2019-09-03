//
//  LoginVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

let lll = ["email" , "Pass"]
class LoginVC:BaseVC,UITableViewDelegate,UITableViewDataSource{
@IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginCell.self), for: indexPath) as? LoginCell {
            cell.cellLabel.text = lll[indexPath.row]
            //            cell.imageOutlet.image = UIImage(named: newsModel.news[index.row].imagenews)
            //            cell.labelOutlet.text = newsModel.news[index.row].categorynews
            //            cell.labelExplain.text = newsModel.news[index.row].descriptionnews
            //            cell.selectionStyle = .none
            return cell
        }
        return LoginCell()
        
}
}
