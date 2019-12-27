//
//  OutOfStockViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/24/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class OutOfStockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productModelLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
}

class OutOfStockViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var outofStockTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    
    @IBOutlet weak var manageApplicationBadgeView: UIView!
       @IBOutlet weak var outOfStockBadgeView: UIView!
       @IBOutlet weak var messageBadgeView: UIView!
       @IBOutlet weak var updateApplicationBadgeView: UIView!
       @IBOutlet weak var recentInvoiceBadgeView: UIView!
    
    @IBOutlet weak var recentInvoiceBadgeLabel: UILabel!
    @IBOutlet weak var newApplicatonBadgeLabel: UILabel!
    @IBOutlet weak var updateApplicationBadgeLabel: UILabel!
    @IBOutlet weak var messageBadgeLabel: UILabel!
    @IBOutlet weak var outOfStockBadgeLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.outofStockTableView.delegate = self
        self.outofStockTableView.dataSource = self
        self.transView.isHidden = true
        self.outofStockTableView.tableFooterView =  UIView(frame: .zero)
        self.getDataForRoleList()
        desien()
        getNotification()
    }
    

    func desien(){
           self.manageApplicationBadgeView.layer.cornerRadius = self.manageApplicationBadgeView.frame.size.height / 2
           self.manageApplicationBadgeView.clipsToBounds = true
           self.updateApplicationBadgeView.layer.cornerRadius = self.updateApplicationBadgeView.frame.size.height / 2
           self.updateApplicationBadgeView.clipsToBounds = true
           self.messageBadgeView.layer.cornerRadius = self.messageBadgeView.frame.size.height / 2
           self.messageBadgeView.clipsToBounds = true
           self.outOfStockBadgeView.layer.cornerRadius = self.outOfStockBadgeView.frame.size.height / 2
           self.outOfStockBadgeView.clipsToBounds = true
        self.recentInvoiceBadgeView.layer.cornerRadius = self.recentInvoiceBadgeView.frame.size.height / 2
        self.recentInvoiceBadgeView.clipsToBounds = true
    
    }
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "OutOfStockTableViewCellId", for: indexPath) as! OutOfStockTableViewCell
        
        /* {
                   "product_id": "5000306",
                   "category_id": "8OECKV36QMDD1MD",
                   "product_name": "DHOOP RESIN",
                   "price": "29",
                   "unit": "",
                   "tax": "0",
                   "serial_no": "",
                   "product_model": "AYER-956",
                   "product_details": "DHOOP RESIN",
                   "image": "http://lanciusitsolutions.com/ayerserp/my-assets/image/product.png",
                   "status": "1",
                   "productNew": "0",
                   "number_of_pieces": "1",
                   "price_per_pieces": "29.00",
                   "stock": "0",
                   "sl": 1
               }*/
        let item = self.dataForTableView[indexPath.row]
        cell.unitLabel.text = "\(item["unit"] ?? "")"
        cell.productNameLabel.text = "\(item["product_name"] ?? "")"
        cell.productModelLabel.text = "\(item["product_model"] ?? "")"
        cell.stockLabel.text = "\(item["stock"] ?? "")"
 
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func getDataForRoleList()
              {
                  let url : URL = URL(string: "https://ayersfood.com/erpapi/api/out_of_stock")!
                  let headerData = ["customer_id":USERID]
                          AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                              print(response.request as Any)  // original URL request
                              print(response.response as Any)// URL response
                              let response1 = response.response
                              if response1?.statusCode == 200
                              {
                                   do{
                                       //categoryName
                                      let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                      print(jsonRespone)
                                       var items = NSDictionary()
                                      items = jsonRespone as! NSDictionary
                                      self.dataForTableView = items["out_of_stock"] as! [NSDictionary]
                                     
                                      
                                      self.outofStockTableView.reloadData()
                                     // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                                      } catch let parsingError {
                                         print("Error", parsingError)
                                    }
                                 // let dataFromServer =
                              }
                          }
              }
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func newApplicationBtnAction(_ sender: UIButton) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageNewApplicationViewControllerId") as? ManageNewApplicationViewController
                  
       self.navigationController?.pushViewController(vc!, animated: true)
       }
       @IBAction func updateApplicationBtnAction(_ sender: UIButton) {
              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerUpdateApplicantsViewControllerId") as? ManageCustomerUpdateApplicantsViewController
                     
              self.navigationController?.pushViewController(vc!, animated: true)
          }
          
          @IBAction func homeBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
                            
            self.navigationController?.pushViewController(vc!, animated: true)
          }
          
          @IBAction func messageBtnAction(_ sender: UIButton) {
              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageMessagesViewControllerId") as? ManageMessagesViewController
                     
                     self.navigationController?.pushViewController(vc!, animated: true)
          }
          
    @IBAction func recentInvoiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    func getNotification()
           {
            self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
               let url : URL = URL(string:BaseUrl + "/notification")!
                       
                       
                       AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                        DispatchQueue.main.async {
                                               self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                           if response1?.statusCode == 200
                           {
                               /*
                                   "title": "notification",
                                   "out_of_stock": 3,
                                   "balance": "$ 317.5",
                                   "message": 10,
                                   "incompleteUser": 0,
                                   "invoice": 12,
                                   "newApplicant": 0
                               }*/
                               do{
                               let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                               self.newApplicatonBadgeLabel.text = "\(jsonRespone["newApplicant"] ?? "")"
                                   self.updateApplicationBadgeLabel.text = "\(jsonRespone["incompleteUser"] ?? "")"
                                   self.messageBadgeLabel.text = "\(jsonRespone["message"] ?? "")"
                                   self.outOfStockBadgeLabel.text = "\(jsonRespone["out_of_stock"] ?? "")"
                                   self.recentInvoiceBadgeLabel.text = "\(jsonRespone["invoice"] ?? "")"
                               }
                               catch
                               {
                                   
                               }
                           }
                           
                           }
               }
       }
    
}
