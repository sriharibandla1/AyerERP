//
//  ProductWiseSalesReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class ProductWiseSalesReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var salesDateLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productModelLabel: UILabel!
    @IBOutlet weak var customerNameLAbel: UILabel!
    @IBOutlet weak var qntyLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
}

class ProductWiseSalesReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var productWiseSalesReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var norecordsLabel: UILabel!
    
    var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.productWiseSalesReportTableView.delegate = self
        self.productWiseSalesReportTableView.dataSource = self
        self.transView.isHidden = true
        self.productWiseSalesReportTableView.tableFooterView =  UIView(frame: .zero)
        
         getDataFromServer()
    }
    

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ProductWiseSalesReportTableViewCellId", for: indexPath) as! ProductWiseSalesReportTableViewCell
    
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        let item = self.dataForTableView[indexPath.row]
        
        cell.salesDateLabel.text = "Sales Date : \(item["sales_date"] ?? "")"
        cell.productNameLabel.text = "Product Name : \(item["product_name"] ?? "")"
        cell.productModelLabel.text = "Product Model : \(item["product_model"] ?? "")"
        cell.qntyLabel.text = "Rate : $\(item["rate"] ?? "")"
        cell.customerNameLAbel.text = "Customer Name : \(item["customer_name"] ?? "")"
        cell.totalAmountLabel.text = "Total Amount : $\(item["total_amount"] ?? "")"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
     // MARK: - Network
    func getDataFromServer()
    { self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/product_sales_reports_date_wise")!
        
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
                    self.dataForTableView = items["product_report"] as! [NSDictionary]
                    
                    if self.dataForTableView.count == 0  {
                        self.productWiseSalesReportTableView.isHidden = true
                        self.norecordsLabel.isHidden = false
                    }else{
                        self.productWiseSalesReportTableView.isHidden = false
                        self.norecordsLabel.isHidden = true
                    }
                    
                    self.productWiseSalesReportTableView.reloadData()
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
