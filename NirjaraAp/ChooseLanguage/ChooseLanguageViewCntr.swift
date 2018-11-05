//
//  ChooseLanguageViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import M13Checkbox

protocol AnimationSelectionTableViewControllerDelegate {
    func selectedAnimation(_ animation: M13Checkbox.Animation)
}
class ChooseLanguageViewCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var containerController: ContainerViewController?
    let animations: [M13Checkbox.Animation] = [.dot(.stroke)]
    var delegate: AnimationSelectionTableViewControllerDelegate?
    
    @IBOutlet weak var labguageTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var lan = String()
    var  LanguageArray =  ["English","Hindi","Gujarathi"];
    var  LanguageArrayHindi =  ["अंग्रेज़ी","हिंदी","गुजराती"];
    var  LanguageArrayGujarathi =  ["અંગ્રેજી","હિન્દી","ગુજરાતી"];
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpMenu()
       labguageTableView.separatorStyle = .none
       containerController = revealViewController().frontViewController as? ContainerViewController
        // Do any additional setup after loading the view.
    }
    func setUpMenu(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
       // if(UserDefaults.standard.getLanguage() == "en"){
            let myString:NSString = "Choose Language"
            let strTitle = myString.components(separatedBy: " ")
            
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:strTitle[0].count))
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:strTitle[0].count+1,length:strTitle[1].count))
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
       /* }else if(UserDefaults.standard.getLanguage() == "hi"){
            let myString:NSString = "भाषा चुनें"
            let strTitle = myString.components(separatedBy: " ")
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:strTitle[0].count))
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:strTitle[0].count+1,length:strTitle[1].count))
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            let myString:NSString = "ભાષા પસંદ કરો"
            let strTitle = myString.components(separatedBy: " ")
            
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:strTitle[0].count + strTitle[1].count))
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:strTitle[0].count + strTitle[1].count+2,length:strTitle[2].count))
            titleLabel.attributedText = myMutableString
            navigationItem.titleView = titleLabel
        }*/

    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LanguageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labguageTableView.dequeueReusableCell(withIdentifier: "languageIdentifier") as! ChooseLangTableViewCell!
        cell?.selectionStyle = .none
        if(UserDefaults.standard.getLanguage() == "en"){
        cell?.txtLanguage?.text = LanguageArray[indexPath.row]
        }else if(UserDefaults.standard.getLanguage() == "hi"){
            cell?.txtLanguage?.text = LanguageArrayHindi[indexPath.row]
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            cell?.txtLanguage?.text = LanguageArrayGujarathi[indexPath.row]
        }
        cell?.txtLanguage?.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:40)
        
        if(lan == nil){
            
        }else{
            if(indexPath.row == 0){
                if(lan == "en"){
                    cell?.imgCheck?.image = UIImage(named: "checked")
                }else{
                    cell?.imgCheck?.image = nil
                }
                
            }else if(indexPath.row == 1){
                if(lan == "hi"){
                    cell?.imgCheck?.image = UIImage(named: "checked")
                }else{
                    cell?.imgCheck?.image = nil
                }
            }else if(indexPath.row == 2){
                if(lan == "gu"){
                    cell?.imgCheck?.image = UIImage(named: "checked")
                }else{
                    cell?.imgCheck?.image = nil
                }
            }
        }
        cell?.imgCheck?.frame = CGRect(x:self.view.frame.width-60,y:10,width:40,height:40)
        cell?.bottomLine?.frame = CGRect(x:0,y:55,width:self.view.frame.width,height:1)
        return cell!
        
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isConnectedToNetwork() {
        if(indexPath.row == 0){
          // Language.language = Language.english
             //UserDefaults.standard.setLanguage(value: "en")
             //GlobalVariables.selectedLanguage = "en"
            if(UserDefaults.standard.getLanguage() == "en"){
                self.view.makeToast("You have already selected this language Please Choose Other", duration: 3.0, position: .top)
            }else{
                updateLanguage(lang : "en")
            }
            
            
        }else if(indexPath.row == 1){
           // Language.language = Language.hindi
            
            if(UserDefaults.standard.getLanguage() == "hi"){
                self.view.makeToast("You have already selected this language Please Choose Other", duration: 3.0, position: .top)
            }else{
                updateLanguage(lang : "hi")
            }

           
        }else if(indexPath.row == 2){
            if(UserDefaults.standard.getLanguage() == "gu"){
                self.view.makeToast("You have already selected this language Please Choose Other", duration: 3.0, position: .top)
            }else{
                updateLanguage(lang : "gu")
            }
            
        }
        else {
            if(UserDefaults.standard.getLanguage() == "en"){
                self.view.makeToast("You have already selected this language Please Choose Other", duration: 3.0, position: .top)
            }else{
                updateLanguage(lang : "en")
            }
            //Language.language = Language.gujarathi
            
 
        }
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }

        
        
//        containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[1])
//        containerController?.tabBar.selectedItem = nil
//        revealViewController().pushFrontViewController(containerController,animated:true)
    }
    
    func updateLanguage(lang : String){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&lang=\(lang)"
        let url = URL(string:ServerUrl.post_language)!
        print("langua--",parameters)
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
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    
                    DispatchQueue.main.async {
                        UserDefaults.standard.setLanguage(value: lang)
                        GlobalVariables.selectedLanguage = lang
                        self.hideActivityIndicator()
                       // print("langu0000----",lang)
//                        if(lang == "en"){
//                            Language.language = Language.english
//                        }else if(lang == "hi"){
//                            Language.language = Language.hindi
//                        }else if(lang == "gu"){
//                            Language.language = Language.gujarathi
//                        }else{
//                            Language.language = Language.english
//                        }
                        
                        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
                            name: "Main",
                            bundle: nil
                            ).instantiateInitialViewController()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        sideMenu()
        lan = ""
        lan = UserDefaults.standard.getLanguage()
        print("language---",UserDefaults.standard.getLanguage())
        labguageTableView.reloadData()
    }
    func sideMenu(){
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 180
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
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
@IBDesignable
class AnimationCell: UITableViewCell {
    
    @IBInspectable var imageSize: CGSize = CGSize.zero
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = imageView {
            imageView.frame = CGRect(x: imageView.frame.origin.x, y: (frame.size.height - imageSize.height) / 2.0, width: imageSize.width, height: imageSize.height)
        }
}
}
