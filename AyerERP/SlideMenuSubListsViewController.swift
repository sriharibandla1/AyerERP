//
//  SlideMenuSubListsViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/18/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class SlideMenuSubListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var slidemenuSublistNameLabel: UILabel!
}
class SlideMenuSubListsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var subListTitleNameLabel: UILabel!
    @IBOutlet weak var slideMenuSubListTableview: UITableView!
    var slidemenuSubListArray = NSMutableArray()
    var sublistTitelName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subListTitleNameLabel.text = sublistTitelName
        self.slideMenuSubListTableview.delegate = self
        self.slideMenuSubListTableview.dataSource = self
        self.slideMenuSubListTableview.tableFooterView =  UIView(frame: .zero)
    }
    

    // MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.slidemenuSubListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "SlideMenuSubListTableViewCellId", for: indexPath) as! SlideMenuSubListTableViewCell
        cell.slidemenuSublistNameLabel.text = self.slidemenuSubListArray[indexPath.row] as? String
        
        cell.cellView.layer.shadowColor = UIColor.gray.cgColor
        cell.cellView.layer.shadowOpacity = 1
         cell.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width:1, height: 1)
        cell.cellView.layer.shadowRadius = 2
        cell.cellView.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if self.sublistTitelName == "Accounts"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CashBookViewControllerId") as? CashBookViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InventoryLedgerViewControllerId") as? InventoryLedgerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    else if self.sublistTitelName == "Customer"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageNewApplicationViewControllerId") as? ManageNewApplicationViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerViewControllerId") as? ManageCustomerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerUpdateApplicantsViewControllerId") as? ManageCustomerUpdateApplicantsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 3 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageActiveCustomerViewControllerId") as? ManageActiveCustomerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageInactiveCustomerViewControllerId") as? ManageInactiveCustomerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }         }
     else if self.sublistTitelName == "Return"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StockReturnViewControllerId") as? StockReturnViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SupplierReturnListViewControllerId") as? SupplierReturnListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WastageReturnListViewControllerId") as? WastageReturnListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
     }
    else if self.sublistTitelName == "Stock"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StockReportViewControllerId") as? StockReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SupplierwiseStockReportViewControllerId") as? SupplierwiseStockReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductWiseStockReportViewControllerId") as? ProductWiseStockReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    else if self.sublistTitelName == "Report"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ClosingReportViewControllerId") as? ClosingReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TodaysReportViewControllerId") as? TodaysReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TodaysCustomerReportViewControllerId") as? TodaysCustomerReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 3{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SalesReportViewControllerId") as? SalesReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 4{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DueReportViewControllerId") as? DueReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 5{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShippingCostReportViewControllerId") as? ShippingCostReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 6{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PurchaseReportViewControllerId") as? PurchaseReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 7{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "categoryWisePurchaseReportViewControllerId") as? categoryWisePurchaseReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 8{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductWiseSalesReportViewControllerId") as? ProductWiseSalesReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CategoryWiseSalesReportViewControllerId") as? CategoryWiseSalesReportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    else if self.sublistTitelName == "CustomerCenter"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerInformationViewControllerId") as? CustomerInformationViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerLedgerViewControllerId") as? CustomerLedgerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerSupportViewControllerId") as? CustomerSupportViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    else if self.sublistTitelName == "Software Settings"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddUsersViewControllerId") as? AddUsersViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageUsersViewControllerId") as? ManageUsersViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    else if self.sublistTitelName == "Role Permission"{
        if indexPath.row == 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RoleListViewControllerId") as? RoleListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else{
              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserAssignRoleViewControllerId") as? UserAssignRoleViewController
              
                   self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    }
    

    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
}
