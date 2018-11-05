//
//  AddEventsCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController

class AddEventsCntr: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var lblEventInfo: UILabel!
    @IBOutlet weak var txtEventInfo: UITextView!
    
    @IBOutlet weak var lblOrganizedBy: UILabel!
    @IBOutlet weak var txtOrganizedBy: UITextField!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var lblFrom: UILabel!
    
    
    @IBOutlet weak var btnFrom: UIButton!
    
    @IBOutlet weak var lblTo: UILabel!
   
    @IBOutlet weak var btnTo: UIButton!
    
    @IBOutlet weak var lblTimeFrom: UILabel!
    @IBOutlet weak var txtTimeFrom: UIDatePicker!
    
    @IBOutlet weak var txtTimeTo: UIDatePicker!
    @IBOutlet weak var lblTimeTo: UILabel!
  
    
    @IBOutlet weak var lblContactPerson: UILabel!
    @IBOutlet weak var txtContactPerson: UITextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Add Jain Events"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:6))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:6,length:11))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        
        self.updateBackButton()
        
        lblTitle.frame = CGRect(x:10,y:18,width:self.view.frame.width-20,height:25)
        txtTitle.frame = CGRect(x:10,y:lblTitle.frame.origin.y+lblTitle.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        lblEventInfo.frame = CGRect(x:10,y:txtTitle.frame.origin.y+txtTitle.frame.height+10,width:self.view.frame.width-20,height:25)
        txtEventInfo.frame = CGRect(x:10,y:lblEventInfo.frame.origin.y+lblEventInfo.frame.height+5,width:self.view.frame.width-20,height:100)
        
        lblOrganizedBy.frame = CGRect(x:10,y:txtEventInfo.frame.origin.y+txtEventInfo.frame.height+10,width:self.view.frame.width-20,height:25)
        txtOrganizedBy.frame = CGRect(x:10,y:lblOrganizedBy.frame.origin.y+lblOrganizedBy.frame.height+5,width:self.view.frame.width-20,height:45)
        
        lblAddress.frame = CGRect(x:10,y:txtOrganizedBy.frame.origin.y+txtOrganizedBy.frame.height+10,width:self.view.frame.width-20,height:25)
        txtAddress.frame = CGRect(x:10,y:lblAddress.frame.origin.y+lblAddress.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        lblFrom.frame = CGRect(x:10,y:txtAddress.frame.origin.y+txtAddress.frame.height+10,width:self.view.frame.width-20,height:25)
        btnFrom.frame = CGRect(x:10,y:lblFrom.frame.origin.y+lblFrom.frame.height+5,width:self.view.frame.width-20,height:45)
        
        lblTo.frame = CGRect(x:10,y:btnFrom.frame.origin.y+btnFrom.frame.height+10,width:self.view.frame.width-20,height:25)
        btnTo.frame = CGRect(x:10,y:lblTo.frame.origin.y+lblTo.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        
        lblTimeFrom.frame = CGRect(x:10,y:btnTo.frame.origin.y+btnTo.frame.height+10,width:self.view.frame.width-20,height:25)
        txtTimeFrom.frame = CGRect(x:10,y:lblTimeFrom.frame.origin.y+lblTimeFrom.frame.height+5,width:self.view.frame.width-20,height:45)
        
        lblTimeTo.frame = CGRect(x:10,y:txtTimeFrom.frame.origin.y+txtTimeFrom.frame.height+10,width:self.view.frame.width-20,height:25)
        txtTimeTo.frame = CGRect(x:10,y:lblTimeTo.frame.origin.y+lblTimeTo.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        lblContactPerson.frame = CGRect(x:10,y:txtTimeTo.frame.origin.y+txtTimeTo.frame.height+10,width:self.view.frame.width-20,height:25)
        txtContactPerson.frame = CGRect(x:10,y:lblContactPerson.frame.origin.y+lblContactPerson.frame.height+5,width:self.view.frame.width-20,height:45)
        
        lblEmail.frame = CGRect(x:10,y:txtContactPerson.frame.origin.y+txtContactPerson.frame.height+10,width:self.view.frame.width-20,height:25)
        txtEmail.frame = CGRect(x:10,y:lblEmail.frame.origin.y+lblEmail.frame.height+5,width:self.view.frame.width-20,height:45)
        
        
        lblPhone.frame = CGRect(x:10,y:txtEmail.frame.origin.y+txtEmail.frame.height+10,width:self.view.frame.width-20,height:25)
        txtPhone.frame = CGRect(x:10,y:lblPhone.frame.origin.y+lblPhone.frame.height+5,width:self.view.frame.width-20,height:45)
        
        btnSubmit.frame = CGRect(x:10,y:txtPhone.frame.origin.y+txtPhone.frame.height+25,width:self.view.frame.width-20,height:50)
        
        
        
        
        // Do any additional setup after loading the view.
        
        border(textname: txtTitle,placholderText:"Title".localized1)
        border(textname: txtOrganizedBy,placholderText:"OrganizedBy".localized1)
        border(textname: txtAddress,placholderText:"Address")
        border(textname: txtContactPerson,placholderText:"ContactPerson".localized1)
        border(textname: txtEmail,placholderText:"Email".localized1)
        border(textname: txtPhone,placholderText:"Phone".localized1)
        
        
        
        lblTitle.text = "Title".localized1
        lblEventInfo.text = "Events".localized1
        lblOrganizedBy.text = "OrganizedBy".localized1
        lblAddress.text = "Address".localized1
        lblFrom.text = "Date".localized1
        lblTo.text = "Date".localized1
        lblTimeFrom.text = "Timefrom".localized1
        lblTimeTo.text = "TimeTo".localized1
        lblContactPerson.text = "ContactPerson".localized1
        lblEmail.text = "Email".localized1
        lblPhone.text = "Phone".localized1
        
        btnSubmit.setTitle("Add".localized1, for: .normal)
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
        
       // self.txtTimeFrom.minimumDate = startDate as Date
        //self.txtTimeTo.minimumDate = startDate as Date
        
        
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm a"
        var currentTime = dateFormatter1.string(from: txtTimeFrom.date)
        GlobalVariables.selectedEventsTimeFrom = currentTime
        GlobalVariables.selectedEventsTimeTo = currentTime
        
         btnSubmit.addTarget(self, action: #selector(AddEvents(_:)), for: UIControlEvents.touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
          
    }

    override func viewWillAppear(_ animated: Bool) {
        
        btnFrom.setTitle(GlobalVariables.selectedEventsDateFrom, for: .normal)
        btnTo.setTitle(GlobalVariables.selectedEventsDateTo, for: .normal)
        
    }
    
    @IBAction func btnDateFromClicked(_ sender: UIButton) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "Events From"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    
    @IBAction func btnToClicked(_ sender: Any) {
        let calenderCntr = storyboard?.instantiateViewController(withIdentifier: "calenderStoryBoard") as! SelectCalenderCntr
        calenderCntr.which = "Events To"
        self.navigationController?.pushViewController(calenderCntr, animated: true)
    }
    
    
   
    
   
    @IBAction func timeFromChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        var strDate = dateFormatter.string(from: txtTimeFrom.date)
        GlobalVariables.selectedEventsTimeFrom = strDate
    }
    
    @IBAction func timeToChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        var strDate = dateFormatter.string(from: txtTimeTo.date)
        GlobalVariables.selectedEventsTimeTo = strDate
    }
    
    @objc func AddEvents(_ sender : UIButton){
        if isConnectedToNetwork() {
        if(txtTitle.text == ""){
            self.view.makeToast("Please Add Title", duration: 2.0, position: .top)
        }else if(txtOrganizedBy.text == ""){
            self.view.makeToast("Please Enter Organized By", duration: 2.0, position: .top)
        }
        else if(txtAddress.text == ""){
            self.view.makeToast("Please Enter Address", duration: 2.0, position: .top)
        }
        else if(self.stringToDate(takeDate: GlobalVariables.selectedEventsDateFrom) > (self.stringToDate(takeDate: GlobalVariables.selectedEventsDateTo))){
            self.view.makeToast("To Date should be more than current date", duration: 3.0, position: .top)
        }
        else if(txtContactPerson.text == ""){
            self.view.makeToast("Please Enter Contact Person Name", duration: 2.0, position: .top)
        }
//        else if(!txtPhone.text!.isPhone()){
//            self.view.makeToast("Please Enter Mobile No", duration: 2.0, position: .top)
//        }
        
        else{
            var mobile = ""
            if(txtPhone.text == ""){
                
            }else{
                mobile = txtPhone.text!
            }
            
            var email = ""
            if(txtEmail.text == ""){
                email = ""
            }else{
                email = txtEmail.text!
                }
                
                    
                   let dateFrom =  GlobalVariables.selectedEventsDateFrom.convertDateForEvents(GlobalVariables.selectedEventsDateFrom)
                   let dateTo =  GlobalVariables.selectedEventsDateTo.convertDateForEvents(GlobalVariables.selectedEventsDateTo)
                    
            let parameters = "event_title=\(txtTitle.text!)&member_id=\(UserDefaults.standard.getUserID())&event_description=\(txtEventInfo.text!)&event_location=\(txtAddress.text!)&event_venue=\(txtAddress.text!)&event_from=\(dateFrom+" - "+GlobalVariables.selectedEventsTimeFrom)&event_to=\(dateTo+" - "+GlobalVariables.selectedEventsTimeTo)&event_organizer=\(txtOrganizedBy.text!)&contact_person=\(txtContactPerson.text!)&contact=\(mobile)&email=\(email)"
            print("paratemer events Add",parameters)
            let url = URL(string:ServerUrl.post_add_events_ios)!
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
                    if (Success == "success")
                    {
                        
                            let last_inserted_id = json?.object(forKey: "data") as! Int
                        
                            print("Events Repsonse---finally",last_inserted_id)
                        
                        DispatchQueue.main.async {
                             self.hideActivityIndicator()
                            
                            
                            let alertController = JHTAlertController(title: "Nirjara Ap", message:"Events Added Successfully", preferredStyle: .alert)
                            
                            alertController.titleTextColor = .black
                            alertController.titleFont = .systemFont(ofSize: 18)
                            alertController.titleViewBackgroundColor = .white
                            alertController.messageTextColor = .black
                            alertController.alertBackgroundColor = .white
                            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                            
                            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "OtherImgUplCntr") as? OtherImageUploadCntr
                                
                                gotoOtherUpload?.whatToUpload = "Events"
                                gotoOtherUpload?.eventId = String(describing: last_inserted_id)
                               
                                self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)

                            }
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            self.alert(message: "Nirjara Ap", title: "Something Went Wrong")
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
