//
//  EventsCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/5/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import AlamofireImage

class EventsCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lblNoRecord: UILabel!
    private let kCellheaderReuse : String = "SectionHeader"
    @IBOutlet weak var evetsTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var eventsData : NSMutableArray = NSMutableArray()
    
    
//    var eventsName = ["testing1","testing2"]
//    var eventsConatctPerson = ["Hello 123","Hi 123"]
//    var eventsFrom = ["07 march 2018","07 march 2019"]
//    var eventsTo = ["07 march 2018 - 14:38 AM","07 march 2018 - 14:38 AM"]
//    var eventsVenue = ["MUMBAI","RAJSTHAN"]
    
    var titleNote : String = "जैन समाज के होने वाले महोत्सवो को यहां देखे और अगर आप के शहर मे कोई जैन मोहत्सव ( EVENT) होने वाला है तो यहां ADD करे और समस्त जैन समाज को उस मोहत्सव का लाभ उठाने का निमंत्रण दे."
    var note_color : String = "#1b0262"
    var note_font_color : String = "#fbfb00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Jain Events"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:7,length:6))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        sideMenu()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if(isConnectedToNetwork()){
        eventsData.removeAllObjects()
        evetsTableView.reloadData()
        self.lblNoRecord.alpha = 1
        getEventsData()
        }else{
            
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventsData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let evntsDetails = storyboard?.instantiateViewController(withIdentifier: "detailsEventsIdentifier") as! EventsDetailsViewController
        evntsDetails.eventsData = eventsData[indexPath.row] as! eventsModel
        self.navigationController?.pushViewController(evntsDetails, animated:true)
        
        //self.performSegue(withIdentifier: "detailsIdentifier", sender: self)
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = evetsTableView.dequeueReusableCell(withIdentifier: "eventHeaderIdentifier") as! EventHeaderTableViewCell
       
        headerView.mainBackGround.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:75)
        headerView.lblHeaderText.text = self.titleNote

        let greet4Height = headerView.lblHeaderText.optimalHeight
        headerView.lblHeaderText.frame = CGRect(x:10,y:headerView.mainBackGround.frame.origin.y-15,width:headerView.mainBackGround.frame.width-20,height:greet4Height)
