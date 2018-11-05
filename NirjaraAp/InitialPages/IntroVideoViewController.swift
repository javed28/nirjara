//
//  IntroVideoViewController.swift
//  NirjaraAp
//
//  Created by gadgetzone on 2/24/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import YouTubePlayer

class IntroVideoViewController: UIViewController {

    @IBOutlet weak var introPlayer: YouTubePlayerView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //let joeSmith : [String:String] = ["playsinline": "1","controls": "0","showinfo": "0"]
        
       // introPlayer.playerVars = joeSmith
      //  https://www.youtube.com/watch?v=NrzM7irZlgg
      //  introPlayer.loadVideoID("MDv9xF9VKpc")
        introPlayer.loadVideoID("d9UDyHY1pmY")
        
        if introPlayer.ready {
            if introPlayer.playerState != YouTubePlayerState.Playing {
                introPlayer.play()
               // introPlayer.setTitle("Pause", forState: .Normal)
            } else {
                introPlayer.pause()
                //introPlayer.setTitle("Play", forState: .Normal)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnGetStarted(_ sender: Any) {
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(true, forKey: "gotStarted")
//        userDefaults.synchronize()
        updateIntro()
        
    }
    
    
    
    func updateIntro(){
        let parameters = "member_id=\(UserDefaults.standard.getUserID())"
        let url = URL(string:ServerUrl.update_intro)!
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
                print("Json----",json)
                let Status = json?.object(forKey: "message") as? String;
                if (Status == "success")
                {
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        UserDefaults.standard.setIntroLoggedIn(value: true)
                        self.performSegue(withIdentifier: "sliderToHome", sender: self)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.showAlert(title: "Nirjara Ap", message: "Something Went Worng")
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
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
