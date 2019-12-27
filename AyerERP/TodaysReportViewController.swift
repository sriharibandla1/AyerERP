//
//  TodaysReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class TodaysReportTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var salesDateLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
}
class TodaysReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var todaysReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var salesreportButton: UIButton!
    @IBOutlet weak var salesReportLabel: UILabel!
    @IBOutlet weak var purchaseReportButton: UIButton!
    @IBOutlet weak var purchaseReportLabel: UILabel!
    @IBOutlet weak var fragmentView: UIView!
    @IBOutlet weak var noRecordsLabel: UILabel!
    @IBOutlet weak var totalAmountView: UIView!
    
    var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.todaysReportTableView.delegate = self
        self.todaysReportTableView.dataSource = self
        self.transView.isHidden = true
        self.todaysReportTableView.tableFooterView =  UIView(frame: .zero)
        
        self.salesreportButton.setTitleColor(UIColor.customBlueBG, for: .normal)
        self.salesReportLabel.backgroundColor = UIColor.customBlueBG
        self.purchaseReportButton.setTitleColor(UIColor.lightGrayBG, for: .normal)
        self.purchaseReportLabel.backgroundColor = UIColor.lightGrayBG
        Design()
        
        
        
        getDataFromServersalesreport()
    }
    
    
    
    // MARK: - Design

    func Design(){
        self.fragmentView.layer.shadowColor = UIColor.lightGray
        self.fragmentView.layer.shadowOpacity = 1
        self.fragmentView.layer.masksToBounds = false
        self.fragmentView.layer.shadowOffset = CGSize(width: 1, height: 1)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
                               self.getDataFromServersalesreport()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
    }
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "TodaysReportTableViewCellId", for: indexPath) as! TodaysReportTableViewCell
        
        
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        let item = self.dataForTableView[indexPath.row]
        cell.salesDateLabel.text = "Sales Date : \(item["sales_date"] ?? "")"
        cell.invoiceNoLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
        cell.totalAmountLabel.text = "Total Amount : $\(item["total_amount"] ?? "")"
        cell.customerNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func salesReportbtnAction(_ sender: UIButton) {
        getDataFromServersalesreport()
        self.salesreportButton.setTitleColor(UIColor.customBlueBG, for: .normal)
        self.salesReportLabel.backgroundColor = UIColor.customBlueBG
        self.purchaseReportButton.setTitleColor(UIColor.lightGrayBG, for: .normal)
        self.purchaseReportLabel.backgroundColor = UIColor.lightGrayBG
        
    }
    
    @IBAction func purchaseReportBtnAction(_ sender: Any) {
        
        self.salesreportButton.setTitleColor(UIColor.lightGrayBG, for: .normal)
        self.salesReportLabel.backgroundColor = UIColor.lightGrayBG
        self.purchaseReportButton.setTitleColor(UIColor.customBlueBG, for: .normal)
        self.purchaseReportLabel.backgroundColor = UIColor.customBlueBG
        
        
        self.todaysReportTableView.isHidden = true
        self.totalAmountView.isHidden = true
        self.noRecordsLabel.isHidden = false
    }
    
    // MARK: - Network
    
    func getDataFromServersalesreport()
    {
        let url : URL = URL(string: BaseUrl + "/todays_sales_report")!
        
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
            print(response.request as Any)  // original URL request
            print(response.response as Any)// URL response
            let response1 = response.response
            if response1?.statusCode == 200
            {
                do{
                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    print(jsonRespone)
                    var items = NSDictionary()
                    items = jsonRespone as! NSDictionary
                    self.dataForTableView = items["sales_report"] as! [NSDictionary]
                    
                    if self.dataForTableView.count == 0  {
                        self.todaysReportTableView.isHidden = true
                        self.totalAmountView.isHidden = true
                        self.noRecordsLabel.isHidden = false
                    }else{
                        self.todaysReportTableView.isHidden = false
                        self.totalAmountView.isHidden = false
                        self.noRecordsLabel.isHidden = true
                    }
                    
                    self.todaysReportTableView.reloadData()
                    // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                } catch let parsingError {
                    print("Error", parsingError)
                }
                // let dataFromServer =
            }
        }
    }
    
}