//        headerView.lblHeaderText.lineBreakMode = .byWordWrapping
//        headerView.lblHeaderText.numberOfLines = 0
       // headerView.lblHeaderText.textColor = UIColor.rgb(hexcolor: "#fafb00")
        headerView.mainBackGround.backgroundColor = UIColor.rgb(hexcolor: note_color)
        headerView.lblHeaderText.textColor = UIColor.rgb(hexcolor: note_font_color)
        headerView.mainBackGround.addSubview(headerView.lblHeaderText)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = evetsTableView.dequeueReusableCell(withIdentifier: "eventsIdentifier", for: indexPath) as! ShowEventsTableViewCell
        
        let eventsData = self.eventsData[indexPath.row] as? eventsModel
        
        cell.selectionStyle = .none
         cell.lblEventsName?.text = eventsData?.event_title
        
        let normalText = eventsData?.contact_person
        let boldText  = "ContactPersonName".localized1+" : "
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        var boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        let attributedString = NSMutableAttributedString(string:normalText!)
        boldString.append(attributedString)
        cell.lblContactName?.attributedText = boldString
        
        
        let From = eventsData?.event_from
        let FromText  = "From".localized1+" : "
        let attrsFrom = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        var boldStringFrom = NSMutableAttributedString(string: FromText, attributes:attrsFrom)
        let attributedStringFrom = NSMutableAttributedString(string:From!)
        boldStringFrom.append(attributedStringFrom)
        cell.lblEventsFrom?.attributedText = boldStringFrom
        
        let To = eventsData?.event_to
        let boldTextTo  = "To".localized1+" : "
        let attrsTo = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        var boldStringTo = NSMutableAttributedString(string: boldTextTo, attributes:attrsTo)
        let attributedStringTo = NSMutableAttributedString(string:To!)
        boldStringTo.append(attributedStringTo)
        cell.lblEventsTo?.attributedText = boldStringTo
        
        let normalTextVenue = eventsData?.event_venue
        let boldTextVenue  = "Venue".localized1+" : "
        let attrsVenue = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        var boldStringVenue = NSMutableAttributedString(string: boldTextVenue, attributes:attrsVenue)
        let attributedStringVenue = NSMutableAttributedString(string:normalTextVenue!)
        boldStringVenue.append(attributedStringVenue)
        cell.lblEventsVenue?.attributedText = boldStringVenue
        
        

        
       // let imageView = UIImageView()
        let url = URL(string:(eventsData?.event_photo1_large)!)
        let placeholderImage = UIImage(named: "default-icon")!
        
        if(url == nil || eventsData?.event_photo1_large == ""){
              cell.imgEvents.image = placeholderImage
        }else{
            
            let imageView = UIImageView(frame: CGRect(x:10,y:15,width:110,height:110))
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: imageView.frame.size,radius: 20.0)
            cell.imgEvents.af_setImage(withURL: url!,placeholderImage: placeholderImage,filter: filter)
            
        }
        
        
        
        
        
       // cell.imgEvents.frame=CGRect(x:10,y:15,width:110,height:110)
        cell.lblEventsName.frame=CGRect(x:135,y:15,width:self.view.frame.width-135,height:20)
        cell.lblContactName.frame=CGRect(x:135,y:35,width:self.view.frame.width-135,height:20)
        cell.lblEventsFrom.frame=CGRect(x:135,y:55,width:self.view.frame.width-135,height:20)
        cell.lblEventsTo.frame=CGRect(x:135,y:75,width:self.view.frame.width-135,height:20)
        cell.lblEventsVenue.frame=CGRect(x:135,y:95,width:self.view.frame.width-135,height:20)
        
        
        return cell
    }
    
    func getEventsData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang="+GlobalVariables.selectedLanguage
        let url = URL(string:ServerUrl.get_event)!
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
                    
                    self.titleNote = (json?.object(forKey: "note") as? String)!
                    self.note_color = (json?.object(forKey: "note_color") as? String)!
                    self.note_font_color = (json?.object(forKey: "note_font_color") as? String)!
                    for i in 0..<jobData!.count{
                        let jsonObject = jobData?[i]
                        var eventMModel = eventsModel()
                        
                        eventMModel.events_id = jsonObject?.object(forKey: "events_id") as? String
                        eventMModel.event_title = jsonObject?.object(forKey: "event_title") as? String
                        eventMModel.event_from = jsonObject?.object(forKey: "event_from") as? String
                        eventMModel.contact_person = jsonObject?.object(forKey: "contact_person") as? String
                        eventMModel.event_to = jsonObject?.object(forKey: "event_to") as? String
                        eventMModel.event_venue = jsonObject?.object(forKey: "event_venue") as? String
                       
                        eventMModel.event_organizer = jsonObject?.object(forKey: "event_organizer") as? String
                        eventMModel.contact = jsonObject?.object(forKey: "contact") as? String
                        
                         eventMModel.event_photo1_large = jsonObject?.object(forKey: "event_photo1_large") as? String
                         eventMModel.event_photo1_small = jsonObject?.object(forKey: "event_photo1_small") as? String
                         eventMModel.event_photo2_large = jsonObject?.object(forKey: "event_photo2_large") as? String
                         eventMModel.event_photo2_small = jsonObject?.object(forKey: "event_photo2_small") as? String
                         eventMModel.event_photo3_large = jsonObject?.object(forKey: "event_photo3_large") as? String
                         eventMModel.event_photo3_small = jsonObject?.object(forKey: "event_photo3_small") as? String
                        
                        
                        let string = jsonObject?.object(forKey: "event_description") as? String
                        let str = string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        eventMModel.event_description = str
                        
                        self.eventsData.add(eventMModel)
                        
                    }
                    DispatchQueue.main.async {
                        self.lblNoRecord.alpha = 0
                        self.hideActivityIndicator()
                        self.evetsTableView.reloadData()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.lblNoRecord.alpha = 1
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



