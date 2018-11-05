//
//  SplashScreenViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/22/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class SplashScreenViewCntr: UIViewController {

    @IBOutlet weak var splashIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                splashIcon.image = UIImage(named:"Splash")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                splashIcon.image = UIImage(named:"Splash")
            case 2436:
                print("iPhone X")
                
                splashIcon.image = UIImage(named:"iphoneXSplash")

            default:
                splashIcon.image = UIImage(named:"Splash")
            }
        }
        perform(#selector(SplashScreenViewCntr.showNavController), with : nil, afterDelay:3)
    }
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    @objc func showNavController(){
        if(UserDefaults.standard.getLoggedIn()){
            if(UserDefaults.standard.getIntroLoggedIn()){
                self.performSegue(withIdentifier: "SplashToHome", sender: self)
                GlobalVariables.selectedLanguage = UserDefaults.standard.getLanguage()
            }else{
               // self.performSegue(withIdentifier: "splashToIntro", sender: self)
                self.performSegue(withIdentifier: "SplashToVideoIntro", sender: self)
                
                 GlobalVariables.selectedLanguage = UserDefaults.standard.getLanguage()
            }
        }
        else{
            self.performSegue(withIdentifier: "SplashtoLogin", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
