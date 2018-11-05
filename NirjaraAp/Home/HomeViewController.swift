//
//  HomeViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/26/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage
import CoreLocation
import AlamofireImage
import JHTAlertController

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lng = CLLocationDegrees()
    @IBOutlet weak var btnSeeMoreFollower: UIButton!
    @IBOutlet weak var btnSeeMorePopulation: UIButton!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
  
//    var CategoryArray = ["Jain Guru Tracking","Vihar Stay","Temple and Sthanak","Tapasvi Sukh Satha","Vrath Pachchakan","Jain Mantras","Jain Events","Active for Samaj Seva","Chaturmas 2018","Jain Library","Donation"]
//
//
//      var CategoryImage = ["d1","d2","d3","d4","d5","d6","d10","d11","d12","d8","d7"]

    var CategoryArray = ["Vihar Stay","Temple and Sthanak","Tapasvi Sukh Satha","Jain Events","Vrath Pachchakan","Jain Mantras","Jain Guru Tracking","Active for Samaj Seva","Chaturmas 2018","Jain Library","Donation"]
   
    var CategoryArrayHindi = ["विहार स्थान","मंदिर और स्थानक","तपस्वी सुख साता","जैन महोत्सव","व्रत पच्चक्खाण","जैन मंत्र","जैन गुरू ट्रैकिंग","समाज सेवा के लिए सक्रिय","चातुर्मास 2018","जैन ग्रंथालय","दान"]
   
    var CategoryArrayGujarathi = ["વિહાર સ્થળ","મંદિરો સ્ટાનિક","તપસ્વિ સુખ સાતા","જૈન મોહોત્સવ","વ્રત પંચકણ","જૈન મંત્ર","જૈન ગુરુ ટ્રેકિંગ","સમાજ સેવા માટે સક્રિય","ચેટશુમ 2018","જૈન લાઇબ્રેરી","દાન"]
    
    
    var CategoryImage = ["d2","d3","d4","d10","d5","d6","d1","d11","d12","d8","d7"]
    
    var GalleryImage = ["gallery2","gallery3","gallery1"]
     var tempGalleryImage = ["gallery2","gallery3","gallery1"]
    
    private let kCellheaderReuse : String = "galleryFooterIdentifier"
    private let jainYellowfooterReuse : String = "jainYellowFooterIdentifier"
    
    
    @IBOutlet weak var topUiView: UIView!
    @IBOutlet weak var lblKaramDwar: UILabel!
    
   
    @IBOutlet weak var lblGallery: UILabel!
    
    
    @IBOutlet weak var jainBussinessCollection: UICollectionView!
    
    @IBOutlet weak var lblJainYellowPage: UILabel!
    @IBOutlet weak var btnPin1: UIButton!
    
    
    @IBOutlet weak var addsSlideShow: ImageSlideshow!
    
    
    @IBOutlet weak var lblNewPurchase: UILabel!
    @IBOutlet weak var btnPin2: UIButton!
    
    @IBOutlet weak var newPurchaseCollection: UICollectionView!
    @IBOutlet weak var lblFollowersGraph: UILabel!
    
    @IBOutlet weak var lblJobAvailable: UILabel!
    @IBOutlet weak var lblJobSeeker: UILabel!
   
   
    @IBOutlet weak var bottomAddSlideShow: ImageSlideshow!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var btnJobAvailable: UIButton!
    @IBOutlet weak var btnJobseeker: UIButton!
    @IBOutlet weak var lblJainPopulation: UILabel!
    
    @IBOutlet weak var followerGraphView: UIView!
    
    @IBOutlet weak var followerGraphWebview: UIWebView!
    @IBOutlet weak var viewPopulationGraph: UIView!
    
    @IBOutlet weak var populationWebview: UIWebView!
    @IBOutlet weak var viewGame: UIView!
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var gamePicker: UIPickerView!
    @IBOutlet weak var btnGameStart: UIButton!
    @IBOutlet weak var btnGameResult: UIButton!
    @IBOutlet weak var lblAajkeniyam: UILabel!
   
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainView: UIView!
    var indexpathofCatgeory = Int()
   // var businessImage = ["hardware","jewellers","manufacture","mobile","paint","electric","finance","property","school","cosmetic"]
    //var businessText = ["Hardware","  Jewellers","Manufacture","    Mobile","    Paint","   Electric","  Finance","   Property","   School","  Cosmetic"]
    
    var newPurchaseImage = ["international_Holiday","car","p3","mobile-1","ipad","jewellary"]
    var newPurchaseText = ["International Holiday","    Cars","Special Offers","   Mobile","    Ipad","Jewellery"]
     var newPurchaseTextHindi = ["अंतरराष्ट्रीय छुट्टी","    कार","खास पेशकश","   मोबाइल","    आईपैड","आभूषण"]
     var newPurchaseTextGujarathi = ["આંતરરાષ્ટ્રીય રજા","    કાર","ખાસ ઑફર્સ","   મોબાઇલ","    આઇપેડ","જ્વેલરી"]
     var containerController: ContainerViewController?
    
     var btmbanServerData : NSMutableArray = NSMutableArray()
     var globalbanServerData : NSMutableArray = NSMutableArray()
   // var GalleryFullDetail : NSMutableArray = NSMutableArray()
    var businessFullDetail : NSMutableArray = NSMutableArray()
    var counterData = [String]()

    @IBOutlet weak var lblGuruTracking: UILabel!
    @IBOutlet weak var switchGruTracking: UISwitch!
    
    
    @IBOutlet weak var adhithanaView: UIView!
    @IBOutlet weak var lblAdhithana: UILabel!
    @IBOutlet weak var txtAdhithana: UITextField!
    @IBOutlet weak var btnAdhithana: UIButton!
    
    
    @IBOutlet weak var heightOfHomeView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title =  "Nirjara Ap"
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(hexcolor: GlobalVariables.titleColor)]
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "titleofApp".localized1 as NSString
        //var myString:NSString = "  Nirjara Ap"
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:10))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:10,length:2))
        
        titleLabel.attributedText = myMutableString

       // titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
       // UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Points".localized1, style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(hexcolor: "#FF9800")
        menuCollectionView.delegate = self
        containerController = revealViewController().frontViewController as? ContainerViewController
        
        //self.addShadowToBar()
        
        if isConnectedToNetwork() {
            
            if(GlobalVariables.cityName.count > 0){
                
            }else{
               getCity()
            }
            if(GlobalVariables.stateId.count > 0){
            }else{
                getState()
            }
            globalbanServerData.removeAllObjects()
            getGlobalAddAdvertiseMent()
        
            let url = URL (string: ServerUrl.get_population_graph)
            let requestObj = URLRequest(url: url!)
            populationWebview.loadRequest(requestObj)
            
            let followerUrl = URL (string: ServerUrl.get_followers_graph)
            let followerRequestObj = URLRequest(url: followerUrl!)
            followerGraphWebview.loadRequest(followerRequestObj)
            getFullScreenAds()
        }else{
            
        }
        
        
        
        
        topUiView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:50)
        lblKaramDwar.frame = CGRect(x:0,y:0,width:self.topUiView.frame.width,height:50)
        topUiView.addSubview(lblKaramDwar)
        menuCollectionView.frame = CGRect(x:0,y:50,width:self.view.frame.width,height:100)
        
        
        //lblKaramDwar.text = NSLocalizedString("titleofApp".localized, comment: "Title of App")
        lblKaramDwar.text = NSLocalizedString("Karma".localized(lang:UserDefaults.standard.getLanguage()), comment: "Title of App")
        
        if(UserDefaults.standard.getMemberType() == "guru" || UserDefaults.standard.getMemberType() == "Guru"){
            lblGuruTracking.alpha = 1
            lblGuruTracking.text = "GuruTracking".localized1
            switchGruTracking.alpha = 1
           adhithanaView.alpha = 1
            lblGuruTracking.frame = CGRect(x:10,y:menuCollectionView.frame.origin.y+menuCollectionView.frame.height+5,width:self.topUiView.frame.width,height:40)
            switchGruTracking.frame = CGRect(x:self.topUiView.frame.width-60,y:menuCollectionView.frame.origin.y+menuCollectionView.frame.height+10,width:40,height:40)
            switchGruTracking.tintColor = UIColor.red
            switchGruTracking.addTarget(self, action: #selector(ChangeSwicthValue(_:)), for: UIControlEvents.valueChanged)
            
            adhithanaView.frame = CGRect(x:0,y:switchGruTracking.frame.origin.y+switchGruTracking.frame.height+10,width:self.view.frame.width,height:70)
            lblAdhithana.text = "Adithana".localized1
            txtAdhithana.placeholder = "Adithana".localized1
            lblAdhithana.frame = CGRect(x:10,y:10,width:lblAdhithana.intrinsicContentSize.width+10,height:50)
            txtAdhithana.text = UserDefaults.standard.getAdhithana()
            txtAdhithana.frame = CGRect(x:lblAdhithana.intrinsicContentSize.width+20,y:10,width:self.adhithanaView.frame.width-180,height:50)
            
            btnAdhithana.frame = CGRect(x:self.adhithanaView.frame.width-80,y:10,width:60,height:50)
            btnAdhithana.setTitle("Submit".localized1, for: .normal)
            
            btnAdhithana.addTarget(self, action: #selector(updateAdhithana(_:)), for: UIControlEvents.touchUpInside)
            
            adhithanaView.addSubview(lblAdhithana)
            adhithanaView.addSubview(txtAdhithana)
            adhithanaView.addSubview(btnAdhithana)
            
            
            
            lblGallery.frame = CGRect(x:0,y:adhithanaView.frame.origin.y+adhithanaView.frame.height-5,width:self.topUiView.frame.width,height:40)
       
        
            mainViewHeight.constant = 2170
            mainView.layoutIfNeeded()
        }else{
            adhithanaView.alpha = 0
            lblGuruTracking.alpha = 0
            switchGruTracking.alpha = 0
           
            lblGallery.frame = CGRect(x:0,y:menuCollectionView.frame.origin.y+menuCollectionView.frame.height-3,width:self.topUiView.frame.width,height:40)
        }
        
        btnAddImage.addTarget(self, action: #selector(HomeViewController.gotoAddImage), for: UIControlEvents.touchUpInside)
        
      //  addsSlideShow.frame = CGRect(x:10,y:viewGame.frame.origin.y+viewGame.frame.height+10,width:self.view.frame.width-20,height:205)
     
        
        galleryCollectionView.frame = CGRect(x:5,y:lblGallery.frame.origin.y+lblGallery.frame.height,width:self.view.frame.width,height:100)
        
        btnAddImage.frame = CGRect(x:0,y:galleryCollectionView.frame.origin.y+galleryCollectionView.frame.height,width:self.view.frame.width,height:30)
        
        lblJainYellowPage.frame = CGRect(x:0,y:btnAddImage.frame.origin.y+btnAddImage.frame.height+5,width:self.view.frame.width,height:35)
        
        btnPin1.frame = CGRect(x:self.view.frame.width-20,y:btnAddImage.frame.origin.y+btnAddImage.frame.height+5,width:20,height:20)
        
        btnPin1.addTarget(self, action: #selector(SecondPinClicked), for: UIControlEvents.touchUpInside)
        btnPin2.addTarget(self, action: #selector(firstPinClicked), for: UIControlEvents.touchUpInside)
        
        jainBussinessCollection.frame = CGRect(x:0,y:lblJainYellowPage.frame.origin.y+lblJainYellowPage.frame.height+10,width:self.view.frame.width,height:90)
        
        addsSlideShow.frame = CGRect(x:0,y:jainBussinessCollection.frame.origin.y+jainBussinessCollection.frame.height+10,width:self.view.frame.width,height:170)
        
        addsSlideShow.dropShadow(color: UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor), opacity: 1, offSet: CGSize(width: -2.5, height: 2.5), radius: 4.5, scale: true)
     
        lblNewPurchase.frame = CGRect(x:0,y:addsSlideShow.frame.origin.y+addsSlideShow.frame.height+10,width:self.view.frame.width,height:35)
        btnPin2.frame = CGRect(x:self.view.frame.width-20,y:addsSlideShow.frame.origin.y+addsSlideShow.frame.height+10,width:20,height:20)
        
        newPurchaseCollection.frame = CGRect(x:0,y:lblNewPurchase.frame.origin.y+lblNewPurchase.frame.height+10,width:self.view.frame.width,height:90)
        
        lblFollowersGraph.frame = CGRect(x:0,y:newPurchaseCollection.frame.origin.y+newPurchaseCollection.frame.height+8,width:self.view.frame.width,height:25)
        
         followerGraphView.frame = CGRect(x:0,y:lblFollowersGraph.frame.origin.y+lblFollowersGraph.frame.height+12,width:self.view.frame.width,height:170)
        followerGraphWebview.frame = CGRect(x:0,y:0,width:followerGraphView.frame.width,height:followerGraphView.frame.height)

        self.followerGraphWebview.scrollView.isScrollEnabled = false
        
        followerGraphView.addSubview(followerGraphWebview)
        
        btnSeeMoreFollower.frame = CGRect(x:self.view.frame.width-100,y:followerGraphView.frame.origin.y+followerGraphView.frame.height,width:90,height:30)
        

        
        lblJobSeeker.frame = CGRect(x:0,y:btnSeeMoreFollower.frame.origin.y+btnSeeMoreFollower.frame.height+8,width:self.view.frame.width,height:30)
    
        lblJobAvailable.frame = CGRect(x:self.view.frame.width/2+10,y:btnSeeMoreFollower.frame.origin.y+btnSeeMoreFollower.frame.height,width:self.view.frame.width/2-10,height:45)
        lblJobAvailable.alpha = 0
        
        btnJobseeker.frame = CGRect(x:10,y:lblJobSeeker.frame.origin.y+lblJobSeeker.frame.height+10,width:self.view.frame.width/2-15,height:120)
        
        btnJobAvailable.frame = CGRect(x:self.view.frame.width/2+5,y:lblJobSeeker.frame.origin.y+lblJobSeeker.frame.height+10,width:self.view.frame.width/2-15,height:120)
       
        lblJainPopulation.frame = CGRect(x:0,y:btnJobseeker.frame.origin.y+btnJobseeker.frame.height+8,width:self.view.frame.width,height:25)
        
        viewPopulationGraph.frame = CGRect(x:0,y:lblJainPopulation.frame.origin.y+lblJainPopulation.frame.height+12,width:self.view.frame.width,height:170)
        populationWebview.frame = CGRect(x:0,y:0,width:viewPopulationGraph.frame.width,height:viewPopulationGraph.frame.height)
        self.populationWebview.scrollView.isScrollEnabled = false
        self.viewPopulationGraph.addSubview(populationWebview)
        
        btnSeeMorePopulation.frame = CGRect(x:self.view.frame.width-100,y:viewPopulationGraph.frame.origin.y+viewPopulationGraph.frame.height-10,width:90,height:30)
        
        lblNote.frame = CGRect(x:0,y:btnSeeMorePopulation.frame.origin.y+btnSeeMorePopulation.frame.height+5,width:self.view.frame.width,height:60)
      
        bottomAddSlideShow.frame = CGRect(x:0,y:lblNote.frame.origin.y+lblNote.frame.height+10,width:self.view.frame.width,height:170)
        
        lblAajkeniyam.frame = CGRect(x:0,y:bottomAddSlideShow.frame.origin.y+bottomAddSlideShow.frame.height+10,width:self.view.frame.width,height:30)
        lblAajkeniyam.alpha = 0
        viewGame.alpha = 0
        
        viewGame.frame = CGRect(x:10,y:lblAajkeniyam.frame.origin.y+lblAajkeniyam.frame.height+10,width:self.view.frame.width-20,height:70)
        
        let widthofCell : CGFloat = self.viewGame.frame.width/3
        
        
        btnGameStart.frame = CGRect(x:0,y:10,width:widthofCell,height:50)
        gamePicker.frame = CGRect(x:widthofCell,y:0,width:widthofCell,height:70)
        btnGameResult.frame = CGRect(x:widthofCell * 2,y:10,width:widthofCell,height:50)
        
        
        viewGame.addSubview(btnGameStart)
        viewGame.addSubview(gamePicker)
        viewGame.addSubview(btnGameResult)
        
        btnFacebook.frame = CGRect(x:10,y:bottomAddSlideShow.frame.origin.y+bottomAddSlideShow.frame.height+10,width:self.view.frame.width/2-10,height:50)
        btnInstagram.frame = CGRect(x:self.view.frame.width/2+10,y:bottomAddSlideShow.frame.origin.y+bottomAddSlideShow.frame.height+10,width:self.view.frame.width/2-20,height:50)
        
        
//        btnFacebook.setFAText(prefixText: "", icon: .FAFacebook, postfixText: "   Follow", size: 18, forState: .normal)
//        btnInstagram.setFAText(prefixText: "", icon: .FAInstagram, postfixText: "   Follow", size: 18, forState: .normal)
//        btnFacebook.setFATitleColor(color: UIColor.rgb(hexcolor: "FF9800"), forState: .normal)
//        btnInstagram.setFATitleColor(color: UIColor.rgb(hexcolor: "FF9800"), forState: .normal)
       
        let buttonString = String.fontAwesomeString(name: "fa-facebook") + "  Follow on Facebook"
        let buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16.00)!])
        buttonStringAttributed.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 16), range: NSRange(location: 0,length: 1))
        buttonStringAttributed.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location: 0,length: 1))
        btnFacebook.titleLabel?.textAlignment = .center
        btnFacebook.titleLabel?.textColor = UIColor.white
        btnFacebook.setAttributedTitle(buttonStringAttributed, for: .normal)
        
        
        
        let buttonString1 = String.fontAwesomeString(name: "fa-instagram") + "  Follow on Instagram"
        let buttonStringAttributed1 = NSMutableAttributedString(string: buttonString1, attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue", size: 16.00)!])
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.font, value: UIFont.iconFontOfSize(font: "FontAwesome", fontSize: 16), range: NSRange(location: 0,length: 1))
        
        buttonStringAttributed1.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.rgb(hexcolor: "FF9800"),range: NSRange(location:0,length: 1))
        
        btnInstagram.titleLabel?.textAlignment = .center
        btnInstagram.titleLabel?.textColor = UIColor.white
        btnInstagram.setAttributedTitle(buttonStringAttributed1, for: .normal)
        
        
        //btnFacebook.addTarget(self, action: #selector(self.gotoAddPage), for: UIControlEvents.touchUpInside)

