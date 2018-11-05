//
//  IntroSliderViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import paper_onboarding
class IntroSliderViewController: UIViewController,PaperOnboardingDataSource,PaperOnboardingDelegate  {
    

    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var introSlider: OnBoradingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        introSlider.dataSource = self
        introSlider.delegate = self
        btnGetStarted.frame = CGRect(x:self.view.frame.width - 60,y:self.view.frame.height - 60,width :40,height : 40)
        btnSkip.frame = CGRect(x:20,y:self.view.frame.height - 60,width :40,height : 40)
        btnGetStarted.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        btnSkip.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func getStarted(_ sender: UIButton) {
        

        self.performSegue(withIdentifier: "sliderToVideo", sender: self)
    }
    
    
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    func onboardingWillTransitonToIndex(_ index: Int) {
        // btnGetStarted.isHidden = index == 3 ? false : true
        
        if index == 1{
            if self.btnGetStarted.alpha == 1{
                UIView.animate(withDuration: 0.2, animations: {
                    self.btnGetStarted.alpha = 0
                })
            }
        }
        
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3{
            UIView.animate(withDuration: 0.4, animations: {
                self.btnGetStarted.alpha = 1
            })
        }
    }
    
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        
        let backgroundOne = UIColor(red:217/255, green:72/255, blue:89/255, alpha:1)
        let backgroundTwo =  UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00)
        let backgroundThree = UIColor(red:0.61, green:0.56, blue:0.74, alpha:1.00)
    
        var image1 : UIImage = UIImage(named:"slide1")!
         var image2 : UIImage = UIImage(named:"slide2")!
         var image3 : UIImage = UIImage(named:"slide3")!
         var image4 : UIImage = UIImage(named:"slide4")!
        var roundIcon : UIImage = UIImage(named:"roundblack")!
        return [
            
            OnboardingItemInfo(informationImage:image1, title: "Active SamajSeva", description: "Check Who is Active", pageIcon:roundIcon,color: UIColor.white, titleColor: UIColor.rgb(hexcolor: "FF9800"), descriptionColor: UIColor.rgb(hexcolor: "FF9800"), titleFont: titleFont, descriptionFont: descriptionFont),
            OnboardingItemInfo(informationImage: image2, title: "Guru Tracking", description: "Track Guru Near By", pageIcon:roundIcon, color:backgroundTwo, titleColor: UIColor.rgb(hexcolor: "FF9800"), descriptionColor: UIColor.rgb(hexcolor: "FF9800"), titleFont: titleFont, descriptionFont: descriptionFont),
            OnboardingItemInfo(informationImage: image3, title: "Vrath Pachkan", description: "Vrath Pachkan", pageIcon: roundIcon, color: backgroundThree, titleColor: UIColor.rgb(hexcolor: "FF9800"), descriptionColor: UIColor.rgb(hexcolor: "FF9800"), titleFont: titleFont, descriptionFont: descriptionFont),
            OnboardingItemInfo(informationImage: image4, title: "Add Events", description: "Add Events Near By You", pageIcon: roundIcon, color: backgroundOne, titleColor: UIColor.rgb(hexcolor: "FF9800"), descriptionColor: UIColor.rgb(hexcolor: "FF9800"), titleFont: titleFont, descriptionFont: descriptionFont)
            ][index]
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        item.imageView?.frame = CGRect(x:5,y:10,width:self.view.frame.width-10,height:400)
        item.descriptionLabel?.backgroundColor = UIColor.red
        //    item.titleLabel?.backgroundColor = .redColor()
        //    item.descriptionLabel?.backgroundColor = .redColor()
        //    item.imageView = ...
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
         */
        
    }

}
