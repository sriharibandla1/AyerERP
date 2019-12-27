//
//  ManageMessagesViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/24/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageMessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

class ManageMessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageMessageTableView: UITableView!
    
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

        self.manageMessageTableView.delegate = self
        self.manageMessageTableView.dataSource = self
        self.transView.isHidden = true
        self.manageMessageTableView.tableFooterView =  UIView(frame: .zero)
        desien()
        getNotification()
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.getDataForManageCustomer()
        if CheckInternet.Connection(){
                               self.getDataForManageCustomer()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageMessagesTableViewCellId", for: indexPath) as! ManageMessagesTableViewCell
        
        /*{
            id = 3;
            "message_date" = "2019-10-23 13:35:02";
            "message_detail" = "FCG2D9IJ1GVOU6X Request For Update Profile";
            "message_read" = 0;
            "message_subject" = "Request For Update Profile";
            receiver = 1;
            sender = "Customer ( FCG2D9IJ1GVOU6X)";
            status = 0;
            "user_type" = 1;
        }*/
        let item = self.dataForTableView[indexPath.row]
        cell.messageLabel.text = "Message : \(item["message_detail"] ?? "")"
        cell.subjectLabel.text = "Subject : \(item["message_subject"] ?? "")"
        cell.userLabel.text = "User : \(item["sender"] ?? "")"
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
       
       
       @IBAction func outOfStockBtnAction(_ sender: UIButton) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OutOfStockViewControllerId") as? OutOfStockViewController
                  
                  self.navigationController?.pushViewController(vc!, animated: true)
       }
    
    
    @IBAction func recentInvoiceBtnAction(_ sender: UIButton) {
       
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    /*http://lanciusit.com/demo/erpapi/api/managemessage
    {
        "customer_id":"1",
        "user_type":"1"
    }*/
    //MARK:- Network
    func getDataForManageCustomer()
       {
           let url : URL = URL(string: "https://ayersfood.com/erpapi/api/managemessage")!
           let headerData = ["customer_id":USERID,"user_type":USERTYPE]
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
                               self.dataForTableView = items["message_list"] as! [NSDictionary]
                              
                               
                               self.manageMessageTableView.reloadData()
                              // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
                       }
                   }
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
