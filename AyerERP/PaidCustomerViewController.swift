//
//  PaidCustomerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class PaidCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var deleteView: UIView!
}

class PaidCustomerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var paidCustomerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.paidCustomerTableView.delegate = self
        self.paidCustomerTableView.dataSource = self
        self.transView.isHidden = true
        self.paidCustomerTableView.tableFooterView =  UIView(frame: .zero)
    }
    

    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "PaidCustomerTableViewCellId", for: indexPath) as! PaidCustomerTableViewCell
        
        
        cell.updateView.layer.cornerRadius = 4
        cell.deleteView.layer.cornerRadius = 4
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        // cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    
}
