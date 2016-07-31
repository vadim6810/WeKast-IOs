//
//  ViewController.swift
//  Lesson3
//
//  Created by Vladimir Bodovets on 28.07.16.
//  Copyright © 2016 WeKast. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        startSplashScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage() {
        let alertMessage = UIAlertController(title: "Окно предупреждений", message: "сообщение с предупреждением", preferredStyle: UIAlertControllerStyle.Alert)
        alertMessage.addAction(UIAlertAction(title: "Продолжить...", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertMessage, animated: true, completion: nil)
    }
    
    @IBAction func startSplashScreen() {
        playLocalVideo()
    }
    
    func playLocalVideo() {
        let filePath = NSBundle.mainBundle().pathForResource("Splash" , ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        let player = AVPlayer(URL: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // Disable controls of start video
        playerViewController.showsPlaybackControls = false
        self.presentViewController(playerViewController, animated: false) {
            () -> Void in playerViewController.player!.play()
        }
        
    }


}

