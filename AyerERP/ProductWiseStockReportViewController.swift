//
//  ProductWiseStockReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ProductWiseStockReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productModellabel: UILabel!
    @IBOutlet weak var inQntyLabel: UILabel!
    @IBOutlet weak var outQntyLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockSalesPriceLabel: UILabel!
}

class ProductWiseStockReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var productWiseStockReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var TotalAmountView: UIView!
    @IBOutlet weak var totalInQntyLabel: UILabel!
    @IBOutlet weak var totalOutQntyLabel: UILabel!
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var totalStockSalePriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.productWiseStockReportTableView.delegate = self
        self.productWiseStockReportTableView.dataSource = self
        self.transView.isHidden = true
        self.productWiseStockReportTableView.tableFooterView =  UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.getDataForManageCustomer()
        if CheckInternet.Connection(){
                               self.getDataForManageCustomer()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
    }
    
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ProductWiseStockReportTableViewCellId", for: indexPath) as! ProductWiseStockReportTableViewCell
        /*{
        "title": "Stock Report (Supplier Wise)",
        "stok_report": "0",
        "product_model": "0",
        "record_count": "0",
        "date": "0",
        "sub_total_in": "0.00",
        "sub_total_out": "0.00",
        "sub_total_stock": "0.00",
        "supplier_list": [
            {
                "id": "5",
                "supplier_id": "ZVNVTAH4THQN7HGEL5OL",
                "supplier_name": "DABUR",
                "address": "DABUR\r\n",
                "mobile": "78",
                "details": "DABUR\r\n",
                "status": "1"
            }*/
        /*productNameLabel: UILabel!
        @IBOutlet weak var productModellabel: UILabel!
        @IBOutlet weak var inQntyLabel: UILabel!
        @IBOutlet weak var outQntyLabel: UILabel!
        @IBOutlet weak var stockLabel: UILabel!
        @IBOutlet weak var stockSalesPriceLabel: UILabel!*/
        /*{
            "product_name": "CHYAWANPRASH MANGO",
            "product_id": "5000154",
            "price": "133.92",
            "product_model": "AYER-804",
            "totalSalesQnty": "0",
            "totalPurchaseQnty": "2000",
            "date": "2019-09-25",
            "sl": 43,
            "stok_quantity_cartoon": 2000,
            "SubTotalOut": 109,
            "SubTotalIn": 71154,
            "SubTotalStock": 71045,
            "SubTotalinQnty": 71154,
            "total_sale_price": 267840,
            "SubTotaloutQnty": 109
        }*/
        let item = self.dataForTableView[indexPath.row]
          cell.productNameLabel.text = "Product Name : \(item["product_name"] ?? "")"
          cell.productModellabel.text = "Product Model : \(item["product_model"] ?? "")"
              //cell..text = "Unit : \(item["unit"] ?? "")"
          cell.inQntyLabel.text = "In Qnty : \(item["SubTotalIn"] ?? "")"
          cell.stockLabel.text = "Stock : \(item["stok_quantity_cartoon"] ?? "")"
        //  cell.salePriceLabel.text = "Sale Price : \(item["sales_price"] ?? "")"
          cell.outQntyLabel.text = "Out Qnty : \(item["SubTotalOut"] ?? "")"
          cell.stockSalesPriceLabel.text = "Stock Sales Price: $  \(item["total_sale_price"] ?? "")"
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
    //MARK: - NETWORK
    func getDataForManageCustomer()
    {
     
        /*{
        "customer_id":"1",
        "dtpFromDate":"2019-09-04",
        "dtpToDate":"2019-06-04",
        "search":"1"
        }*/
          self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/stockreportproductwise")!
        let headerData = ["customer_id":USERID,"dtpFromDate":"", "dtpToDate":"","search":"1"]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    DispatchQueue.main.async {
                                      self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                    if response1?.statusCode == 200
                    {
                         do{
                             //categoryName
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                            self.dataForTableView = items["stok_report"] as! [NSDictionary]
                           
                            
                            self.productWiseStockReportTableView.reloadData()
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
