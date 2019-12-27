//
//  WastageReturnListViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit


class WastageReturnListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var invoiceId: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var deleteButtonView: UIView!
}
class WastageReturnListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var wastageReturnTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wastageReturnTableView.delegate = self
        self.wastageReturnTableView.dataSource = self
        self.transView.isHidden = true
        self.wastageReturnTableView.tableFooterView =  UIView(frame: .zero)
       
    }
    override func viewWillAppear(_ animated: Bool) {
   
        
      if CheckInternet.Connection(){
                           //  self.getDataForManageCustomer()
                         }else{
                             Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                         }
        
    }

   
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "WastageReturnListTableViewCellId", for: indexPath) as! WastageReturnListTableViewCell
        
        
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteButtonView(_ sender: UIButton) {
    }
    
}
