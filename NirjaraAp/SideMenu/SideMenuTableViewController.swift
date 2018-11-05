//
//  SideMenuTableViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/26/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController
import Social
import MessageUI

class SideMenuTableViewController: UITableViewController,MFMessageComposeViewControllerDelegate {

    
      var containerController: ContainerViewController?
    
     var CategoryArray = ["Choose Language","Home","Profile","Guru Bhagwant Tracking","Temple and Sthanak","Vrath Pachchakan","Jain Mantras","Donation","Jain Yellow Pages","Jain Kids name","Jain Events","Jain Library","Withdraw Money","Share App","Help","Contact","Logout"]
    
    var CategoryImage = ["Language","home-icon","profilemenu","d1","d3","d5","d6","d7","Business","Jain-kids-name","d10","d8","d7","share","img_134106","contact-icon","Logout"]
    
    var CategoryArrayHindi = ["भाषा चुनें","घर","प्रोफाइल","जैन गुरू ट्रैकिंग","मंदिर और स्थानक","व्रत पच्चक्खाण","जैन मंत्र","दान","जैन येल्लो पेजेस","जैन बच्चों के नाम","जैन महोत्सव","जैन ग्रंथालय","रुपया निकालना","शेयर ऍप","सहायता","संपर्क करें","लॉग आउट"]
    
    var CategoryArrayGujarathi = ["ભાષા પસંદ","ઘર","પ્રોફાઇલ","જૈન ગુરુ ટ્રેકિંગ","મંદિરો સ્ટાનિક","વ્રત પંચકણ","જૈન મંત્ર","દાન","જૈન યેલ્લોઉં પગેસ ","જૈન બાળકોનું નામ","જૈન મોહોત્સવ","જૈન લાઇબ્રેરી","પૈસા પાછા ખેંચો","શેર એપ","મદદ","સંપર્ક કરો","લૉગ આઉટ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        containerController = revealViewController().frontViewController as? ContainerViewController
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Set the selection in menu table view to the front view controller. At this time it is ViewController1
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tableView?.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CategoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuIdentifier") as! SideMenuTableViewCell!
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        //cell?.lblMenuName?.text = CategoryArray[indexPath.row]
        if(UserDefaults.standard.getLanguage() == "en"){
            cell?.lblMenuName?.text = CategoryArray[indexPath.row]
        }else if(UserDefaults.standard.getLanguage() == "hi"){
            cell?.lblMenuName?.text = CategoryArrayHindi[indexPath.row]
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            cell?.lblMenuName?.text = CategoryArrayGujarathi[indexPath.row]
        }
        
        
        cell?.lblMenuName?.textColor = UIColor.white
        cell?.lblMenuName?.frame = CGRect(x:63,y:8,width:self.view.frame.width,height:40)
        var image : UIImage = UIImage(named: CategoryImage[indexPath.row])!
        cell?.imgSideMenu.image = image
        cell?.imgSideMenu?.frame = CGRect(x:15,y:13,width:28,height:28)
        return cell!
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[0])
            
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 1 {
             containerController?.tabBar.selectedItem = containerController?.tabBar.items![0]
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[1])
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
         if indexPath.row == 2  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[4])
            containerController?.tabBar.selectedItem = containerController?.tabBar.items![3]
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 3  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[6])
            containerController?.tabBar.selectedItem = nil
           // containerController?.tabBar.selectedItem = containerController?.tabBar.items![3]
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 4  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[8])
            containerController?.tabBar.selectedItem = nil
            // containerController?.tabBar.selectedItem = containerController?.tabBar.items![3]
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 5  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[10])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 6  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[11])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 7  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[12])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 8  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[19])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        
        if indexPath.row == 9  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[17])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 10  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[14])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 11  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[13])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 12  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[18])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        
        if(indexPath.row == 13){
            let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Twitter", style: .default, handler: { (alert) in
                self.clickedTwitter()
            })
            let gallery = UIAlertAction(title: "Whatsapp", style: .default) { (alert) in
                self.whatsupClicked()
            }
            let message = UIAlertAction(title: "Message", style: .default) { (alert) in
            self.messageClicked()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
                
            }
            alertViewController.addAction(camera)
            alertViewController.addAction(gallery)
            alertViewController.addAction(message)
            alertViewController.addAction(cancel)
            self.present(alertViewController, animated: true, completion: nil)
        }
        if indexPath.row == 14  {
//            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[18])
//            containerController?.tabBar.selectedItem = nil
//            revealViewController().pushFrontViewController(containerController,animated:true)
            
           
           
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let gotoIntro = storyboard.instantiateViewController(withIdentifier: "introsliderNavigation") as! IntroSliderViewController
//            self.present(gotoIntro, animated: true, completion: nil)

                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let gotoIntro = storyboard.instantiateViewController(withIdentifier: "introvideoNavigation") as! IntroVideoViewController
                        self.present(gotoIntro, animated: true, completion: nil)
            
         
        }
        if indexPath.row == 15  {
            containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[20])
            containerController?.tabBar.selectedItem = nil
            revealViewController().pushFrontViewController(containerController,animated:true)
        }
        if indexPath.row == 16{
            let alertController = JHTAlertController(title: "logout".localized1, message:"WantToLogout".localized1, preferredStyle: .alert)
            
            alertController.titleTextColor = .black
            alertController.titleFont = .systemFont(ofSize: 18)
            alertController.titleViewBackgroundColor = .white
            alertController.messageTextColor = .black
            alertController.alertBackgroundColor = .white
            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
            
            let okAction = JHTAlertAction(title: "Ok".localized1, style: .default) { _ in
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let gotoLogin = self.storyboard?.instantiateViewController(withIdentifier: "loginCntr") as? LoginViewCntr
                //self.navigationController?.pushViewController(gotoLogin!, animated: true)
                self.present(gotoLogin!, animated: true)
                
            }

            let cancelAction = JHTAlertAction(title: "Cancel".localized1, style: .cancel,  handler: nil)
            alertController.setButtonTextColorFor(.cancel, to: .white)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
        

    }
   
    
    func clickedTwitter(){
        let alert = UIAlertController(title : "Share",message : "Share Nirjara on Twitter",preferredStyle:.actionSheet)
        let actionOne = UIAlertAction(title : "Share on Twitter",style : .default){
            (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                self.showAlert(title: "Accounts", message: "Please login to a Twitter account to share.")
            } else {
                var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterSheet.setInitialText("https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8")
                twitterSheet.add(UIImage(named : "alertIcon"))
                self.present(twitterSheet, animated: true, completion: nil)
            }
        }
        alert.addAction(actionOne)
        self.present(alert,animated: true,completion: nil)
        
    }
    
    func whatsupClicked(){
        
       /* let msg = "https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        let urlWhats = "whatsapp://send?text=\(msg)"

        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    self.showAlert(title: "Accounts", message: "Please Install Whatsapp")
                }
            }
        }*/

        let urlString = "https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)
        let url  = NSURL(string: "whatsapp://send?text=\(urlStringEncoded!)")
        
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        } else {
            let errorAlert = UIAlertView(title: "Cannot Send Message", message: "Your device is not able to send WhatsApp messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    func messageClicked(){
        
        sendMsg()
    }
    
    
    func sendMsg(){
        if (MFMessageComposeViewController.canSendText()) {
            
            let controller = MFMessageComposeViewController()
            controller.body = "https://itunes.apple.com/in/app/nirjara-ap/id1364177375?ls=1&mt=8"
            
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
            
            
        }else{
            self.showAlert(title: "Warnigng", message: "Unable To send sms")
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
