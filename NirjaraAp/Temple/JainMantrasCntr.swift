//
//  JainMantrasCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import JHTAlertController


class JainMantrasCntr: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var imgTop: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblImp: UILabel!
    @IBOutlet weak var lblLabh: UILabel!
    @IBOutlet weak var lblVidhi: UILabel!
    @IBOutlet weak var lblRead: UILabel!
    @IBOutlet weak var lblListen: UILabel!
    @IBOutlet weak var labelTopView: UIView!
    
    @IBOutlet weak var pachkanTableView: UITableView!
    var sections = [String]()
    var items = [[String]]()
    
    //let sections = ["pizza", "deep dish pizza", "calzone"]
    
   // let items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]
    
    @IBOutlet weak var scrollImage: UIScrollView!
    
    @IBOutlet weak var imgViewTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jain Mantras"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:7,length:7))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        scrollImage.delegate = self
        pachkanTableView.separatorStyle = .none
        //imgTop.frame = CGRect(x:0,y:70,width:self.view.frame.width,height:200)
        //labelTopView.frame = CGRect(x:0,y:270,width:self.view.frame.width,height:70)
       // pachkanTableView.frame = CGRect(x:0,y:345,width:self.view.frame.width,height:self.view.frame.height+100)
         let widthofCell : CGFloat = self.view.frame.width/6
        
        lblTitle.frame = CGRect(x:0,y:5,width:widthofCell+15,height:50)
        lblImp.frame = CGRect(x:(widthofCell)+15,y:5,width:widthofCell,height:50)
        lblLabh.frame = CGRect(x:(widthofCell * 2)+15,y:5,width:widthofCell,height:50)
        lblVidhi.frame = CGRect(x:(widthofCell * 3)+15,y:5,width : widthofCell,height:50)
        lblRead.frame = CGRect(x:(widthofCell * 4)+15,y:5,width:widthofCell,height:50)
        lblListen.frame = CGRect(x:(widthofCell * 5)+15,y:5,width:widthofCell,height:50)
       
        
        lblTitle.backgroundColor = UIColor.white
        lblImp.backgroundColor = UIColor.white
        lblLabh.backgroundColor = UIColor.white
        lblVidhi.backgroundColor = UIColor.white
        lblRead.backgroundColor = UIColor.white
        lblListen.backgroundColor = UIColor.white
        
        lblTitle.text = "Title".localized1
        lblImp.text = "Importance".localized1
        lblLabh.text = "Labh".localized1
        lblVidhi.text = "Vidhi".localized1
        lblRead.text = "Read".localized1
        lblListen.text = "Listen".localized1
        
        lblTitle.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        lblImp.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        lblLabh.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        lblVidhi.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        lblRead.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        lblListen.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        labelTopView.addSubview(lblTitle)
        labelTopView.addSubview(lblImp)
        labelTopView.addSubview(lblLabh)
        labelTopView.addSubview(lblVidhi)
        labelTopView.addSubview(lblRead)
        labelTopView.addSubview(lblListen)
        
        sideMenu()
        if(isConnectedToNetwork()){
           getGuruData()
        }else{
            
        }
        
      
        scrollImage.minimumZoomScale = 1.0
        scrollImage.maximumZoomScale = 6.0
        scrollImage.alpha = 0
        
        
      
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideImage))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
   @objc func hideImage(){
 
    scrollImage.alpha = 0
  
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var returnedView = UIView(frame: CGRect(x:0, y:2, width:self.view.frame.width, height:38)) //set these values as necessary
        returnedView.backgroundColor = UIColor.rgb(hexcolor: "#FF9800")
//        returnedView.layer.borderColor = UIColor.gray.cgColor
//        returnedView.layer.borderWidth = 1
        //returnedView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 1, scale: true)
        let label = UILabel(frame: CGRect(x:10, y:3, width:returnedView.frame.width-20, height:30))
        label.font = label.font.withSize(15)
        label.text = sections[section].uppercased()
        returnedView.addSubview(label)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pachkanTableView.dequeueReusableCell(withIdentifier: "packkanBodyIdentifier", for: indexPath) as! JainMantraTableViewCell
        
        
        let fullData = items[indexPath.section][indexPath.row].components(separatedBy: "::")
        cell.lblTitle.text = fullData[0]
        let greet4Height = cell.lblTitle.optimalHeight
        
        cell.selectionStyle = .none
        
        let widthofCell : CGFloat = self.view.frame.width/6
        cell.lblView.frame = CGRect(x:0,y:5,width:widthofCell+15,height:55)
        cell.viewImp.frame = CGRect(x:widthofCell+15,y:5,width:widthofCell+15,height:55)
        cell.viewLabh.frame = CGRect(x:(widthofCell * 2)+15,y:5,width:widthofCell,height:55)
        cell.viewVidhi.frame = CGRect(x:(widthofCell * 3)+15,y:5,width:widthofCell,height:55)
        cell.viewRead.frame = CGRect(x:(widthofCell * 4)+15,y:5,width:widthofCell,height:55)
        cell.viewListen.frame = CGRect(x:(widthofCell * 5)+15,y:5,width:widthofCell,height:55)
        
        cell.lblTitle.frame = CGRect(x:2,y:5,width:cell.lblView.frame.width-4,height:greet4Height)
        cell.lblTitle.numberOfLines = 0
        
        let notebook = UIImage(named: "notebook") as UIImage?
        let notebook_gray = UIImage(named: "notebook_gray") as UIImage?
        
        if(fullData[1] == ""){

            cell.btnImp.setImage(notebook_gray, for: .normal)
            cell.btnImp.accessibilityLabel = "no data"
        }else{

            cell.btnImp.setImage(notebook, for: .normal)
            cell.btnImp.accessibilityLabel = fullData[1]
        }
        if(fullData[2] == ""){
            cell.btnLabh.setImage(notebook_gray, for: .normal)
            cell.btnLabh.accessibilityLabel = "no data"
        }else{
            cell.btnLabh.setImage(notebook, for: .normal)
            cell.btnLabh.accessibilityLabel = fullData[2]
        }
        
        if(fullData[3] == ""){
            cell.btnVidhi.setImage(notebook_gray, for: .normal)
            cell.btnVidhi.accessibilityLabel = "no data"
        }else{
            cell.btnVidhi.setImage(notebook, for: .normal)
            cell.btnVidhi.accessibilityLabel = fullData[3]
        }
        if(fullData[4] == ""){
            cell.btnRead.setImage(notebook_gray, for: .normal)
            cell.btnRead.accessibilityLabel = "no data"
        }else{
            cell.btnRead.setImage(notebook, for: .normal)
            cell.btnRead.accessibilityLabel = fullData[4]
        }
        
        if(fullData[5] == ""){
            cell.btnListen.accessibilityLabel = "no data"
        }else{
            cell.btnListen.accessibilityLabel = fullData[5]
        }
        
        
        cell.btnImp.addTarget(self, action: #selector(showAlertWithImage(_:)), for: UIControlEvents.touchUpInside)
        cell.btnLabh.addTarget(self, action: #selector(showAlertWithImage(_:)), for: UIControlEvents.touchUpInside)
        cell.btnVidhi.addTarget(self, action: #selector(showAlertWithImage(_:)), for: UIControlEvents.touchUpInside)
        cell.btnRead.addTarget(self, action: #selector(showAlertWithData(_:)), for: UIControlEvents.touchUpInside)
        cell.btnListen.addTarget(self, action: #selector(gotoAudio(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        cell.btnImp.frame = CGRect(x:15,y:10,width:30,height:30)
        cell.btnRead.frame = CGRect(x:15,y:10,width:30,height:30)
        cell.btnVidhi.frame = CGRect(x:15,y:10,width:30,height:30)
        cell.btnLabh.frame = CGRect(x:15,y:10,width:30,height:30)
        cell.btnListen.frame = CGRect(x:11,y:10,width:30,height:30)
        
        
        
        
        cell.lblView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.viewListen.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.viewImp.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.viewRead.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.viewLabh.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        cell.viewVidhi.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)

        
         cell.lblView.addSubview(cell.lblTitle)
         cell.viewListen.addSubview(cell.btnListen)
         cell.viewImp.addSubview(cell.btnImp)
         cell.viewRead.addSubview(cell.btnRead)
         cell.viewVidhi.addSubview(cell.btnVidhi)
         cell.viewLabh.addSubview(cell.btnLabh)
        
        return cell
    }
    
    @objc func showAlertWithImage(_ sender : UIButton){
        
        if(sender.accessibilityLabel == "no data"){
            
        }else{
            
            if(sender.accessibilityLabel == "" || sender.accessibilityLabel == nil){
                
            }else{
            scrollImage.alpha = 1
            let url = URL(string:(sender.accessibilityLabel)!.replacingOccurrences(of: " ", with: "%20"))
            let placeholderImage = UIImage(named: "default_icon_new")!
               
            imgViewTitle.af_setImage(withURL: url!, placeholderImage: placeholderImage)
            self.imgViewTitle.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
            self.imgViewTitle.contentMode = .scaleAspectFit // OR .scaleAspectFill
            self.imgViewTitle.clipsToBounds = true
                }
            }
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgViewTitle
    }
    @objc func showAlertWithData(_ sender : UIButton){
        
        if(sender.accessibilityLabel == "no data"){
            
        }else{
            if((sender.accessibilityLabel!.range(of:".jpg") != nil) || (sender.accessibilityLabel!.range(of:".png") != nil)) {
                self.scrollImage.alpha = 1
                 let url = URL(string:(sender.accessibilityLabel)!.replacingOccurrences(of: " ", with: "%20"))
                let placeholderImage = UIImage(named: "default_icon_new")!
              
                imgViewTitle.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                self.imgViewTitle.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
                self.imgViewTitle.contentMode = .scaleAspectFit // OR .scaleAspectFill
                self.imgViewTitle.clipsToBounds = true
                
               
            }else{
               /* let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                
                let somethingAction = UIAlertAction(title: "Ok", style: .default, handler:nil)

                alert.view.backgroundColor = UIColor.rgb(hexcolor: "#387ef5")
                alert.view.tintColor = UIColor.black
                alert.addAction(somethingAction)
                
                
                let scroolView = UIScrollView()
                scroolView.widthAnchor.constraint(equalToConstant: 266).isActive = true
                scroolView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
                alert.view.addSubview(scroolView)
                scroolView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
                scroolView.topAnchor.constraint(equalTo: alert.view.topAnchor).isActive = true
                scroolView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50).isActive = true
                
                let customView = UILabel()
                customView.backgroundColor = .white
                customView.translatesAutoresizingMaskIntoConstraints = false
                customView.numberOfLines = 0
                customView.lineBreakMode = .byWordWrapping;
                customView.text = sender.accessibilityLabel!
                customView.frame = CGRect(x:0,y:20,width:scroolView.frame.width,height:customView.intrinsicContentSize.height)
                //customView.widthAnchor.constraint(equalToConstant: 265).isActive = true
                //customView.heightAnchor.constraint(equalToConstant: customView.intrinsicContentSize.height).isActive = true
                
                
                scroolView.addSubview(customView)
                
                self.present(alert, animated: true, completion:nil)*/
                
                
            let alertController = JHTAlertController(title: "Jain Mantras", message:sender.accessibilityLabel!, preferredStyle: .alert)
            
            alertController.titleTextColor = .black
            alertController.titleFont = .systemFont(ofSize: 18)
            alertController.titleViewBackgroundColor = .white
            alertController.messageTextColor = .black
            alertController.alertBackgroundColor = .white
            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
            
            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        }
    }
    @objc func gotoAudio(_ sender : UIButton){
        self.showAlert(title: "Nirjara App", message: "Audio Coming Soon")
//        if(sender.accessibilityLabel == "no data"){
//            self.showAlert(title: "Jain Mantras", message: "No audio for this")
//        }else{
//
//
//            let audioCntr = storyboard?.instantiateViewController(withIdentifier: "audioStoryIdentifer") as! AudioPlayViewCntr
//            audioCntr.audioLink = sender.accessibilityLabel!
//            audioCntr.packhanMessage = "no message"
//            audioCntr.titleString = "Jain Mantras"
//            self.navigationController?.pushViewController(audioCntr, animated: true)
//
//        }
    }
    
    func getGuruData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang="+GlobalVariables.selectedLanguage
        let url = URL(string:ServerUrl.get_jainmantra)!
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
                    let jobData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        let groupName = jsonObject?.object(forKey: "mantra_type") as! String

                        if(self.sections.contains(groupName)){
                            if let ifIndex = self.sections.index(of: groupName) {
                                    var subgroupDa = [String]()
                                    for var y in 0..<self.items[ifIndex].count {
                                       subgroupDa.append(self.items[ifIndex][y])
                                    }
                                let sub_group_data = jsonObject?.object(forKey: "title") as? String
                                let desc = jsonObject?.object(forKey: "description") as? String
                                let description = desc?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                                let importance = jsonObject?.object(forKey: "importance") as? String
                                let labh = jsonObject?.object(forKey: "labh") as? String
                                let vidhi = jsonObject?.object(forKey: "vidhi") as? String
                                let audio = jsonObject?.object(forKey: "audio") as? String
                              
                                let finalData = "\(sub_group_data!)\("::"+importance!)\("::"+labh!)\("::"+vidhi!)\("::"+description!)\("::"+audio!)"
                                    self.items[ifIndex].append(finalData)

                            }else{
                                
                            }
                        }else{

                            self.sections.append(groupName)
                            var subgroupDa = [String]()
                            let sub_group_data = jsonObject?.object(forKey: "title") as? String
                            let desc = jsonObject?.object(forKey: "description") as? String
                            let description = desc?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                            let importance = jsonObject?.object(forKey: "importance") as? String
                            let labh = jsonObject?.object(forKey: "labh") as? String
                            let vidhi = jsonObject?.object(forKey: "vidhi") as? String
                            let audio = jsonObject?.object(forKey: "audio") as? String
                            
                           
                           let finalData = "\(sub_group_data!)\("::"+importance!)\("::"+labh!)\("::"+vidhi!)\("::"+description!)\("::"+audio!)"
                            
                            subgroupDa.append(finalData)
                            self.items.append(subgroupDa)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.pachkanTableView.reloadData()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
