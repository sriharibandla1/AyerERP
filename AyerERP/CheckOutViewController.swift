//
//  CheckOutViewController.swift
//  SupportFromERP
//
//  Created by Kardas Veeresham on 12/6/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CheckOutTableViewCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

class CheckOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var CheckOutTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CheckOutTableView.delegate = self
        self.CheckOutTableView.dataSource = self
        self.transView.isHidden = true
        self.setDataForTableView()
        self.CheckOutTableView.tableFooterView =  UIView(frame: .zero)
        toGetDataFromServer()
        getDataFromCD()
    }
    
    func setDataForTableView()
    {
        self.dataForTableView = getDataFromCoreData()
        self.CheckOutTableView.reloadData()
    }
    
    
    func getDataFromCD()
      {
          self.dataForTableView = getDataFromCoreData()
          print("\(self.dataForTableView)")
          var totalPrice : Float = 0.0
          var singleItem : Float = 0.0
          for item in self.dataForTableView
          {
              let priceOfItem = Float(item["total_price"] as! String)!
              let quantityOfItem = Float(item["product_quantity"] as! String)!
              singleItem = priceOfItem * quantityOfItem
              totalPrice = totalPrice + singleItem
          }
          let totalPriceString = String(totalPrice)
          self.subTotalLabel.text = "Sub Total : \(totalPriceString)"
          var forDeliveryCharges : Float = 0.0
          if totalPrice < 100
          {
              forDeliveryCharges = totalPrice / 10.0
              self.deliveryChargeLabel.text = "Delivery Charges : \(forDeliveryCharges)"
          }
          else
          {
            self.deliveryChargeLabel.text = "Delivery Charges : 0.0"
          }
          self.grandTotalLabel.text = "Grand Total : \(totalPrice + forDeliveryCharges)"
          
      }
    
    
    
    // MARK: - Tableview Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CheckOutTableViewCellId", for: indexPath) as! CheckOutTableViewCell
        
        let item = self.dataForTableView[indexPath.row]
        cell.productNameLabel.text = "\(item["product_name"] ?? "")"
        cell.quantityLabel.text = "\(item["product_quantity"] ?? "")"
        
        let quantityValue : Float = Float(item["product_quantity"] as! String)!
        let totalAmount : Float = Float(item["product_quantity"] as! String)!
        let finalVale : Float = quantityValue * totalAmount
        
        cell.priceLabel.text = "\(item["product_quantity"] ?? "")  * $\(item["product_rate"] ?? "") = \(finalVale)"
        
        
