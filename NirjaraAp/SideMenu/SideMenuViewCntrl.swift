//
//  SideMenuViewCntrl.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/26/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class SideMenuViewCntrl: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    
    
    @IBOutlet weak var sidemenuTable: UITableView!
    var CategoryArray = ["Choose Language","Home","Profile","Guru Bhagwant Tracking","Temple and Sthanak","Vrath Pachchakan","Jain Mantras","Donation","Jain Yellow Pages","Jain Kids name","Events","Jain Library","Withdraw Money","Share App","Help","Contact","Logout"]
    
     var CategoryArrayHindi = ["भाषा चुनें","घर","प्रोफाइल","जैन गुरू ट्रैकिंग","मंदिर और स्थानक","व्रत पच्चक्खाण","जैन मंत्र","दान","जैन येल्लो पेजेस","जैन बच्चों के नाम","जैन महोत्सव","जैन ग्रंथालय","रुपया निकालना","शेयर ऍप","सहायता","संपर्क करें","लॉग आउट"]
    
     var CategoryArrayGujarathi = ["ભાષા પસંદ","ઘર","પ્રોફાઇલ","જૈન ગુરુ ટ્રેકિંગ","મંદિરો સ્ટાનિક","વ્રત પંચકણ","જૈન મંત્ર","દાન","જૈન યેલ્લોઉં પગેસ ","જૈન બાળકોનું નામ","જૈન મોહોત્સવ","જૈન લાઇબ્રેરી","પૈસા પાછા ખેંચો","શેર એપ","મદદ","સંપર્ક કરો","લૉગ આઉટ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     func numberOfSections(in tableView: UITableView) -> Int {
       
            return CategoryArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        
                let cell = sidemenuTable.dequeueReusableCell(withIdentifier: "SidemenuIdentifier") as! SideMenuTableViewCell!
            
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        if(UserDefaults.standard.getLanguage() == "en"){
            cell?.lblMenuName.text = CategoryArray[indexPath.row]
        }else if(UserDefaults.standard.getLanguage() == "hi"){
            cell?.lblMenuName.text = CategoryArrayHindi[indexPath.row]
        }else if(UserDefaults.standard.getLanguage() == "gu"){
            cell?.lblMenuName.text = CategoryArrayGujarathi[indexPath.row]
        }else{
            cell?.lblMenuName.text = CategoryArray[indexPath.row]
        }
        
                return cell!
        
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
