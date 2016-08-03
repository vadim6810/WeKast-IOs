//
//  SplashScreen.swift
//  WeKast
//
//  Created by Vladimir Bodovets on 01.08.16.
//  Copyright © 2016 WeKast. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation


class SplashScreen: AVPlayerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        let filePath = NSBundle.mainBundle().pathForResource("Splash" , ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        player = AVPlayer(URL: videoURL)
        
        showsPlaybackControls = false
        
        player!.play()
    
//        player!.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions(), context: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidFinishPlaying:",
            name: AVPlayerItemDidPlayToEndTimeNotification, object: player?.currentItem)
        
        
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        // Your code here
        print("Video finished!")
        let toShow = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! ViewController
        self.navigationController?.pushViewController(toShow, animated: true)
        
//        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginController") as! ViewController
        
//        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startSplashScreen() {
        
        //playLocalVideo()
    }
    
//func playLocalVideo() {
//    let filePath = NSBundle.mainBundle().pathForResource("Splash" , ofType: "mp4")
//    let videoURL = NSURL(fileURLWithPath: filePath!)
//    let player = AVPlayer(URL: videoURL)
//    let playerViewController = AVPlayerViewController()
//    playerViewController.player = player
//    
//    // Disable controls of start video
//    playerViewController.showsPlaybackControls = false
//    
//    let videoPlayer = player
//    
//    NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidFinishPlaying:",
//        name: AVPlayerItemDidPlayToEndTimeNotification, object: videoPlayer.currentItem)
//    
//    func playerDidFinishPlaying(note: NSNotification) {
//        print("Video Finished")
//    }
//    
//    self.presentViewController(playerViewController, animated: false) {
//            () -> Void in playerViewController.player!.play()
//        }
//    }
}