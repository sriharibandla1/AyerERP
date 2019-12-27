//
//  LoginViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/14/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
//http://lanciusit.com/demo/erpapi/api/purchaseList/1
let BaseUrl = "https://ayersfood.com/erpapi/api"
var USERID = String()
var USERTYPE = String()
var USEREMAIL = String()
var USERNAME = String()
class LoginViewController: UIViewController {

    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var forgotPasswordPopUpView: UIView!
    @IBOutlet weak var forgotPasswordEmailView: UIView!
    @IBOutlet weak var forgotPasswordEmailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transView.isHidden = true
        self.forgotPasswordPopUpView.isHidden = true
        self.userNameTF.text = "demo@ayers.com"
        self.passwordTF.text = "123456"
        self.Design()
         self.fontsAndColors()
    }
    
    // MARK: - colors And Fonts
    func fontsAndColors(){
   
      //  self.userNameTF.setSizeFont(font: "Helvetica Neue", sizeFont: 17.0)
      //  self.passwordTF.setSizeFont(font: "Helvetica Neue", sizeFont: 17.0)
        
    }
    
    func forLoging()
    {
        showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/signIn")!
        let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                    DispatchQueue.main.async {
                        self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    if response1?.statusCode == 200
                    {
                         do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                            let item = jsonRespone as! NSDictionary
                            USERID = item["user_id"] as! String
                            USERTYPE = item["user_type"] as! String
                            USERNAME = item["user_name"] as! String
                            USEREMAIL = item["user_email"] as! String
                            if USERTYPE == "3"
                            {
                            let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "CustomerHomeViewControllerId") as? CustomerHomeViewController
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
                            else
                            {let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
                            UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                    }
                    }
                        else if response1?.statusCode == 200
                        {
                        do{
                        let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                        print(jsonRespone)
                            } catch let parsingError {
                                                          print("Error", parsingError)
                            }
                        }
                        else
                         {
                        
                        }
                        }
                }
    }
    // MARK: - Design
    func Design()
    {
        self.userNameView.layer.borderWidth = 1
         self.userNameView.layer.borderColor = UIColor.customBlue
         self.userNameView.layer.cornerRadius = 8
        
        self.passwordview.layer.borderWidth = 1
        self.passwordview.layer.borderColor = UIColor.customBlue
        self.passwordview.layer.cornerRadius = 8
        
        self.forgotPasswordEmailView.layer.borderWidth = 1
        self.forgotPasswordEmailView.layer.borderColor = UIColor.customBlue
        self.forgotPasswordEmailView.layer.cornerRadius = 8
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func loginBtnAction(_ sender: UIButton) {
        let messageSuccess = Validation()
        if messageSuccess == "" {
            if CheckInternet.Connection(){
                forLoging()
            }else{
                Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
            }
        }
        else
        {
            Alert.showBasic(titte: "Alert", massage: messageSuccess, vc: self)
        }
        
    }
    @IBAction func forgotPasswordBtnAction(_ sender: UIButton) {
        
        self.transView.isHidden = false
        self.forgotPasswordPopUpView.isHidden = false
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewControllerId") as? SignUpViewController
//        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func popUpCloseBtnAction(_ sender: UIButton) {
        self.transView.isHidden = true
        self.forgotPasswordPopUpView.isHidden = true
    }
    
    @IBAction func forgotPasswordSubmitBtnAction(_ sender: UIButton) {
        self.transView.isHidden = true
        self.forgotPasswordPopUpView.isHidden = true
    }
    
   
    // MARK: - Network
    // MARK: - Validation
    func Validation() -> String {
           var successMessage = ""
        if userNameTF.text?.count == 0
               {
                   successMessage = "Please Enter User Name"
                   return successMessage
               }
        if passwordTF.text?.count == 0
        {
            successMessage = "Please Enter Password"
            return successMessage
        }
            return successMessage
    }
}