//        let followerGraphViewTab = UITapGestureRecognizer(target: self, action:  #selector(goToFollower))
//        //followerGraphViewTab.numberOfTapsRequired = 1
//        self.followerGraphView.addGestureRecognizer(followerGraphViewTab)

        btnFacebook.addTarget(self, action: #selector(gotoFacebook), for: UIControlEvents.touchUpInside)
        btnInstagram.addTarget(self, action: #selector(gotoInstagram), for: UIControlEvents.touchUpInside)
        let populationGraphViewTab = UITapGestureRecognizer(target: self, action:  #selector(goToPopulation))
        populationGraphViewTab.numberOfTapsRequired = 1
        self.btnSeeMorePopulation.addGestureRecognizer(populationGraphViewTab)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToFollower))
        tapRecognizer.numberOfTapsRequired = 1
        self.btnSeeMoreFollower.addGestureRecognizer(tapRecognizer)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDate = formatter.string(from: date)
        GlobalVariables.selectedDate = currentDate
        GlobalVariables.selectedEventsDateFrom = currentDate
        GlobalVariables.selectedEventsDateTo = currentDate
        GlobalVariables.selectedHolidayDateFrom = currentDate
        GlobalVariables.selectedCarsFrom = currentDate
        GlobalVariables.selectedCarsTo = currentDate
        GlobalVariables.selectedMobileFrom = currentDate
        GlobalVariables.selectedMobileTo = currentDate
        GlobalVariables.selectedIpadFrom = currentDate
        GlobalVariables.selectedIpadTo = currentDate
        GlobalVariables.selectedJewerallyFrom = currentDate
        GlobalVariables.selectedJewerallyTo = currentDate
          /*for i in 0..<100{
            counterData.append(String(i))
        }*/
        
        businessFullDetail.removeAllObjects()
        getBusinessData()
        
        lblGallery.text = "Gallery".localized1
        lblJainYellowPage.text = "YellowPages".localized1
        btnAddImage.setTitle("Add".localized1+" "+"Image".localized1, for: .normal)
        lblNewPurchase.text = "Newpurchase".localized1
        lblFollowersGraph.text = "Followes".localized1+" "+"Graph".localized1
        lblJobSeeker.text = "AddJob".localized1
        lblJainPopulation.text = "PopulationGraph".localized1
        lblNote.text = "NotePopulation".localized1
        
        
        let timer = Timer.scheduledTimer(timeInterval: 310, target: self, selector: #selector(showFullScreen), userInfo: nil, repeats: true)
        
    }
    @objc func showFullScreen(){
        if(GlobalVariables.fullPageAdd.count > 0){
        var fullScreenImageUrl = GlobalVariables.fullPageAdd[0] as! bottomBanner
        var FullPageImageUrl = fullScreenImageUrl.adv_banner
        var FullPageImagetitle = fullScreenImageUrl.adv_title
        
            let alert = CustomAlert(title: FullPageImagetitle!, image: FullPageImageUrl!,addId: fullScreenImageUrl.advertisement_id,addUrl: fullScreenImageUrl.external_link)
        alert.show(animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136,1334,1920, 2208:
                
                 mainViewHeight.constant = bottomAddSlideShow.frame.origin.y+bottomAddSlideShow.frame.height+123
            case 2436:
                
                 mainViewHeight.constant = bottomAddSlideShow.frame.origin.y+bottomAddSlideShow.frame.height+143
            default:
                print("unknown")
            }
        }
    }
    
    
    @objc func ChangeSwicthValue(_ sender : UISwitch){
       
        if(sender.isOn){
            postWhichGuru(mod:"on")
        }else{
            postWhichGuru(mod:"off")
        }
    }
    
    func postWhichGuru(mod : String){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&trace_status=\(mod)"
        print("parameters---",parameters)
        let url = URL(string:ServerUrl.post_guru_on_off)!
        print("urllll---",url)
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
                print("respnones",json)
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    @objc func updateAdhithana(_ sender : UIButton){
        
        if(txtAdhithana.text == ""){
            self.view.makeToast("Add Adhithana", duration: 2.0, position: .top)
        }else{

        let parameters = "member_id=\(UserDefaults.standard.getUserID())&adhithana=\(txtAdhithana.text!)"
        print("parameters---",parameters)
        let url = URL(string:ServerUrl.update_adhithana)!
        print("urllll---",url)
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
                        self.hideActivityIndicator()
                        UserDefaults.standard.setAdhithana(value: self.txtAdhithana.text!)
                        
                        self.showAlert(title: "Success", message: "Adhithana Updated Successfully")
                        
                    }
                }
                    
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        
                        self.showAlert(title: "Error", message: "Something Went Wrong")
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        }
    }
    
    
    @objc func gotoInstagram(){
        var instagramHooks = "https://www.instagram.com/jain_nirjara_app/"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/jain_nirjara_app/")! as URL)
        }
    }
    @objc func gotoFacebook(){
        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/groups/236678763507808/")!
        var fbURLID: NSURL = NSURL(string: "fb://profile/236678763507808/")!
        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
            // FB installed
            UIApplication.shared.openURL(fbURLID as URL)
        } else {
            // FB is not installed, open in safari
            UIApplication.shared.openURL(fbURLWeb as URL)
        }
    }
    
    
    @objc func goToFollower(recognizer: UITapGestureRecognizer) {
        
        print("clicked Hereee====")
        self.performSegue(withIdentifier: "gotoJainFollIdentifier", sender: self)
    }
    
    @objc func goToPopulation(recognizer: UITapGestureRecognizer) {
        print("clicked Hereee====")
        self.performSegue(withIdentifier: "goToJainPopuIdentifier", sender: self)
    }
    
     @objc func firstPinClicked(){
       
        showAlert(title:"Hurry Up",message: "NewPurchaseNote".localized1)
  
    }
    @objc func SecondPinClicked(){
        showAlert(title: "Hurry Up",message: "hurryup".localized1)
    }
    
    @objc func gotoAddImage() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addImageStoryBoardId") as! ImageUploadCntr
        
        
        navigationController?.pushViewController(nextViewController, animated: true)
       // self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func btnStartGame(_ sender: Any) {
        
        gamePicker.selectRow(randomInt(min: 1,max: 200), inComponent: 0, animated:true)
       
    }
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    @objc func didTap() {
        print("descr---",addsSlideShow.currentPage)
       // addsSlideShow.presentFullScreenController(from: self)
        
        var AddsData = globalbanServerData[addsSlideShow.currentPage] as! bottomBanner
        
        updateHit(addId: AddsData.id)
        
        UIApplication.shared.open(URL(string : AddsData.external_link)!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @objc func gotoGallery() {
        //self.performSegue(withIdentifier: "showGalleryIdentifier", sender: self)
        let galleryView = storyboard?.instantiateViewController(withIdentifier: "GalleryNavigation") as! GalleryCntr
        //galleryView.galleryFullData = GalleryFullDetail
        navigationController?.pushViewController(galleryView, animated: true)
    }
    
    @objc func gotoJain(){
        let jianData = storyboard?.instantiateViewController(withIdentifier: "anotherJainCntr") as! anotherJainYelloViewController
        
        jianData.whichSearch = "See More"
        jianData.businessId = "0"
        navigationController?.pushViewController(jianData, animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return counterData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counterData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: counterData[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            return attributedString
    }
    
    @objc func addTapped(){
        
    }
    func loadLocation(){
        //GMSServices.provideAPIKey(GlobalVariables.GoogleMapsKey)
        
        let status  = CLLocationManager.authorizationStatus()
        
        // 2
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // 3
        if status == .denied || status == .restricted {
           
            let alertController = JHTAlertController(title: "Location Services Disabled", message:"In order to be notified, please open this app's settings and set location access to 'Always'.", preferredStyle: .alert)
            
            alertController.titleTextColor = .black
            alertController.titleFont = .systemFont(ofSize: 18)
            alertController.titleViewBackgroundColor = .white
            alertController.messageTextColor = .black
            alertController.alertBackgroundColor = .white
            alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
            let cancelAction = JHTAlertAction(title: "Cancel", style: .cancel,  handler: nil)
            alertController.addAction(cancelAction)
            let okAction = JHTAlertAction(title: "Settings", style: .destructive) { _ in
                
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        
        }
        else{
            print("Location service disabled");
        }
        
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locationManager.location != nil {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        lat = locValue.latitude
        lng = locValue.longitude
        locationManager.stopUpdatingLocation()
    
        let location = CLLocation(latitude: lat, longitude: lng) //changed!!!
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            //print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            print("how many Time---on home---")
            
            if let p0 = placemarks?.first
            {
                let p = CLPlacemark(placemark:p0)
                
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                        GlobalVariables.TempleState = pm.locality!
                        UserDefaults.standard.setLastAddress(value: pm.locality!)
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    GlobalVariables.currentAddres = addressString
                }
                self.updatePostion(lat: self.lat.description, lon: self.lng.description)
               /* if(GlobalVariables.currentLat == String(self.lat) && GlobalVariables.currentLong == String(self.lng)){
                    
                    if(GlobalVariables.locationUpdatedOneTime == true){
                        GlobalVariables.locationUpdatedOneTime = false
                    
                    GlobalVariables.currentLat = String(self.lat)
                    GlobalVariables.currentLong = String(self.lng)
                    }else{
                        
                    }
                }else{
                    GlobalVariables.locationUpdatedOneTime = false
                    self.updatePostion(lat: String(self.lat), lon: String(self.lng))
                    GlobalVariables.currentLat = String(self.lat)
                    GlobalVariables.currentLong = String(self.lng)
                }*/
                
                //self.adsresslabel.text = "\(p.administrativeArea)\(p.postalCode)\(p.country)"
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        }else{
            print("locationManager.location is nil")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location getting failed------"+error.localizedDescription)
    }
 
    func updateHit(addId : String){
        let parameters = "advertise_id=\(addId)"
        let url = URL(string:ServerUrl.post_hit_count)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
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
                
                GlobalVariables.locationUpdatedOneTime = false
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getTrackStatus(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_guru_track_status)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                    
                        let jsonObject = recommendData?[0]
                    
                        let trace_status = jsonObject?.object(forKey: "trace_status") as? String
                        let adithana = jsonObject?.object(forKey: "adithana") as? String
                    DispatchQueue.main.async {
                        UserDefaults.standard.setAdhithana(value: adithana!)
                        self.txtAdhithana.text = adithana
                        if(trace_status == "ON" || trace_status == "on"){
                            self.switchGruTracking.setOn(true, animated: true)
                            
                        }else{
                            self.switchGruTracking.setOn(false, animated: true)
                            
                        }
                        
                        }
                    }
                
                else{
                    DispatchQueue.main.async {
                       self.switchGruTracking.setOn(false, animated: true)
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    
    
    func getFullScreenAds(){
        let parameters = "adv_location=full_page"
        let url = URL(string:ServerUrl.advertiseGlobalUrl)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // self.showActivityIndicator()
        
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<recommendData!.count{
                        let jsonObject = recommendData?[i]
                        var bottomhome = bottomBanner()
                        bottomhome.advertisement_id = jsonObject?.object(forKey: "advertisement_id") as? String
                        bottomhome.adv_banner = jsonObject?.object(forKey: "adv_banner") as? String
                        bottomhome.adv_title = jsonObject?.object(forKey: "adv_title") as? String
                        bottomhome.external_link = jsonObject?.object(forKey: "external_link") as? String
                        GlobalVariables.fullPageAdd.add(bottomhome)
                    }
                    
                    DispatchQueue.main.async {
                        // self.hideActivityIndicator()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        // self.hideActivityIndicator()
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func getGlobalAddAdvertiseMent(){
        let parameters = "adv_location=global"
        let url = URL(string:ServerUrl.advertiseGlobalUrl)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       // self.showActivityIndicator()
        
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                    for i in 0..<recommendData!.count{
                        let jsonObject = recommendData?[i]
                        var bottomhome = bottomBanner()
                        bottomhome.id = jsonObject?.object(forKey: "advertisement_id") as? String
                        bottomhome.adv_banner = jsonObject?.object(forKey: "adv_banner") as? String
                        bottomhome.name = jsonObject?.object(forKey: "adv_title") as? String
                        bottomhome.external_link = jsonObject?.object(forKey: "external_link") as? String
                        self.globalbanServerData.add(bottomhome)
                        //                            let location = jsonObject1.object(forKey: "location") as? String
                        //                            let external_link = jsonObject1.object(forKey: "external_link") as? String
                        //                            let adv_banner = jsonObject1.object(forKey: "adv_banner") as? String
                        
                    }
                    
                    DispatchQueue.main.async {
                       // self.hideActivityIndicator()
                        
                        var images = [InputSource]()
                        for i in 0..<self.globalbanServerData.count{
                            var bannerData  = self.globalbanServerData[i] as! bottomBanner
                            var bannerImage : String = bannerData.adv_banner
                            if(bannerImage == ""){
                                
                            }else{
                                let alamofireSource = AlamofireSource(urlString: bannerImage)!
                                images.append(alamofireSource)
                            }
                            
                        }
                        
                        
                                self.addsSlideShow.setImageInputs(images)
                        
                                //self.addsSlideShow.backgroundColor = UIColor.white
                                self.addsSlideShow.slideshowInterval = 3.5
                             //   self.addsSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
                                self.addsSlideShow.pageControl.isHidden = true
                        
                                self.addsSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
                                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTap))
                                self.addsSlideShow.addGestureRecognizer(gestureRecognizer)

                    }
                }
                else{
                    DispatchQueue.main.async {
                       // self.hideActivityIndicator()
                       
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func updatePostion(lat : String,lon : String){
       // let parameters = "member_id=\(UserDefaults.standard.getUserID())&latitude=\(26.695694)&longitude=\(76.911005)"
        let parameters = "member_id=\(UserDefaults.standard.getUserID())&latitude=\(lat)&longitude=\(lon)"
        let url = URL(string:ServerUrl.update_position)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                
                GlobalVariables.locationUpdatedOneTime = false
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getAdvertiseMent(){
        
        var parameters = String()
        if(UserDefaults.standard.isKeyPresentInUserDefaults(key : "lastAddress")){
             parameters = "adv_location=local&location=\(UserDefaults.standard.getLastAddress())"
        }else{
          parameters = "adv_location=local&location="
        }
        
        let url = URL(string:ServerUrl.advertiseGlobalUrl)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //self.showActivityIndicator()
        print("local add---\(url)")
        print("local add---\(parameters)")
        
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
                    let recommendData = json?.object(forKey: "result") as? [NSDictionary]
                        for i in 0..<recommendData!.count{
                            let jsonObject = recommendData?[i]
                            var bottomhome = bottomBanner()
                            bottomhome.id = jsonObject?.object(forKey: "advertisement_id") as? String
                            bottomhome.imageSrc = jsonObject?.object(forKey: "adv_banner") as? String
                            bottomhome.name = jsonObject?.object(forKey: "adv_title") as? String
                            self.btmbanServerData.add(bottomhome)
//                            let location = jsonObject1.object(forKey: "location") as? String
//                            let external_link = jsonObject1.object(forKey: "external_link") as? String
//                            let adv_banner = jsonObject1.object(forKey: "adv_banner") as? String
                            
                        }

                    DispatchQueue.main.async {
                      //  self.hideActivityIndicator()
                        var images = [InputSource]()
                        for i in 0..<self.btmbanServerData.count{
                            var bannerData  = self.btmbanServerData[i] as! bottomBanner
                            var bannerImage : String = bannerData.imageSrc
                            let alamofireSource = AlamofireSource(urlString: bannerImage)!
                            images.append(alamofireSource)
                        }
                        
                        
                        self.bottomAddSlideShow.setImageInputs(images)
                        self.bottomAddSlideShow.backgroundColor = UIColor.white
                        self.bottomAddSlideShow.slideshowInterval = 3.5
//                        self.bottomAddSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.rgb(hexcolor: "#5c2d91")
//                        self.bottomAddSlideShow.pageControl.pageIndicatorTintColor = UIColor.white
                        self.bottomAddSlideShow.pageControl.isHidden = true
                        self.bottomAddSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
                    }
                }
                else{
                    DispatchQueue.main.async {
                       // self.hideActivityIndicator()
                        //self.alert(message: "Wrong Adds", title:"Nirjara Ap")
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getCity(){
        let parameters = "key=city&state_id="
        let url = URL(string:ServerUrl.commen_function)!
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
                        let city_id = jsonObject?.object(forKey: "city_id") as? String
                        let city_name = jsonObject?.object(forKey: "city_name") as? String
                        GlobalVariables.cityId.append(city_id!)
                        GlobalVariables.cityName.append(city_name!)
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        //self.txtCity.filterStrings(self.cityName)
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
    
    
    func getState(){
        let parameters = "key=state&country_id="
        let url = URL(string:ServerUrl.commen_function)!
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
                        
                        let stateId = jsonObject?.object(forKey: "sid") as? String
                        let stateName = jsonObject?.object(forKey: "state") as? String
                        GlobalVariables.stateId.append(stateId!)
                        GlobalVariables.stateName.append(stateName!)
                        
                    }
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        //self.txtState.filterStrings(self.stateName)
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
    
    func getGalleryData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang=\(GlobalVariables.selectedLanguage)&member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.get_gallery)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //self.showActivityIndicator()
        
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
                        let name = jsonObject?.object(forKey: "small_image") as? String
                        self.GalleryImage.append(name!)
                        
                        
                        /*var galleryData = galleryModel()
                         galleryData.gallery_id = jsonObject?.object(forKey: "gallery_id") as? String
                         galleryData.name = jsonObject?.object(forKey: "name") as? String
                         galleryData.member_photo = jsonObject?.object(forKey: "member_photo") as? String
                         galleryData.title = jsonObject?.object(forKey: "title") as? String
                         galleryData.description = jsonObject?.object(forKey: "description") as? String
                         galleryData.date = jsonObject?.object(forKey: "date") as? String
                         galleryData.location = jsonObject?.object(forKey: "location") as? String
                         galleryData.larg_image = jsonObject?.object(forKey: "larg_image") as? String
                         galleryData.small_image = jsonObject?.object(forKey: "small_image") as? String
                         galleryData.darshan_liked = jsonObject?.object(forKey: "darshan_liked") as? String
                         galleryData.anumodan_liked = jsonObject?.object(forKey: "anumodan_liked") as? String
                         galleryData.darshanCount = jsonObject?.object(forKey: "darshanCount") as? String
                         galleryData.anumodnaCount = jsonObject?.object(forKey: "anumodnaCount") as? String
                         galleryData.commentsCount = jsonObject?.object(forKey: "commentsCount") as? String
 
                        self.GalleryFullDetail.add(galleryData)*/

                    }
                    
                    DispatchQueue.main.async {
                      //  self.hideActivityIndicator()
                        self.galleryCollectionView.reloadData()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        //self.hideActivityIndicator()
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getBusinessData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang="+GlobalVariables.selectedLanguage
        let url = URL(string:ServerUrl.get_business_cat_home)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //self.showActivityIndicator()
        
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
                    
                        
                        var businessData = businessCatModel()
                        businessData.business_cat_id = jsonObject?.object(forKey: "business_cat_id") as? String
                        businessData.business_category = jsonObject?.object(forKey: "business_category") as? String
                        businessData.icon = jsonObject?.object(forKey: "icon") as? String
                    
                        self.businessFullDetail.add(businessData)
                        
                    }
                    
                    DispatchQueue.main.async {
                        //  self.hideActivityIndicator()
                        self.jainBussinessCollection.reloadData()
                        
                    }
                }
                else{
                    DispatchQueue.main.async {
                        //self.hideActivityIndicator()
                        
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        sideMenu()
        if isConnectedToNetwork() {
            loadLocation()
            btmbanServerData.removeAllObjects()
            self.getAdvertiseMent()
            
            GalleryImage.removeAll()
            //         for i in 0..<tempGalleryImage.count{
            //        GalleryImage.append(tempGalleryImage[i])
            //        }
            
            getGalleryData()
            if(UserDefaults.standard.getMemberType() == "guru" || UserDefaults.standard.getMemberType() == "Guru"){
                getTrackStatus()
            }else{
                
            }
        }
        else{
        showAlert(title: "OOp's", message: "No Internet Connection")
        }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if(collectionView == menuCollectionView){
            return CategoryImage.count
        }
        else if(collectionView == galleryCollectionView){
           return GalleryImage.count
        }
        else if(collectionView == jainBussinessCollection){
            return businessFullDetail.count
        }else{
            return newPurchaseImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
       
        var reusableView : UICollectionReusableView? = nil
       
        if (kind == UICollectionElementKindSectionFooter) {
            // Create Header UICollectionElementKindSectionHeader
            let headerView : GalleryFooterViewCell = jainBussinessCollection.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: jainYellowfooterReuse, for: indexPath) as! GalleryFooterViewCell
            
         
            headerView.mainView?.frame = CGRect(x:0,y:5,width:110,height:90)
            headerView.imgSeemore?.frame = CGRect(x:30,y:0,width:50,height:45)
            headerView.lblSeemore?.frame = CGRect(x:0,y:45,width:100,height:35)
            headerView.lblSeemore?.numberOfLines = 1
            headerView.lblSeemore?.textAlignment = NSTextAlignment.center;
            headerView.mainView.addSubview(headerView.imgSeemore)
            headerView.mainView.addSubview(headerView.lblSeemore)
            let galleryTab = UITapGestureRecognizer(target: self, action:  #selector(gotoJain))
            headerView.addGestureRecognizer(galleryTab)
            reusableView = headerView
        }
        return reusableView!
        
        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == menuCollectionView){
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuTopIdentifier", for: indexPath) as! MainMenuTopViewCell
        let image : UIImage = UIImage(named: CategoryImage[indexPath.row])!
        cell.imgMenuLogo.image = image
        cell.imgMenuLogo?.frame = CGRect(x:25,y:5,width:40,height:40)
        cell.lblMenutxt.numberOfLines = 0
        cell.lblMenutxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.lblMenutxt.sizeToFit()
            if(UserDefaults.standard.getLanguage() == "en"){
                cell.lblMenutxt.text = CategoryArray[indexPath.row]
            }else if(UserDefaults.standard.getLanguage() == "hi"){
                cell.lblMenutxt.text = CategoryArrayHindi[indexPath.row]
            }else if(UserDefaults.standard.getLanguage() == "gu"){
                cell.lblMenutxt.text = CategoryArrayGujarathi[indexPath.row]
            }else{
                cell.lblMenutxt.text = CategoryArray[indexPath.row]
            }
            
        
        cell.lblMenutxt?.frame = CGRect(x:0,y:45,width:90,height:40)
        
        return cell
        }
        else if(collectionView == galleryCollectionView){
            let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "galleryIdentifier", for: indexPath) as! GalleryCollectionViewCell
            
            
            //cell.imgGallery.contentMode = UIViewContentMode.scaleToFill // OR .scaleAspectFill
            
//            cell.imgGallery?.frame = CGRect(x:0,y:0,width:90,height:90)
//            if(indexPath.row <= 2){
//                let image : UIImage = UIImage(named: GalleryImage[indexPath.row])!
//                cell.imgGallery.image = image
//
//            }else{
                if(GalleryImage[indexPath.row] == "" || GalleryImage[indexPath.row] == nil){
                    let placeholderImage = UIImage(named: "default-icon")!
                    cell.imgGallery.image = placeholderImage
                }else{
            
            let url = URL(string:(GalleryImage[indexPath.row]))
            let placeholderImage = UIImage(named: "default-icon")!
            
                    let imageView = UIImageView(frame: CGRect(x:0,y:0,width:100,height:100))
                    let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: imageView.frame.size,radius: 5)
                    cell.imgGallery.af_setImage(withURL: url!,placeholderImage: placeholderImage,filter: filter)
                }
           // }
    
            
            return cell
        }else if(collectionView == jainBussinessCollection){
            let cell = jainBussinessCollection.dequeueReusableCell(withReuseIdentifier: "jainBusinessIdenfier", for: indexPath) as! JainYellowCollectionViewCell
            
            let businessData = businessFullDetail[indexPath.row] as! businessCatModel
            if(businessData.icon == nil || businessData.icon == ""){
                let image : UIImage = UIImage(named: "no_image")!
                cell.imgBusiness.image = image
            }else{
                let url = URL(string:(businessData.icon)!)
                let placeholderImage = UIImage(named: "no_image")!
                cell.imgBusiness.af_setImage(withURL: url!, placeholderImage: placeholderImage)
            }
            
            cell.imgBusiness?.frame = CGRect(x:25,y:0,width:50,height:45)
            cell.lblBusinessName.numberOfLines = 1
            cell.lblBusinessName.textAlignment = NSTextAlignment.center;
            cell.lblBusinessName.text = businessData.business_category
            cell.lblBusinessName?.frame = CGRect(x:0,y:45,width:100,height:35)
            cell.lblBusinessName.lineBreakMode = NSLineBreakMode.byWordWrapping
            //cell.lblBusinessName.sizeToFit()
            
            return cell
        }else{
           
            let cell = newPurchaseCollection.dequeueReusableCell(withReuseIdentifier: "newPurchaseIdentifier", for: indexPath) as! NewPurchaseCollectionViewCell
            let image : UIImage = UIImage(named: newPurchaseImage[indexPath.row])!
            cell.imgNewPurchase.image = image
            cell.imgNewPurchase?.frame = CGRect(x:25,y:0,width:50,height:45)
            cell.lblNewPurcaseText.numberOfLines = 2
            cell.lblNewPurcaseText.textAlignment = NSTextAlignment.center;
            if(UserDefaults.standard.getLanguage() == "en"){
                cell.lblNewPurcaseText.text = newPurchaseText[indexPath.row]
            }else if(UserDefaults.standard.getLanguage() == "hi"){
                cell.lblNewPurcaseText.text = newPurchaseTextHindi[indexPath.row]
            }else if(UserDefaults.standard.getLanguage() == "gu"){
                cell.lblNewPurcaseText.text = newPurchaseTextGujarathi[indexPath.row]
            }
            else{
                cell.lblNewPurcaseText.text = newPurchaseText[indexPath.row]
            }
            
            cell.lblNewPurcaseText?.frame = CGRect(x:0,y:45,width:85,height:30)
            cell.lblNewPurcaseText.lineBreakMode = NSLineBreakMode.byWordWrapping
            //cell.lblNewPurcaseText.sizeToFit()
            return cell
            
        }
        
       
    }
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView{
          //  indexpathofCatgeory = Int(indexPath.row)
            
            
             var CategoryArray = ["Vihar Stay","Temple and Sthanak","Tapasvi Sukh Satha","Jain Events","Vrath Pachchakan","Jain Mantras","Jain Guru Tracking","Active for Samaj Seva","Chaturmas 2018","Jain Library","Donation"]
            if indexPath.row == 0 {
                
                
                
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[7])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                
            }else if(indexPath.row == 1){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[8])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                
            }else if(indexPath.row == 2){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[9])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
              }else if(indexPath.row == 3){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[14])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                
                  }else if(indexPath.row == 4){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[10])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                  }else if(indexPath.row == 5){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[11])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                  }else if(indexPath.row == 6){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[6])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                
                }else if(indexPath.row == 7){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[15])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                }else if(indexPath.row == 8){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[16])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                  }else if(indexPath.row == 9){
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[13])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                  }else if(indexPath.row == 10){
                
                containerController?.swapFromViewController(fromViewController: containerController!.controller as! UIViewController, toViewController: containerController!.controllers[12])
                containerController?.tabBar.selectedItem = nil
                revealViewController().pushFrontViewController(containerController,animated:true)
                
                  }
        }
        else if collectionView == galleryCollectionView{
            
            //self.performSegue(withIdentifier: "showGalleryIdentifier", sender: self)
            
            let galleryView = storyboard?.instantiateViewController(withIdentifier: "GalleryNavigation") as! GalleryCntr
            //galleryView.galleryFullData = GalleryFullDetail
            navigationController?.pushViewController(galleryView, animated: true)
        }
        else if collectionView == jainBussinessCollection{
            
            let businessData = businessFullDetail[indexPath.row] as! businessCatModel
            let jianData = storyboard?.instantiateViewController(withIdentifier: "anotherJainCntr") as! anotherJainYelloViewController
            jianData.whichSearch = businessData.business_category
            jianData.businessId = businessData.business_cat_id
            
            navigationController?.pushViewController(jianData, animated: true)
           // self.performSegue(withIdentifier: "jianAnotherYellowPages", sender: self)
        }
        else if collectionView == newPurchaseCollection{
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "internationalIdentifier", sender: self)
            }else if(indexPath.row == 1){
               self.performSegue(withIdentifier: "carIdentifier", sender: self)
            }else if(indexPath.row == 2){
                self.performSegue(withIdentifier: "offerIdentifier", sender: self)
            }else if(indexPath.row == 3){
                 self.performSegue(withIdentifier: "mobileIdentifier", sender: self)
            }else if(indexPath.row == 4){
               self.performSegue(withIdentifier: "ipadIdentifier", sender: self)
            }else if(indexPath.row == 5){
                self.performSegue(withIdentifier: "jewellaryIdentifier", sender: self)
            }
            
            
        }
        else{
            
        }
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
