//
//  ChaturmasDetailViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/7/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class ChaturmasDetailViewController: UIViewController {

    @IBOutlet weak var chturmasDetail: UILabel!
    @IBOutlet weak var chaturmasName: UILabel!
    @IBOutlet weak var chaturmasNumber: UILabel!
    @IBOutlet weak var chaturmasPlace: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chturmasDetail.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
        
        
        let greet4Height = chturmasDetail.optimalHeight
        chturmasDetail.frame = CGRect(x:10,y:80,width:self.view.frame.width-20,height:greet4Height)
        chturmasDetail.lineBreakMode = .byWordWrapping
        chturmasDetail.numberOfLines = 0
        
        lineView.frame = CGRect(x:10,y:greet4Height+chturmasDetail.frame.height+5,width:self.view.frame.width-20,height:1)
        chaturmasName.text="SADHUMARGI SAMPRADAY"
        chaturmasName.frame = CGRect(x:10,y:greet4Height+chturmasDetail.frame.height+10,width:self.view.frame.width-20,height:25)
        
        chaturmasNumber.text="1298753648"
        chaturmasPlace.text="Kandivali West,Mumbai,Naharashtra"
        
        chaturmasNumber.frame = CGRect(x:10,y:chaturmasName.frame.origin.y+chaturmasName.frame.height+10,width:self.view.frame.width-20,height:25)
        chaturmasPlace.frame = CGRect(x:10,y:chaturmasNumber.frame.origin.y+chaturmasNumber.frame.height+10,width:self.view.frame.width-20,height:25)
        // Do any additional setup after loading the view.
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
