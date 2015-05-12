//
//  ViewController.swift
//  BeatTheFlag
//
//  Created by Long Do Hai on 08.05.15.
//  Copyright (c) 2015 Long Do Hai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.playButton.layer.cornerRadius = 10
        self.playButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButtonPressed(sender: AnyObject) {
        //Segue happens here
    }
    
    @IBAction func gameCenterButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: ["My high score"], applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
    }

    @IBAction func rateThisAppButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func creditsButtonPressed(sender: AnyObject) {
        var alert = UIAlertController(title: "Credits", message: "Long Do Hai, Tuan Anh Ta Le", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Back to menu", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

