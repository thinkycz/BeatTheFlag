//
//  ViewController.swift
//  BeatTheFlag
//
//  Created by Long Do Hai on 08.05.15.
//  Copyright (c) 2015 Long Do Hai. All rights reserved.
//

import UIKit
import GameKit

class MenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var streakLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var score: Int = 0 {
        didSet {
            self.streakLabel.text = "Streak: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.playButton.layer.cornerRadius = 10
        self.playButton.clipsToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        self.score = defaults.integerForKey("score")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonPressed(sender: AnyObject) {
        //Segue happens here
    }
    
    @IBAction func gameCenterButtonPressed(sender: AnyObject) {
        self.gameCenterAuthentication()
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: ["I scored \(score) in Beat The Flag, check it out!"], applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func rateThisAppButtonPressed(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/app/bars/id706081574")!)
    }
    
    @IBAction func creditsButtonPressed(sender: AnyObject) {
        var alert = UIAlertController(title: "Credits", message: "Long Do Hai, Tuan Anh Ta Le", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Back to menu", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayLeaderboard(viewController: UIViewController)
    {
        var gameCenterController: GKGameCenterViewController! = GKGameCenterViewController()
        if ((gameCenterController) != nil)
        {
            gameCenterController.gameCenterDelegate = self;
            gameCenterController.viewState = GKGameCenterViewControllerState.Leaderboards;
            viewController.presentViewController(gameCenterController, animated: true, completion: nil)
        }
    }
    
    func gameCenterAuthentication()
    {
        GKLocalPlayer.localPlayer().authenticateHandler = { (viewController, error) -> Void in
            if(viewController != nil)
            {
                self.presentViewController(viewController, animated: true, completion: nil)
            }
        }
        if(GKLocalPlayer.localPlayer().authenticated)
        {
            self.submitScoreToGameCenter()
            self.displayLeaderboard(self)
        }
    }
    
    func submitScoreToGameCenter()
    {
        var scoreReporter: GKScore = GKScore(leaderboardIdentifier: "cz.thinky.BeatTheFlag.Leaderboard")
        scoreReporter.value = Int64(score)
        GKScore.reportScores([scoreReporter], withCompletionHandler: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

