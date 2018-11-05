//
//  PaymentViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/30/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import InstaMojoiOS

class PaymentViewCntr: UIViewController {
    var businessId = String()
    var transactionID: String!
    var accessToken: String!
    
    /*func fetchOrder(orderID: String, accessToken: String){
        //show spinner
        let request = Request.init(orderID: orderID, accessToken: accessToken,  orderRequestCallBack: self)
        request.execute()
    }
    
    //protocol function
    func onFinish(order: Order, error: String) {
        if !error.isEmpty {
            DispatchQueue.main.async {
                //hide spinner
                //show the error message
            }
        } else {
            DispatchQueue.main.async {
                //hide spinner
                Instamojo.invokePaymentOptionsView(order : order)
            }
        }
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()
       /*addNotificationToRecievePaymentCompletion()
       Instamojo.setBaseUrl(url: "https://api.instamojo.com/")
        Instamojo.enableLog(option: true)
        fetchOrder()*/
        
        
        
        IMConfiguration.sharedInstance.setupOrder(purpose: "buying", buyerName: "Javed", emailId: "javed@beeonline.co.in", mobile: "8652309010", amount: "20", environment: .Production, on: self) { (success, message) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                print("message----",success)
                print("message----",message)
                if success {
                    print("message----",message)

                } else {
                     print("message----",message)
                   
                }
            })
        }
        
    }
    
   /* func fetchOrder() {
        
        let url: String = ServerUrl.accessTokenIos
        //let url: String = "https://sample-sdk-server.instamojo.com/create"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let session = URLSession.shared
        let params = ["env": "production"]
        request.setBodyContent(parameters: params)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, _, error -> Void in
            DispatchQueue.main.async {
                //
            }
            if error == nil {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String:Any] {
                        Logger.logDebug(tag: "Dictonary", message: String(describing: jsonResponse))
                        if jsonResponse["error"] != nil {
                            if let errorMessage = jsonResponse["error"] as? String {
                                Logger.logError(tag: " Sample - Fetch Token", message: errorMessage)
                                // Show an alert with the error message recieved from the server
                                self.showAlert(errorMessage: errorMessage)
                            }
                        } else {
                            
                            Logger.logDebug(tag: " Sample - Fetch Token", message: "Response: \(jsonResponse)")
                            
                            let transactionID = jsonResponse["transaction_id"] as? String
                            let accessToken = jsonResponse["access_token"] as? String
                            
                            //Create an order using the transaction_id and access_token recieved
                            self.createOrder(transactionID: transactionID!, accessToken: accessToken!)
                        }
                    }
                } catch {
                    
                    Logger.logError(tag: " Sample - Fetch Token", message: String(describing: error))
                    self.showAlert(errorMessage: "Failed to fetch order tokens")
                }
            } else {
                
                print(error!.localizedDescription)
                self.showAlert(errorMessage: "Failed to fetch order tokens")
            }
        })
        task.resume()
    }
    
    func createOrder(transactionID: String, accessToken: String) {
        self.transactionID = transactionID
        self.accessToken = accessToken
        let order = self.formAnOrder(transactionID: transactionID, accessToken: accessToken)
        DispatchQueue.main.async {
           
           /* self.invalidName(show: !order.isValidName().validity, error: order.isValidName().error)
            self.invalidEmail(show: !order.isValidEmail().validity, error: order.isValidEmail().error)
            self.invalidAmount(show: !order.isValidAmount().validity, error: order.isValidAmount().error)
            self.invalidPhoneNumber(show: !order.isValidPhone().validity, error: order.isValidPhone().error)
            self.invalidDescription(show: !order.isValidDescription().validity, error: order.isValidDescription().error)*/
            if !order.isValidWebhook().validity && !order.isValidTransactionID().validity {
                self.showAlert(errorMessage: order.isValidWebhook().error + order.isValidTransactionID().error)
            }
        }
        
        if order.isValid().validity {
            DispatchQueue.main.async {
               // self.spinner.show()
            }
            let request = Request.init(order: order, orderRequestCallBack: self)
            request.execute()
        }
    }
    func formAnOrder(transactionID: String, accessToken: String) -> Order {
        
       
        let buyerName = "Shardul"
        let buyerEmail = "tester@gmail.com"
        let buyerPhone = "7875432991"
        let amount = "10"
        let description = "abcdeeedd"
        let webHook = "http://nirjaraapp.com/cpanel/webhook/"
        
        let order: Order =  Order.init(authToken : accessToken, transactionID : transactionID, buyerName : buyerName, buyerEmail : buyerEmail, buyerPhone : buyerPhone, amount : amount, description : description, webhook : webHook)
        
        return order
    }
    
    
    func showAlert(errorMessage: String) {
        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNotificationToRecievePaymentCompletion(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.paymentCompletionCallBack), name: NSNotification.Name("INSTAMOJO"), object: nil)
    }
    
    @objc func paymentCompletionCallBack() {
        if UserDefaults.standard.value(forKey: "USER-CANCELLED") != nil {
            self.showAlert(errorMessage: "Transaction cancelled by user, back button was pressed.")
        }
        
        if UserDefaults.standard.value(forKey: "ON-REDIRECT-URL") != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.checkPaymentStatus()
            }
        }
        
        if UserDefaults.standard.value(forKey: "USER-CANCELLED-ON-VERIFY") != nil {
            self.showAlert(errorMessage: "Transaction cancelled by user when trying to verify payment")
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.checkPaymentStatus()
            }
        }
    }
    func checkPaymentStatus() {
       // spinner.show()
        if accessToken == nil {
            return
        }
        let env = "production"
        let params = ["env": env, "transaction_id": self.transactionID]
        let parameterArray = params.map { (key, value) -> String in
            return "\(key)=\((value as AnyObject))"
        }
        let values = parameterArray.joined(separator: "&")
        Logger.logDebug(tag: "Params", message: values)
        let url: String = "https://sample-sdk-server.instamojo.com/status?" + values
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            Logger.logDebug(tag: "Payment Status", message: String(describing: response))
            DispatchQueue.main.async {
               // self.spinner.hide()
            }
            if error == nil {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String:Any] {
                        Logger.logDebug(tag: "Response JSON", message: String(describing: jsonResponse))
                        let amount = jsonResponse["amount"] as? String
                        let payments = jsonResponse["payments"] as? [[String :Any]]
                        let status = jsonResponse["status"] as? String
                        if status == "completed"{
                            let id = payments?[0]["id"] as? String
                            self.showAlert(errorMessage: "Transaction Successful for id - " + id! + ". Refund will be initated")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               // self.refundTheAmount(amount: amount!, transctionID: self.transactionID)
                            }
                        } else {
                            self.showAlert(errorMessage: "Transaction pending")
                        }
                    }
                } catch {
                    Logger.logError(tag: "Caught Exception", message: String(describing: error))
                }
            } else {
                print(error!.localizedDescription)
            }
        })
        task.resume()
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
