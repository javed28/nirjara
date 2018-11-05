

//
//  AudioPlayViewCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import AVFoundation
class AudioPlayViewCntr: UIViewController {

    
    var audioLink = String()
    var packhanMessage = String()
    var titleString = String()
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    @IBOutlet weak var btnLanguage: UIButton!
    
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var lblPachkanMantra: UILabel!
    private var playbackLikelyToKeepUpContext = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = titleString as NSString
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:myString.length))
       
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
        print("audioLink--",audioLink)
       
        
        
        
        btnLanguage.frame = CGRect(x:10,y:80,width:self.view.frame.width - 20,height:50)
        btnLanguage.setTitle("lang_en".localized1, for: .normal)

        if(packhanMessage == "no message"){
             lblPachkanMantra.alpha = 0
        }else{
            var string = packhanMessage
            let str = string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            lblPachkanMantra.text = str
        }
        let pachtitleFooterHeight = lblPachkanMantra.optimalHeight
        lblPachkanMantra.frame = CGRect(x:10,y:145,width:view.frame.width-20,height:pachtitleFooterHeight)
        lblPachkanMantra.numberOfLines = 0
        lblPachkanMantra.textAlignment = NSTextAlignment.center
        //lblPachkanMantra.draw(lblPachkanMantra.frame)
        
        if(audioLink == nil){
            btnPlay.isUserInteractionEnabled = false
            btnStop.isUserInteractionEnabled = false
        }else{
        let newString : String = audioLink.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: newString)
        if(url == nil){
            btnPlay.isUserInteractionEnabled = false
            btnStop.isUserInteractionEnabled = false
        }else{
         
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:80, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        }
        }
        
        
        
        
        btnPlay.frame = CGRect(x:5,y:self.view.frame.height-130,width:self.view.frame.width/2-5,height:50)
        btnStop.frame = CGRect(x:self.view.frame.width/2+5,y:self.view.frame.height-130,width:self.view.frame.width/2-10,height:50)
        
        
        
       
        
        btnStop.addTarget(self, action: #selector(stopAudio(_:)), for: UIControlEvents.touchUpInside)
        btnPlay.setFAText(prefixText: "", icon: .FAPlay, postfixText: "   Play", size: 20, forState: .normal)
        btnStop.setFAText(prefixText: "", icon: .FAStop, postfixText: "   Stop", size: 20, forState: .normal)
        btnPlay.addTarget(self, action: #selector(playAudio(_:)), for: UIControlEvents.touchUpInside)
        btnPlay.setFATitleColor(color: UIColor.rgb(hexcolor: "#34AF23"), forState: .normal)
        btnStop.setFATitleColor(color: UIColor.rgb(hexcolor: "#941100"), forState: .normal)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        player?.addObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp",
                            options: .new, context: &playbackLikelyToKeepUpContext)
    }
    
    @objc func playAudio(_ sender : UIButton){
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            btnPlay.setFAText(prefixText: "", icon: .FAPause, postfixText: "   Pause", size: 20, forState: .normal)
            btnPlay.setFATitleColor(color: UIColor.white, forState: .normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            btnPlay.setFAText(prefixText: "", icon: .FAPlay, postfixText: "   Play", size: 20, forState: .normal)
            btnPlay.setFATitleColor(color: UIColor.rgb(hexcolor: "#34AF23"), forState: .normal)
        }
    }
    @objc func stopAudio(_ sender : UIButton){
            player?.seek(to: kCMTimeZero)
            player!.pause()
            btnPlay.setFAText(prefixText: "", icon: .FAPlay, postfixText: "   Play", size: 20, forState: .normal)
            btnPlay.setFATitleColor(color: UIColor.rgb(hexcolor: "#34AF23"), forState: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &playbackLikelyToKeepUpContext {
            if (player?.currentItem!.isPlaybackLikelyToKeepUp)! {
                hideActivityIndicator()
            } else {
                showActivityIndicator()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
       player?.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
    }
    
    
    
    //deinit {
       // player?.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
    //}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
