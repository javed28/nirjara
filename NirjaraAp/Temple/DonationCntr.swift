//
//  DonationCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class DonationCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var donationName = ["Heart Patient","Study Paise"]
    var reciverName = ["Muna Jain","Tina and Babita sharma"]
    var fundRecived = ["Fund Recieved : 10000","Fund Recieved : 23000"]
    var fundRequired = ["Fund Required : 12000","Fund Recieved : 1456443"]
    var balance = ["Balance Required : 4000","Balance Required : 67999"]
    var place = ["Mumbai","Rajasthan"]
    var CategoryImage = ["donation1","donation2"]
    @IBOutlet weak var donationTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Donation"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
        
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        sideMenu()
        // Do any additional setup after loading the view.
    }
    @objc func addTapped(){
        
    }
    func sideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return donationName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = donationTable.dequeueReusableCell(withIdentifier: "donationIdentifier") as! DonationTableViewCell!
        
        
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.lblReason?.text = donationName[indexPath.row]
        cell?.lblFundReq?.text = fundRequired[indexPath.row]
        cell?.lblBalanceReq?.text = balance[indexPath.row]
        cell?.lblFundRec?.text = fundRecived[indexPath.row]
        cell?.lblState?.text = place[indexPath.row].uppercased()
        cell?.lblPatientName?.text = reciverName[indexPath.row].uppercased()
        var image : UIImage = UIImage(named: CategoryImage[indexPath.row])!
        cell?.imgDonation.image = image
       
        cell?.mainView?.layer.shadowColor = UIColor.gray.cgColor
        cell?.mainView?.layer.shadowOpacity = 1
        cell?.mainView?.layer.shadowOffset = CGSize.zero
        cell?.mainView?.layer.shadowRadius = 10
        
       cell?.mainView?.frame = CGRect(x:10,y:13,width:self.view.frame.width-20,height:270)
       cell?.topView?.frame = CGRect(x:0,y:0,width:(cell?.mainView.frame.width)!,height:185)
       cell?.lblPatientName?.frame = CGRect(x:(cell?.topView.frame.origin.x)!,y:(cell?.topView.frame.origin.y)!+15,width:(cell?.topView.frame.width)!,height:20)
       cell?.imgDonation?.frame = CGRect(x:(cell?.topView.frame.origin.x)!,y:(cell?.topView.frame.origin.y)!+40,width:120,height:130)
    
        
        
        cell?.lblReason?.frame = CGRect(x:130,y:(cell?.topView.frame.origin.y)!+50,width:170,height:30)
        cell?.lblFundReq?.frame = CGRect(x:130,y:(cell?.topView.frame.origin.y)!+90,width:(cell?.topView.frame.width)!,height:20)
        cell?.lblFundRec?.frame = CGRect(x:130,y:(cell?.topView.frame.origin.y)!+115,width:(cell?.topView.frame.width)!,height:20)
       
        cell?.lblBalanceReq?.frame = CGRect(x:130,y:(cell?.topView.frame.origin.y)!+140,width:(cell?.topView.frame.width)!,height:20)
        
        cell?.topView.addSubview((cell?.lblPatientName)!)
        cell?.topView.addSubview((cell?.imgDonation)!)
        cell?.topView.addSubview((cell?.lblReason)!)
        cell?.topView.addSubview((cell?.lblFundReq)!)
        cell?.topView.addSubview((cell?.lblBalanceReq)!)
        cell?.topView.addSubview((cell?.lblFundRec)!)
        
        cell?.lblState?.frame = CGRect(x:15,y:195,width:170,height:25)
        cell?.lblCountry?.frame = CGRect(x:15,y:225,width:170,height:25)
        cell?.btnDetails?.frame = CGRect(x:(cell?.mainView.frame.width)!-105,y:203,width:90,height:35)
        
        cell?.mainView.addSubview((cell?.lblState)!)
        cell?.mainView.addSubview((cell?.lblCountry)!)
        cell?.mainView.addSubview((cell?.btnDetails)!)
        cell?.mainView.addSubview((cell?.topView)!)
        return cell!
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
