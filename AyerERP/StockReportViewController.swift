//
//  StockReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class StockReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productModellabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var inQntyLabel: UILabel!
    @IBOutlet weak var outQntyLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockSalesPriceLabel: UILabel!
}

class StockReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var dataForTableView = [NSDictionary]()
    @IBOutlet weak var stockReportTableView: UITableView!
    @IBOutlet weak var transview: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var TotalAmountView: UIView!
    @IBOutlet weak var totalInQntyLabel: UILabel!
    @IBOutlet weak var totalOutQntyLabel: UILabel!
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var totalStockSalePriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.stockReportTableView.delegate = self
        self.stockReportTableView.dataSource = self
        self.transview.isHidden = true
        self.stockReportTableView.tableFooterView =  UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.getDataForManageCustomer()
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "StockReportTableViewCellId", for: indexPath) as! StockReportTableViewCell
        /* {
                   SubTotalIn = 495931;
                   SubTotalOut = 1242;
                   SubTotalStock = 494689;
                   "category_id" = W15LDBOFCPYPMQ8;
                   image = "http://lanciusitsolutions.com/ayerserp/my-assets/image/product/9f71c13d1c7aa37ef406f7ff6b85f6b4.jpg";
                   "number_of_pieces" = 20;
                   price = 46;
                   "price_per_pieces" = "2.30";
                   productNew = 0;
                   "product_details" = "SHREDDED COCONUT";
                   "product_id" = 1020;
                   "product_model" = ARTPL100;
                   "product_name" = "SHREDDED COCONUT";
                   "sales_price" = 46;
                   "serial_no" = 1001;
                   sl = 435;
                   status = 1;
                   "stok_quantity_cartoon" = 3051;
                   tax = 0;
                   totalPurchaseQnty = 3100;
                   totalSalesQnty = 49;
                   "total_sale_price" = 140346;
                   unit = "400gm x 20";
               }
           );
           "sub_total_in" = "495,931.00";
           "sub_total_out" = "1,242.00";
           "sub_total_stock" = "494,689.00";
           title = "Stock Report";*/
        let item = self.dataForTableView[indexPath.row]
        cell.productNameLabel.text = "Product Name : \(item["product_name"] ?? "")"
        cell.productModellabel.text = "Product Model : \(item["product_model"] ?? "")"
        cell.unitLabel.text = "Unit : \(item["unit"] ?? "")"
        cell.inQntyLabel.text = "In Qnty : \(item["SubTotalIn"] ?? "")"
        cell.stockLabel.text = "Stock : \(item["stok_quantity_cartoon"] ?? "")"
        cell.salePriceLabel.text = "Sale Price : \(item["sales_price"] ?? "")"
        cell.outQntyLabel.text = "Out Qnty : \(item["SubTotalOut"] ?? "")"
        cell.stockSalesPriceLabel.text = "Stock Sales Price: \(item["total_sale_price"] ?? "")"
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

//stockreportproductwise
    // MARK: - NETWORK
    func getDataForManageCustomer()
    {
     
        /*{
        "customer_id":"1",
        "dtpFromDate":"2019-09-04",
        "dtpToDate":"2019-06-04",
        "search":"1"
        }*/
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transview)
        let url : URL = URL(string: BaseUrl + "/stockreport")!
        //let headerData = ["customer_id":USERID,"dtpFromDate":"", "dtpToDate":"","search":"1"]
                AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    DispatchQueue.main.async {
                                       self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transview)
                    if response1?.statusCode == 200
                    {
                         do{
                             //categoryName
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                           self.dataForTableView = items["stok_report"] as! [NSDictionary]
                            //"sub_total_in" = "495,931.00";
                            //"sub_total_out" = "1,242.00";
                            //"sub_total_stock" = "494,689.00";
                            self.dateLabel.text = "Date :\(items["date"] ?? "")"
                            self.totalStockLabel.text = "Total Stock : \(items["sub_total_stock"] ?? "")"
                            self.totalInQntyLabel.text = "Total In Stock : \(items["sub_total_in"] ?? "")"
                            self.totalOutQntyLabel.text = "Total Out Stock : \(items["sub_total_out"] ?? "")"
                            self.totalStockSalePriceLabel.text = "Stock Sales Price :\(items["sub_total_stock"] ?? "") "
                            self.stockReportTableView.reloadData()
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
