//
//  ClosingReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ClosingReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var caseInLabel: UILabel!
    @IBOutlet weak var cashOutLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
}

class ClosingReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var closingReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var noRecordLabel: UILabel!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.closingReportTableView.delegate = self
        self.closingReportTableView.dataSource = self
        self.transView.isHidden = true
        self.closingReportTableView.tableFooterView =  UIView(frame: .zero)
        
        
        self.closingReportTableView.isHidden = true
        self.noRecordLabel.isHidden = false
       // getDataFromServer()
        
    }
    

  

    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return self.dataForTableView.count
         return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ClosingReportTableViewCellId", for: indexPath) as! ClosingReportTableViewCell
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
       //  let item = self.dataForTableView[indexPath.row]
        
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
        let url : URL = URL(string: BaseUrl + "/closingreport")!
        
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
                    self.dataForTableView = items[""] as! [NSDictionary]
                    
                    if self.dataForTableView.count == 0  {
                        self.closingReportTableView.isHidden = true
                        self.noRecordLabel.isHidden = false
                    }else{
                        self.closingReportTableView.isHidden = false
                        self.noRecordLabel.isHidden = true
                    }
                    
                    self.closingReportTableView.reloadData()
                    // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                } catch let parsingError {
                    print("Error", parsingError)
                }
                // let dataFromServer =
            }
        }
    }
    
}
