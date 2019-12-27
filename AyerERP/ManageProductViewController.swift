//
//  ManageProductViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activeImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryIdLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var grossPriceLabel: UILabel!
    @IBOutlet weak var onHandLabel: UILabel!
    @IBOutlet weak var updateButtonView: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var activeButtonView: UIView!
    @IBOutlet weak var activeButton: UIButton!
    
}

class ManageProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageProductTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageProductTableView.delegate = self
        self.manageProductTableView.dataSource = self
        self.transView.isHidden = true
        self.manageProductTableView.tableFooterView =  UIView(frame: .zero)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
        self.getDataForManageCustomer()
        }else{
            Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageProductTableViewCellId", for: indexPath) as! ManageProductTableViewCell
        
        let item = self.dataForTableView[indexPath.row]
        let product_status =  item["status"] as! String
               if product_status == "0"
               {
                cell.activeImage.image = UIImage(named: "close")
                cell.activeButtonView.backgroundColor = UIColor.red
               }
               else
               {
                cell.activeImage.image = UIImage(named: "active")
                cell.activeButtonView.backgroundColor = UIColor(red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
               }
         cell.activeButton.tag = indexPath.row
        cell.brandLabel.text = "Brand : \(item["supplier_name"] ?? "")"
        cell.nameLabel.text = "Name : \(item["product_name"] ?? "")"
        cell.sizeLabel.text = "Size : \(item["unit"] ?? "")"
        cell.categoryIdLabel.text = "Category Id : \(item["category_id"] ?? "")"
        cell.grossPriceLabel.text = "Gross Price : $\(item["price"] ?? "")"
        cell.onHandLabel.text = "On Hand : \(item["actual_qty"] ?? "")"
        print("\(item["actual_qty"] ?? "")")
        cell.updateButtonView.layer.cornerRadius = 4
        cell.deleteButtonView.layer.cornerRadius = 4
        cell.activeButtonView.layer.cornerRadius = 4
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
         cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func forNextItems(pageNumber : String)
    {
        ///W15LDBOFCPYPMQ8
    let url : URL = URL(string: BaseUrl + "/productList/1/" + pageNumber)!
    // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
             AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
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
                         self.dataForTableView = items["all_product_list"] as! [NSDictionary]
                                                 self.manageProductTableView.reloadData()
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
       //  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func activeBtnAction(_ sender: UIButton) {
        self.toActiveOrInActiveTheProduct(item: self.dataForTableView[sender.tag])
    }
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    //MARK:- Network
    func getDataForManageCustomer()
       {
        ///W15LDBOFCPYPMQ8
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let url : URL = URL(string: BaseUrl + "/productList/" + "\(USERTYPE)" + "/0" + "/0")! 
          // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                   AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
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
                               self.dataForTableView = items["all_product_list"] as! [NSDictionary]
                              
                               
                               self.manageProductTableView.reloadData()
                              // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
                       }
                   }
        }
       }
    func toActiveOrInActiveTheProduct(item: NSDictionary)
    {
     ///W15LDBOFCPYPMQ8
        
       
        let productId =  item["product_id"] as! String
        var product_status =  item["status"] as! String
        if product_status == "0"
        {
           product_status = "1"
        }
        else
        {
            product_status = "0"
        }
     self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/productActive")!
        let headerData = ["user_type":USERTYPE ,"productId": productId , "product_status" : product_status]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                 DispatchQueue.main.async {
                 self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                    if response1?.statusCode == 200
                    {
                        self.getDataForManageCustomer()
                       // let dataFromServer =
                    }
                }
     }
    }
    /* http://ayersfood.com/erpapi/api/productActiveparams:{
    "user_type":"1",
    "productId":"748598",
    "product_status":"0"
    }*/
}
