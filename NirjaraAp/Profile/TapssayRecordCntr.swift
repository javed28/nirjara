//
//  TapssayRecordCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit

class TapssayRecordCntr: UIViewController,UITableViewDelegate,UITableViewDataSource {

     var charturmasName = [String]()
    
    @IBOutlet weak var tapassayaTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Tapssaya Record"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:11))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:11,length:6))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
          tapassayaTable.separatorStyle = .none
          getTapassviData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return charturmasName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tapassayaTable.dequeueReusableCell(withIdentifier: "tapassayIdentifier", for:indexPath) as! TapassyaRecordTableViewCell
        cell.selectionStyle = .none
        cell.mainView.frame = CGRect(x:0,y:10,width:self.view.frame.width,height:60)
        cell.lblRecord.frame = CGRect(x:10,y:18,width:cell.mainView.frame.width-20,height:25)
        cell.lblRecord.text = charturmasName[indexPath.row]
        cell.mainView.addSubview((cell.lblRecord)!)
       
        
        return cell
    }

    
    func getTapassviData(){
        //location=Mumbai&lang=en&member_id=178
        let parameters = "lang="+GlobalVariables.selectedLanguage
        let url = URL(string:ServerUrl.get_tapassya_all)!
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
                        let name = jsonObject?.object(forKey: "tapassya_name") as? String
                        self.charturmasName.append(name!)
                    }
                    
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tapassayaTable.reloadData()
                        
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
