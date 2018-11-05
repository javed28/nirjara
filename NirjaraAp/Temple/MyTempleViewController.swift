//
//  MyTempleViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyTempleViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    
    var templeData : NSMutableArray = NSMutableArray()
//    var TempleName = ["Shree Vasupujay","Shree Suprashwan","Shree Porwal Jain","Shre Sumtinath","Shree Vasupujay","Shree Suprashwan","Shree Porwal Jain","Shre Sumtinath"]
//    var TempleImage = ["default-icon","default-icon","default-icon","default-icon","default-icon","default-icon","default-icon","default-icon"]
//    var TempleAddress = ["3B Malwanu Mlad(w)","B Mumbai Kandivali(w)","B Malwanu Mlad(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)","B Mumbai Kandivali(w)"]
//    var TempleDistance = ["4Km","5Km","12Km","20Km","25Km","40Km","100Km","500Km"]

    @IBOutlet weak var myTempleCollectionView: UICollectionView!
    
    @IBOutlet weak var lblNoRecord: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  My Temple's"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:5))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:5,length:8))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        templeData.removeAllObjects()
        getMyTempleData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  let padding: CGFloat =  10
       // let collectionViewSize = myTempleCollectionView.frame.size.width - padding
        
        return CGSize(width: self.view.frame.width/2-15, height: 205)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return templeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myTempleCollectionView.dequeueReusableCell(withReuseIdentifier: "myTempleIdetifier", for: indexPath) as? MyTempleCollViewCell
        
        cell?.mainView.frame = CGRect(x:0,y:5,width:self.myTempleCollectionView.frame.width/2,height:200)
        var templeDate = templeData[indexPath.row] as? templeSthanakModel
        
        cell?.lblTempleName.text = templeDate?.temple_name
       
        
        if(templeDate?.temple_photo == nil || templeDate?.temple_photo == ""){

            let placeholderImage = UIImage(named: "default-icon")!
            
            cell?.imgTemple.image = placeholderImage
        }else{
            //let imageView = UIImageView()
            let url = URL(string:(templeDate?.temple_photo)!)
            let placeholderImage = UIImage(named: "default-icon")!
            
            cell?.imgTemple.af_setImage(withURL: url!, placeholderImage: placeholderImage)
//            if(templeDate?.temple_photo == ""){
//                let placeholderImage = UIImage(named: "default-icon")!
//
//                cell?.imgTemple.image = placeholderImage
//            }else{
//
//            cell?.imgTemple.af_setImage(
//                withURL:  URL(string: (templeDate?.temple_photo)!)!,
//                placeholderImage: UIImage(named: "default-icon"),
//                filter: nil,
//                imageTransition: UIImageView.ImageTransition.crossDissolve(0.5),
//                runImageTransitionIfCached: false) {
//                    // Completion closure
//                    response in
//                    // Check if the image isn't already cached
//                    if response.response != nil {
//
////                        self.myTempleCollectionView
////                        self.myTempleCollectionView.endUpdates()
//                    }
//            }
//            }
        }
        
        
        
        cell?.imgTemple.frame = CGRect(x:1,y:0,width:((cell?.mainView.frame.width)!-2),height:80)
        cell?.lineView.frame = CGRect(x:1,y:144,width:((cell?.mainView.frame.width)!-2),height:0.2)
        cell?.lineView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)

       
        cell?.lblTempleName?.frame = CGRect(x:15,y:(cell?.imgTemple.frame.height)!+(cell?.imgTemple.frame.origin.y)!,width:(cell?.mainView.frame.width)!-30,height:28)
        cell?.lblTempleDistance?.frame = CGRect(x:15,y:(cell?.lblTempleName.frame.height)!+(cell?.lblTempleName.frame.origin.y)!,width:(cell?.mainView.frame.width)!,height:28)
       // cell?.lblTempleAddress?.frame = CGRect(x:15,y:(cell?.imgTemple.frame.height)!+(cell?.imgTemple.frame.origin.y)!,width:(cell?.mainView.frame.width)!/2-30,height:28)
        
        cell?.locationIcon.frame = CGRect(x:15,y:(cell?.lblTempleDistance.frame.height)!+(cell?.lblTempleDistance.frame.origin.y)!+3,width:12,height:15)
        cell?.lblTempleAddress.text = templeDate?.location
        //var greet4Height = cell?.lblTempleAddress.optimalHeight
        cell?.lblTempleAddress.frame = CGRect(x:30,y:(cell?.lblTempleDistance.frame.height)!+(cell?.lblTempleDistance.frame.origin.y)!,width:(cell?.mainView.frame.width)!-60,height:25)
        
        //cell?.lblTempleAddress.setFAText(prefixText: "", icon: .FAAddressBook, postfixText: " "+(templeDate?.location)!, size: 15)
        if(templeDate?.distance == nil){
            cell?.lblTempleDistance.setFAText(prefixText: "", icon: .FALocationArrow, postfixText: " "+("Not Specified"), size: 15)
        }else{
            cell?.lblTempleDistance.setFAText(prefixText: "", icon: .FALocationArrow, postfixText: " "+(templeDate?.distance)!, size: 15)
        }
        
        
        
        cell?.imgFood.frame = CGRect(x:15,y:(cell?.lblTempleAddress.frame.origin.y)!+(cell?.lblTempleAddress.frame.height)!+7,width:27,height:27)
        cell?.imgStay.frame = CGRect(x:52,y:(cell?.lblTempleAddress.frame.origin.y)!+(cell?.lblTempleAddress.frame.height)!+7,width:27,height:27)
        
        if(templeDate?.food_available == "No"){
            cell?.imgFood.alpha = 0
        }else{
            cell?.imgFood.alpha = 1
        }
        
        if(templeDate?.stay_available == "No"){
            cell?.imgStay.alpha = 0
        }else{
            cell?.imgStay.alpha = 1
        }
        
        
        cell?.mainView.addSubview((cell?.imgTemple)!)
        cell?.mainView.addSubview((cell?.lineView)!)
        cell?.mainView.addSubview((cell?.lblTempleName)!)
        cell?.mainView.addSubview((cell?.imgTemple)!)
        cell?.mainView.addSubview((cell?.imgFood)!)
        cell?.mainView.addSubview((cell?.lblTempleDistance)!)
        cell?.mainView.addSubview((cell?.lblTempleAddress)!)
        cell?.mainView.dropShadow(color: UIColor.rgb(hexcolor: "#C8C8C8"), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        return cell!
    }
    
    func getMyTempleData(){
        //location=Mumbai&lang=en&member_id=178
       // let parameters = "location=Mumbai&lang="+GlobalVariables.selectedLanguage+"&member_id="+(UserDefaults.standard.getUserID())
        let parameters = "location=\(GlobalVariables.TempleState)&lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.my_temple_list)!
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
                        var templeMModel = templeSthanakModel()
                        
                        templeMModel.temple_id = jsonObject?.object(forKey: "temple_id") as? String
                        templeMModel.temple_name = jsonObject?.object(forKey: "temple_name") as? String
                        templeMModel.temple_info = jsonObject?.object(forKey: "temple_info") as? String
                        templeMModel.member_id = jsonObject?.object(forKey: "member_id") as? String
                        templeMModel.location = jsonObject?.object(forKey: "location") as? String
                        templeMModel.distance = jsonObject?.object(forKey: "distance") as? String
                        templeMModel.food_available = jsonObject?.object(forKey: "food_available") as? String
                        templeMModel.stay_available = jsonObject?.object(forKey: "stay_available") as? String
                        templeMModel.temple_photo = jsonObject?.object(forKey: "temple_photo") as? String
                        
                        self.templeData.add(templeMModel)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 0
                        self.myTempleCollectionView.alpha = 1
                        self.myTempleCollectionView.reloadData()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.lblNoRecord.alpha = 1
                        self.myTempleCollectionView.alpha = 0
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
