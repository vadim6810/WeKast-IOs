//
//  ViewController.swift
//  WeKast
//
//  Created by Vladimir Bodovets on 28.07.16
//       Upgraded by Igor Belitskii on 03.08.16
//  Copyright © 2016 WeKast. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SwiftHTTP
import JSONJoy

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        //startSplashScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage() {
        let password="";
        let log=self.login.text;
        let mail=self.email.text;
        print(log," ",mail);
        
        let params = ["login": log, "email": mail]
        struct Answer: JSONJoy {
            let login: String?
            let email: String?
            let password : String?
            init(_ decoder: JSONDecoder){
                login = decoder["login"].string
                email = decoder["email"].string
                password = decoder["password"].string
            }
        }
        struct Response: JSONJoy {
            let status:  Int?
            let error: String?
            let answer : Answer?
            init(_ decoder: JSONDecoder){
                status = decoder["status"].integer
                error = decoder["error"].string
                answer = Answer(decoder["answer"])
            }
        }
        do {
            let opt = try HTTP.POST("http://78.153.150.254/register", parameters: params)
            opt.start { response in
                print("opt finished: \(response.description)")
                //  print (response.data)
                let resp = Response(JSONDecoder(response.data))
                if let err = resp.error {
                    print("got an error: \(err)")
                }
                if let status = resp.status {
                    print("code: \(status)")
                }
                if let login1 = resp.answer?.login {
                    print("Registered login: \(login1)")
                }
                if let email1 = resp.answer?.email{
                    print("Registered e-mail: \(email1)")
                }
                if let password = resp.answer?.password{
                    print("Your password: \(password)")
                    self.passText.text=password
                }            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        print("Finish");
        let alertMessage = UIAlertController(title: "Your password", message: "Your password is \(password)", preferredStyle: UIAlertControllerStyle.Alert)
        alertMessage.addAction(UIAlertAction(title: "Продолжить...", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertMessage, animated: true, completion: nil)
    }
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passText: UITextField!
    
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

