//
//  TodaysCustomerReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
 import Alamofire
class TodaysCustomerReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
}

class TodaysCustomerReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var todaysCustomerReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var norecordsLabel: UILabel!
     var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.todaysCustomerReportTableView.delegate = self
        self.todaysCustomerReportTableView.dataSource = self
        self.transView.isHidden = true
        self.todaysCustomerReportTableView.tableFooterView =  UIView(frame: .zero)
        
        
         getDataFromServer()
    }
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
                               self.getDataFromServer()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
    }

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "TodaysCustomerReportTableViewCellId", for: indexPath) as! TodaysCustomerReportTableViewCell
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        let item = self.dataForTableView[indexPath.row]
        cell.customerNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
        cell.receiptLabel.text = "Receipt : $\(item["total_amount"] ?? "")"
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


    // MARK: - Network
    
    func getDataFromServer()
    {
        let url : URL = URL(string: BaseUrl + "/todays_customer_receipt")!
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
            print(response.request as Any)  // original URL request
            print(response.response as Any)// URL response
            let response1 = response.response
            DispatchQueue.main.async {
            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
            if response1?.statusCode == 200
            {
                do{
                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    print(jsonRespone)
                    var items = NSDictionary()
                    items = jsonRespone as! NSDictionary
                    self.dataForTableView = items["todays_customer_receipt"] as! [NSDictionary]
                    
                    if self.dataForTableView.count == 0  {
                        self.todaysCustomerReportTableView.isHidden = true
                        self.norecordsLabel.isHidden = false
                    }else{
                        self.todaysCustomerReportTableView.isHidden = false
                        self.norecordsLabel.isHidden = true
                    }
                    
                    self.todaysCustomerReportTableView.reloadData()
                    // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                } catch let parsingError {
                    print("Error", parsingError)
                }
                // let dataFromServer =
            }
        }
        }
    }
    
    
    
    
}
