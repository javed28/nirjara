//
//  SelectCalenderCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import FSCalendar


class SelectCalenderCntr: UIViewController,FSCalendarDataSource,FSCalendarDelegate {
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    
    
    

    var which = String()
    @IBOutlet weak var selectDate: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Select Date"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:9))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:9,length:4))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
    
        let date = Date()
        let formatter = DateFormatter()
       
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDate = formatter.string(from: date)
        self.selectDate.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.selectDate.select(self.formatter.date(from: currentDate)!)
        
        let scopeGesture = UIPanGestureRecognizer(target: self.selectDate, action: #selector(self.selectDate.handleScopeGesture(_:)))
        self.selectDate.addGestureRecognizer(scopeGesture)
        
        // For UITest
        self.selectDate.scrollDirection = .vertical
        self.selectDate.pagingEnabled = false
        self.selectDate.accessibilityIdentifier = "calendar"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "31-12-2020")!
    }

    public func minimumDate(for calendar: FSCalendar) -> Date {
        return Date() // crash!
    }
    
//    public func maximumDate(for calendar: FSCalendar) -> Date {
//        return Date().addDays(365)
//    }
    
    

    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        //print("calendar did select date \(self.formatter.string(from: date))")
        if(which == "Events From"){
            GlobalVariables.selectedEventsDateFrom = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }else if(which == "Events To"){
            
            if(stringToDate(takeDate: GlobalVariables.selectedEventsDateFrom) > stringToDate(takeDate: self.formatter.string(from: date)) ){
                self.view.makeToast("To Date should be more than current date", duration: 3.0, position: .top)
            }else{
                GlobalVariables.selectedEventsDateTo = self.formatter.string(from: date)
                self.navigationController?.popViewController(animated: true)
            }
        }else if(which == "ActiveSamaj"){
            GlobalVariables.selectedDate = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }else if(which == "internationalHoliday"){
            GlobalVariables.selectedHolidayDateFrom = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }
        else if(which == "carPurchaseFrom"){
            GlobalVariables.selectedCarsFrom = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }
        else if(which == "carPurchaseTo"){
             print("date-111--",GlobalVariables.selectedCarsFrom)
            print("date---",date)
            print("date-111--",self.stringToDate(takeDate: GlobalVariables.selectedCarsFrom))
            print("date---",self.stringToDate(takeDate: self.formatter.string(from: date)))
            if(self.stringToDate(takeDate: GlobalVariables.selectedCarsFrom) > self.stringToDate(takeDate: self.formatter.string(from: date)) ){
                self.view.makeToast("Car To Date should be more than Car Purchase from date", duration: 3.0, position: .top)
            }else{
                GlobalVariables.selectedCarsTo = self.formatter.string(from: date)
                self.navigationController?.popViewController(animated: true)
            }
        }
        else if(which == "mobilePurchaseFrom"){
            GlobalVariables.selectedMobileFrom = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }
        else if(which == "mobilePurchaseTo"){
           
            if(self.stringToDate(takeDate: GlobalVariables.selectedMobileFrom) > self.stringToDate(takeDate: self.formatter.string(from: date)) ){
                self.view.makeToast("Mobile To Date should be more than Mobile Purchase from date", duration: 3.0, position: .top)
            }else{
                 GlobalVariables.selectedMobileTo = self.formatter.string(from: date)
                self.navigationController?.popViewController(animated: true)
            }
        }
            
        else if(which == "selectedIpadFrom"){
            GlobalVariables.selectedIpadFrom = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }
        else if(which == "selectedIpadTo"){
            
            if(self.stringToDate(takeDate: GlobalVariables.selectedIpadFrom) > self.stringToDate(takeDate: self.formatter.string(from: date)) ){
                self.view.makeToast("Ipad To Date should be more than Mobile Purchase from date", duration: 3.0, position: .top)
            }else{
                GlobalVariables.selectedIpadTo = self.formatter.string(from: date)
                self.navigationController?.popViewController(animated: true)
            }
        }
            
        else if(which == "jewelleryPurchaseFrom"){
            GlobalVariables.selectedJewerallyFrom = self.formatter.string(from: date)
            self.navigationController?.popViewController(animated: true)
        }
        else if(which == "jewelleryPurchaseTo"){
            if(self.stringToDate(takeDate: GlobalVariables.selectedJewerallyFrom) > self.stringToDate(takeDate: self.formatter.string(from: date)) ){
                self.view.makeToast("Jewellery To Date should be more than Jewellery Purchase from date", duration: 3.0, position: .top)
            }else{
                GlobalVariables.selectedJewerallyTo = self.formatter.string(from: date)
                self.navigationController?.popViewController(animated: true)
            }
        }
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        
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
