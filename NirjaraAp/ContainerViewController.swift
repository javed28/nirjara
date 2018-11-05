//
//  ContainerViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController,UITabBarDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    
    //var someInts = [Int]()
    var controllers = [UINavigationController]()
    
    //var controllers: NSArray?
    var controller: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
        let chooseLangNavigation0 = storyboard.instantiateViewController(withIdentifier: "chooseLangNavigation") as! UINavigationController
        
        let homeNavigation1 = storyboard.instantiateViewController(withIdentifier: "homeNavigation") as! UINavigationController
        
        let addNavigation2 = storyboard.instantiateViewController(withIdentifier: "addNavigation") as! UINavigationController
        
        let calenderNavigation3 = storyboard.instantiateViewController(withIdentifier: "calenderNavigation") as! UINavigationController
        
        let oldprofileNavigation4 = storyboard.instantiateViewController(withIdentifier: "profileNavigation") as! UINavigationController
        let profileNavigation4 = storyboard.instantiateViewController(withIdentifier: "NewProfileNavigation") as! UINavigationController
        
        
        let securityNavigation5 = storyboard.instantiateViewController(withIdentifier: "securityNavigation") as! UINavigationController
        
        let guruTrakingNavigation6 = storyboard.instantiateViewController(withIdentifier: "guruTrackingNav") as! UINavigationController
        
        let viharStayNavigation7 = storyboard.instantiateViewController(withIdentifier: "viharStayNavigation") as! UINavigationController
        
        let templeSthanakNavigation8 = storyboard.instantiateViewController(withIdentifier: "templeSthanakNavigation") as! UINavigationController
        
        let tapasviSukhNavigation9 = storyboard.instantiateViewController(withIdentifier: "tapasviSukhNavigation") as! UINavigationController
        
        let varthPachkanNavigation10 = storyboard.instantiateViewController(withIdentifier: "varthPachkanNavigation") as! UINavigationController
        
        let jainMantrasNavigation11 = storyboard.instantiateViewController(withIdentifier: "jainMantrasNavigation") as! UINavigationController
        
        let donationNavigation12 = storyboard.instantiateViewController(withIdentifier: "donationNavigation") as! UINavigationController
        
        let jainLibraryNavigation13 = storyboard.instantiateViewController(withIdentifier: "jainLibraryNavigation") as! UINavigationController
        
        let EventsNavigation14 = storyboard.instantiateViewController(withIdentifier: "EventsNavigation1") as! UINavigationController
        
        let activeSamajSevaNavigation15 = storyboard.instantiateViewController(withIdentifier: "activeSamajSevaNavigation") as! UINavigationController
        
        let chaturmasNavigation16 = storyboard.instantiateViewController(withIdentifier: "chaturmasNavigation") as! UINavigationController
        
        let JainKidsNavigation17 = storyboard.instantiateViewController(withIdentifier: "JainKidsNavigation") as! UINavigationController
        
        let withdrawMoneyNavigation18 = storyboard.instantiateViewController(withIdentifier: "withdrawMoneyNavigation") as! UINavigationController

        let jainYellowNavigation19 = storyboard.instantiateViewController(withIdentifier: "jainYellowNavigation") as! UINavigationController
        let contactUsNavigation20 = storyboard.instantiateViewController(withIdentifier: "contactUsNavigation") as! UINavigationController
    
        showActivityIndicator()
        
        controllers = [chooseLangNavigation0,homeNavigation1,addNavigation2,calenderNavigation3, profileNavigation4,securityNavigation5,guruTrakingNavigation6,viharStayNavigation7,templeSthanakNavigation8,tapasviSukhNavigation9,varthPachkanNavigation10,jainMantrasNavigation11,donationNavigation12,jainLibraryNavigation13,EventsNavigation14,activeSamajSevaNavigation15,chaturmasNavigation16,JainKidsNavigation17,withdrawMoneyNavigation18,jainYellowNavigation19,contactUsNavigation20];
        
        for aController: UINavigationController in controllers {
            self.addChildViewController(aController)
            let view = aController.view
            view?.frame = containerView.frame
            containerView.addSubview(view!)
        }
        hideActivityIndicator()
        
        
        
       
       // let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        //self.addChildViewController(homeViewController)
        
        let view = homeNavigation1.view
        view?.frame = containerView.frame
        containerView.addSubview(view!)
        controller = homeNavigation1
        
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items![0]
        
        tabBar.items?[0].title = "Home".localized1
        tabBar.items?[1].title = "Add".localized1
        tabBar.items?[2].title = "Calendar".localized1
        tabBar.items?[3].title = "Profile".localized1
        tabBar.items?[4].title = "Security".localized1
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.index(of: item)
       
        if(index == 0){
             let newController = controllers[1]
            
            swapFromViewController(fromViewController:controller as! UIViewController, toViewController: newController)
        }else if(index == 1){
            let newController = controllers[2]
            
            swapFromViewController(fromViewController: controller! as! UIViewController, toViewController: newController)
            
        }
        else if(index == 2){
            let newController = controllers[3]
            
            swapFromViewController(fromViewController: controller! as! UIViewController, toViewController: newController)
            
        }
        else if(index == 3){
            let newController = controllers[4]
            
            swapFromViewController(fromViewController: controller! as! UIViewController, toViewController: newController)
            
        }
        else if(index == 4){
            let newController = controllers[5]
            
            swapFromViewController(fromViewController: controller! as! UIViewController, toViewController: newController)
            
        }
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //var tabFrame = tabBar.frame
        //tabFrame.size.height = 60
       // tabFrame.origin.y = self.view.frame.size.height - 60
       
    //tabBar.frame = tabFrame
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                tabBar.frame = CGRect(x:0,y:self.view.frame.size.height - 50,width:self.view.frame.size.width,height:50)
            case 1334:
                print("iPhone 6/6S/7/8")
                tabBar.frame = CGRect(x:0,y:self.view.frame.size.height - 50,width:self.view.frame.size.width,height:50)
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                tabBar.frame = CGRect(x:0,y:self.view.frame.size.height - 50,width:self.view.frame.size.width,height:50)
            case 2436:
                print("iPhone X")
                tabBar.frame = CGRect(x:0,y:self.view.frame.size.height - 80,width:self.view.frame.size.width,height:80)
            default:
                print("unknown")
            }
        }
    }
    
    
    func swapFromViewController(fromViewController: UIViewController, toViewController newViewController: UIViewController)
    {
        if fromViewController !== newViewController {
            newViewController.view.frame = containerView.frame
            fromViewController.willMove(toParentViewController: nil)
            self.addChildViewController(newViewController)
            self.transition(from: fromViewController, to: newViewController, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: { (finished) in
                fromViewController.removeFromParentViewController()
                newViewController.didMove(toParentViewController: self)
                self.controller = newViewController
            })
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
