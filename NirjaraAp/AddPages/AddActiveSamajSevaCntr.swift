//
//  AddActiveSamajSevaCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import IQKeyboardManagerSwift
class AddActiveSamajSevaCntr: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var txtContactNo: UITextField!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var btnDate: UIButton!
    
    @IBOutlet weak var lblTimeFrom: UILabel!
  
    @IBOutlet weak var txtTimeFrom: UIDatePicker!
    
    @IBOutlet weak var lblTimeTo: UILabel!
    
    @IBOutlet weak var txtTimeTo: UIDatePicker!
    
    @IBOutlet weak var lblKm: UILabel!
    @IBOutlet weak var txtKm: UITextField!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var mainView: UIView!
      var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Active for Samaj Seva"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:13))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:13,length:10))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        self.updateBackButton()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        containerController = revealViewController().frontViewController as? ContainerViewController
        lblName.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        txtName.frame = CGRect(x:10,y:lblName.frame.origin.y+lblName.frame.height,width:self.view.frame.width-20,height:45)
        txtName.text = UserDefaults.standard.getMemberName()
        
        lblContactNo.frame = CGRect(x:10,y:txtName.frame.origin.y+txtName.frame.height+10,width:self.view.frame.width-20,height:25)
        txtContactNo.frame = CGRect(x:10,y:lblContactNo.frame.origin.y+lblContactNo.frame.height,width:self.view.frame.width-20,height:45)
        
       // txtContactNo.text = UserDefaults.standard
        
        lblDate.frame = CGRect(x:10,y:txtContactNo.frame.origin.y+txtContactNo.frame.height+10,width:self.view.frame.width-20,height:25)
        btnDate.frame = CGRect(x:10,y:lblDate.frame.origin.y+lblDate.frame.height,width:self.view.frame.width-20,height:45)
       
        lblTimeFrom.frame = CGRect(x:10,y:btnDate.frame.origin.y+btnDate.frame.height+10,width:self.view.frame.width-20,height:25)
        txtTimeFrom.frame = CGRect(x:10,y:lblTimeFrom.frame.origin.y+lblTimeFrom.frame.height,width:self.view.frame.width-20,height:45)
        
        
        lblTimeTo.frame = CGRect(x:10,y:txtTimeFrom.frame.origin.y+txtTimeFrom.frame.height+10,width:self.view.frame.width-20,height:25)
        txtTimeTo.frame = CGRect(x:10,y:lblTimeTo.frame.origin.y+lblTimeTo.frame.height,width:self.view.frame.width-20,height:45)
       
       
        lblKm.frame = CGRect(x:10,y:txtTimeTo.frame.origin.y+txtTimeTo.frame.height+10,width:self.view.frame.width-20,height:25)
        txtKm.frame = CGRect(x:10,y:lblKm.frame.origin.y+lblKm.frame.height,width:self.view.frame.width-20,height:45)
        
        
        lblLocation.frame = CGRect(x:10,y:txtKm.frame.origin.y+txtKm.frame.height+10,width:self.view.frame.width-20,height:25)
        txtLocation.frame = CGRect(x:10,y:lblLocation.frame.origin.y+lblLocation.frame.height,width:self.view.frame.width-20,height:45)

        
        btnSubmit.frame = CGRect(x:10,y:txtLocation.frame.origin.y+txtLocation.frame.height+18,width:self.view.frame.width-20,height:50)

        
        self.txtTimeFrom.datePickerMode = .time
        self.txtTimeTo.datePickerMode = .time
        
        
        
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
 
        let startHour: Int = dateTimeComponents.hour!
        let endHour: Int = 23
        let date1: NSDate = NSDate()
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!

        
        let components: NSDateComponents = gregorian.components(([.day, .month, .year]), from: date1 as Date) as NSDateComponents
        components.hour = startHour
        components.minute = dateTimeComponents.minute!
        components.second = 0
        let startDate: NSDate = gregorian.date(from: components as DateComponents)! as NSDate

       // self.txtTimeTo.minimumDate = startDate as Date
       
        
        lblName.text = "Add".localized1+" "+"Name".localized1
        lblContactNo.text = "ContactNumber".localized1
        lblKm.text = "Enterkilometre".localized1
        lblDate.text = "Date".localized1
        lblTimeTo.text = "TimeTo".localized1
        lblTimeFrom.text = "Timefrom".localized1
        lblLocation.text = "Add".localized1+" "+"Address".localized1
        
        if(UserDefaults.standard.getMobileNumber() == nil || UserDefaults.standard.getMobileNumber() == "null"){
            
        }else{
            txtContactNo.text = UserDefaults.standard.getMobileNumber()
        }
        
        
        
        border(textname: txtName,placholderText:"Add".localized1+" "+"Name".localized1)
        border(textname: txtContactNo,placholderText:"ContactNumber".localized1)
        border(textname: txtKm,placholderText:"Enterkilometre".localized1)
        border(textname: txtLocation,placholderText:"Add".localized1+" "+"Address".localized1)
        btnSubmit.setTitle("Add".localized1, for: .normal)
        txtLocation.text = GlobalVariables.currentAddres
        btnSubmit.addTarget(self, action: #selector(AddActiveSamajSevaCntr.AddActiveSamajSeva(_:)), for: UIControlEvents.touchUpInside)
       
        
      
        
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm a"
        var currentTime = dateFormatter1.string(from: txtTimeFrom.date)
        GlobalVariables.selectedTimeFrom = currentTime
        GlobalVariables.selectedTimeTo = currentTime
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        btnDate.setTitle(GlobalVariables.selectedDate, for: .normal)
    }
    
    @IBAction func btnDateClicked(_ sender: Any) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "ActiveSamaj"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    
    
    
    @IBAction func timeFromChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        var strDate = dateFormatter.string(from: txtTimeFrom.date)
        GlobalVariables.selectedTimeFrom = strDate
    }
    
    @IBAction func timeToChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        var strDate = dateFormatter.string(from: txtTimeTo.date)
        GlobalVariables.selectedTimeTo = strDate
    }
    
    
    @objc func AddActiveSamajSeva(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtName.text == ""){
            self.view.makeToast("Please Add Name", duration: 2.0, position: .top)
        }else if(!txtContactNo.text!.isPhone()){
            self.view.makeToast("Wrong Mobile No", duration: 2.0, position: .top)
        }else if(!(txtKm.text?.isNumber)!){
            self.view.makeToast("Add kilometer", duration: 2.0, position: .top)
        }
        else{
   

            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let currentDate = formatter.string(from: date)
            
            let parameters = "name=\(UserDefaults.standard.getMemberName())&member_id=\(UserDefaults.standard.getUserID())&contact=\(txtContactNo.text!)&km=\(txtKm.text!)&address=\(GlobalVariables.currentAddres)&latitude=\(GlobalVariables.currentLat)&longitude=\(GlobalVariables.currentLong)&time_from=\(GlobalVariables.selectedTimeFrom)&time_to=\(GlobalVariables.selectedTimeTo)&date=\(currentDate)"
            print("paratemer samaj-----",parameters)
            let url = URL(string:ServerUrl.post_active_samaj_seva)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            self.showActivityIndicator()
            
            do {
                request.httpBody = parameters.data(using: String.Encoding.utf8)
            }
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                    
                    let Success = json?.object(forKey: "message") as? String;
                    if (Success == "Success")
                    {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            //self.alert(message: "Nirjara Ap", title: "Active Samaj Seva Added Successfully")
                            let alertController = JHTAlertController(title: "Success", message:"Samaj Seva Added Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
                                self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[15])
                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                
                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.showAlert(title: "Nirjara Ap", message: "Something Went Wrong")
                            //self.alert(message: "Invalid Credential", title:"Nirjara Ap")
                        }
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func border(textname : UITextField,placholderText : String){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x : 4, y : textname.frame.height-1,width:self.view.frame.width-28, height : 1.0)
        let color = UIColor.rgb(hexcolor:"#DCDCDC").cgColor
        bottomLine.backgroundColor = color
        textname.setTextLeftPadding(left: 10)
        
        textname.attributedPlaceholder = NSAttributedString(string:placholderText, attributes:[NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: "DCDCDC"),NSAttributedStringKey.font :UIFont(name: "Helvetica", size: 18)!])
        textname.borderStyle = UITextBorderStyle.none
        textname.layer.addSublayer(bottomLine)
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
