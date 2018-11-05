//
//  MyAboutViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/3/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class MyAboutViewCntr: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var aboutData : [String] = ["Personal Information","Family & Relations","Bank Details","Contact Information","Community Information"]
    var aboutDataImg : [String] = ["personal_info","family_rela","bank_detail","contact _info","community_info"]
    
    @IBOutlet weak var aboutTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = aboutTableView.dequeueReusableCell(withIdentifier: "aboutCellIdentifier", for: indexPath) as? AboutViewCell
        
        cell?.mainView.frame = CGRect(x:10,y:5,width:aboutTableView.frame.width-20,height:50)
        cell?.imgIcon.frame = CGRect(x:10,y:12.5,width:25,height:25)
        let placeholderImage = UIImage(named: aboutDataImg[indexPath.row])!
        cell?.imgIcon.image = placeholderImage
        
        cell?.lblAbout.frame = CGRect(x:45,y:5,width:(cell?.mainView.frame.width)!-40,height:40)
        cell?.imgNext.frame = CGRect(x:(cell?.mainView.frame.width)!-40,y:12.5,width:25,height:25)
        cell?.selectionStyle = .none
        cell?.lblAbout.text = aboutData[indexPath.row]
        cell?.mainView.addSubview((cell?.lblAbout)!)
        cell?.mainView.addSubview((cell?.imgNext)!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            self.performSegue(withIdentifier: "personalIdentifier", sender: self)
        }else if(indexPath.row == 1){
            self.performSegue(withIdentifier: "familyIdentifier", sender: self)
        }else if(indexPath.row == 2){
            self.performSegue(withIdentifier: "bankIdentifier", sender: self)
        }else if(indexPath.row == 3){
            self.performSegue(withIdentifier: "contactIdentifier", sender: self)
        }else if(indexPath.row == 4){
            self.performSegue(withIdentifier: "communityIdentifier", sender: self)
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
