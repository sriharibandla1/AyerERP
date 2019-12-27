//
//  categoryWisePurchaseReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class categoryWisePurchaseReportTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var ModelLabel: UILabel!
    @IBOutlet weak var qntyLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
     @IBOutlet weak var dateLabel: UILabel!
    
}

class categoryWisePurchaseReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var categoryWisePurchaseReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var noRecordsLabel: UILabel!
    
    var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryWisePurchaseReportTableView.delegate = self
        self.categoryWisePurchaseReportTableView.dataSource = self
        self.transView.isHidden = true
        self.categoryWisePurchaseReportTableView.tableFooterView =  UIView(frame: .zero)
        
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "categoryWisePurchaseReportTableViewCellId", for: indexPath) as! categoryWisePurchaseReportTableViewCell
    
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        /*
 
         {
         "product_name": "SHREDDED COCONUT",
         "product_model": "ARTPL100",
         "quantity": "3100",
         "total_amount": "248000",
         "purchase_date": "2019-08-28",
         "category_name": "FROZEN"
         }
 */
    
        let item = self.dataForTableView[indexPath.row]
        
        cell.productNameLabel.text = "Product Name : \(item["product_name"] ?? "")"
            cell.categoryNameLabel.text = "Category Name : \(item["category_name"] ?? "")"
            cell.ModelLabel.text = "Model : \(item["product_model"] ?? "")"
            cell.qntyLabel.text = "Qnty : \(item["quantity"] ?? "")"
            cell.dateLabel.text = "Date : \(item["purchase_date"] ?? "")"
            cell.totalAmountLabel.text = "Amount : $\(item["total_amount"] ?? "")"
        
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

    
    // MARK: - Network
    
    func getDataFromServer()
    {
          self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/purchase_report_category_wise")!
       
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
                    self.dataForTableView = items["purchase_report_category_wise"] as! [NSDictionary]
                    
                    if self.dataForTableView.count == 0 {
                        self.categoryWisePurchaseReportTableView.isHidden = true
                        self.noRecordsLabel.isHidden = false
                    }else{
                        self.categoryWisePurchaseReportTableView.isHidden = false
                        self.noRecordsLabel.isHidden = true
                    }
                    
                    self.categoryWisePurchaseReportTableView.reloadData()
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