//        cell.productImage.imageFromServerURL(image: item["image"] as! String)
//        cell.priceOfItemLabel.text = "\(item["product_quantity"] ?? "")  * $\(item["product_rate"] ?? "")"
//        cell.unitLabel.text = "\(item["unit"] ?? "")"
//        cell.productQuantityLabel.text = "\(item["product_quantity"] ?? "")"
//
//        cell.cellView.layer.shadowColor = UIColor.lightGray
//        cell.cellView.layer.shadowOpacity = 1
//        cell.cellView.layer.masksToBounds = false
//        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
//        cell.cellView.layer.cornerRadius = 8
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

   
    @IBAction func placeOrderBtnAction(_ sender: UIButton) {
    
        var product_id = String()
               var available_quantity = String()
               var product_quantity = String()
               var product_rate = String()
               var discount = String()
               var total_price = String()
               var tax = String()
               var discount_amount = String()
        self.dataForTableView = getDataFromCoreData()
               print("\(dataForTableView)")
               var totalPrice : Float = 0.0
               
               for item in dataForTableView
               {
                   var singleItem : Float = 0.0
                   let priceOfItem = Float(item["total_price"] as! String)!
                   let quantityOfItem = Float(item["product_quantity"] as! String)!
                   singleItem = priceOfItem * quantityOfItem
                   totalPrice = totalPrice + singleItem
                   if product_id.count == 0 {
                       product_id = item["product_id"] as! String
                       available_quantity = item["available_quantity"] as! String
                       product_quantity = item["product_quantity"] as! String
                       product_rate = item["product_rate"] as! String
                       discount = "0"
                       total_price = "\(singleItem)"
                       tax = "0"
                       discount_amount = "0"
                    }
                   else
                   {
                       product_id = product_id + ","  + (item["product_id"] as! String)
                                      available_quantity = available_quantity + ","  + (item["available_quantity"] as! String)
                                      product_quantity = product_quantity + ","  + (item["product_quantity"] as! String)
                                      product_rate = product_rate + ","  + (item["product_rate"] as! String)
                                      discount = discount + "," + "0"
                                      total_price = total_price + "," + "\(singleItem)"
                                      tax = tax + ","  + "0"
                                      discount_amount = discount_amount + "," + "0"
                   }
               }
               var forDeliveryCharges : Float = 0.0
               if totalPrice < 100
               {
                   forDeliveryCharges = totalPrice / 10.0
                   //self.deliveryChargesLabel.text = "Delivery Charges : \(forDeliveryCharges)"
               }
               else
               {
                   forDeliveryCharges = 0.0
                // self.deliveryChargesLabel.text = "Delivery Charges : 0.0"
               }
               self.grandTotalLabel.text = "Grand Total : \(totalPrice + forDeliveryCharges)"
               let url : URL = URL(string: BaseUrl + "/checkout")!
               let headerData = ["product_id":product_id,"available_quantity":available_quantity,"product_quantity":product_quantity,"product_rate":product_rate,"discount":discount,"total_price":total_price,"tax":tax,"discount_amount":discount_amount,"total_tax":"0","invoice_discount":"0","total_discount":"0","shipping_cost":"\(forDeliveryCharges)","grand_total_price":"\(totalPrice)","previous":"","n_total":"\(totalPrice + forDeliveryCharges)","paid_amount":"0","due_amount":"0","user_type":USERTYPE,"customer_id":USERID,"invoice_date":""]
                       AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                           if response1?.statusCode == 200
                           {
                                do{
                                   let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                   print(jsonRespone)
                                   let item = jsonRespone as! NSDictionary
                                   
                                       let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SuccessViewControllerId") as? SuccessViewController
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                   
                                   
                                   } catch let parsingError {
                                      print("Error", parsingError)
                                 }
                              // let dataFromServer =
                           }
                           
                       }
        
        
        
        
        
        
    }
    func toGetDataFromServer()
         {
             let url : URL = URL(string:BaseUrl + "/customerdetail")!
              //"/invoiceList/" + "\(USERTYPE)/" + "\(USERID)")!
                     
          let parameter = ["customer_id" : USERID]
                     AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                         print(response.request as Any)  // original URL request
                         print(response.response as Any)// URL response
                         let response1 = response.response
                         if response1?.statusCode == 200
                         {
                              do{
                                 let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                 print(jsonRespone)
                                  /*                                    "company_info": [
                                         {
                                             "company_id": "1",
                                             "company_name": "Ayers Rock Trading ",
                                             "email": "sales@ayersrocktrading.com.au",
                                             "address": "Block C, Unit 4-5 102 Station Road, Seven Hills, 2147, NSW Australia",
                                             "mobile": "(61) 296362091",
                                             "website": "https://ayersrocktrading.com.au/",
                                             "status": "1"
                                         }
                                     ],
                                     "currency": "$",
                                     "position": "0"*/
                                 // self.jsonDic = jsonRespone
                                  let companyDetailsArray = jsonRespone["company_info"] as! [NSDictionary]
                                  let companyDetails = companyDetailsArray[0]
                                  
                                  
                               
                                  
                                 } catch let parsingError {
                                    print("Error", parsingError)
                               }
                         }
                     }
         }
      
}
