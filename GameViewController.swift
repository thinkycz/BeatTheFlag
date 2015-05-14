//
//  GameViewController.swift
//  BeatTheFlag
//
//  Created by Long Do Hai on 08.05.15.
//  Copyright (c) 2015 Long Do Hai. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var timeProgress: UIProgressView!
    
    var timeToCompletePuzzle = 5.0
    var timeRemaining = 5.0
    var aspectRatioConstraint: NSLayoutConstraint!
    var flagsArray: [FlagModel] = []
    var score = 0
    var timer : NSTimer!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var currentFlag: FlagModel! {
        didSet {
            //This method saves RAM more than imageNamed
            self.currentFlagImage = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(currentFlag.flagImageName, ofType: "png")!)
            //self.currentFlagImage = UIImage(named: newFlag.flagImageName!)
            self.flagLabel.text = currentFlag.flagName
        }
    }
    var currentFlagImage: UIImage! {
        didSet {
            UIView.transitionWithView(flagImageView,
                duration: 0.5,
                options: UIViewAnimationOptions.TransitionCrossDissolve,
                animations: {self.flagImageView.image = self.currentFlagImage},
                completion: nil)
        }
    }
    
    override func viewDidLoad() {
        self.importAllFlags()
        self.loadNextRandomFlag()
        
        self.aspectRatioConstraint = NSLayoutConstraint(
            item: self.flagImageView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.flagImageView,
            attribute: NSLayoutAttribute.Height,
            multiplier: self.currentFlagImage.size.height == 0 ? 0 : self.currentFlagImage.size.width / self.currentFlagImage.size.height,
            constant: 0)
        view.addConstraint(aspectRatioConstraint)
        
        self.trueButton.layer.cornerRadius = 10
        self.trueButton.clipsToBounds = true
        self.falseButton.layer.cornerRadius = 10
        self.falseButton.clipsToBounds = true
        self.timeRemaining = self.timeToCompletePuzzle
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerCountdown", userInfo: nil, repeats: true)
    }
    
    @IBAction func correctButtonPressed(sender: AnyObject)
    {
        checkAnswerCorrect(true)
    }
    
    @IBAction func incorrectButtonPressed(sender: AnyObject)
    {
        checkAnswerCorrect(false)
    }
    
    func checkAnswerCorrect(answer: Bool)
    {
        if(answer == self.currentFlag.correct)
        {
            score++;
            self.loadNextRandomFlag()
            timeRemaining = timeToCompletePuzzle
        }
        else
        {
            self.showGameOver()
        }
    }
    
    func timerCountdown()
    {
        timeRemaining -= 0.01
        self.timeProgress.setProgress(Float(timeRemaining / timeToCompletePuzzle), animated: true)
        
        if(timeRemaining <= 0) { showGameOver() }
    }
    
    func showGameOver()
    {
        var streak = defaults.integerForKey("score")
        var alert = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: UIAlertControllerStyle.Alert)

        if(score > streak)
        {
            defaults.setInteger(self.score, forKey: "score")
            alert.message = "Your score is \(score) \n New high score, congratulations!"
        }
        
        self.timer.invalidate()
        alert.addAction(UIAlertAction(title: "Show the difference", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("showDifferenceSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Back to menu", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        Chartboost.showInterstitial(CBLocationHomeScreen)
    }
    
    func loadNextRandomFlag() {
        var randomNumber = Int(arc4random_uniform(UInt32(flagsArray.count)))
        self.currentFlag = flagsArray[randomNumber]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier! == "showDifferenceSegue" && segue.destinationViewController is DifferenceViewController)
        {
            var dvc = segue.destinationViewController as! DifferenceViewController
            dvc.countryName = currentFlag.flagName
            dvc.gvc = self
        }
    }
    
    func importAllFlags()
    {
        flagsArray.append(FlagModel(flagName: "Albania", flagImageName: "Albania", correct: true))
        flagsArray.append(FlagModel(flagName: "Andorra", flagImageName: "Andorra", correct: true))
        flagsArray.append(FlagModel(flagName: "Armenia", flagImageName: "Armenia", correct: true))
        flagsArray.append(FlagModel(flagName: "Austria", flagImageName: "Austria", correct: true))
        flagsArray.append(FlagModel(flagName: "Azerbaijan", flagImageName: "Azerbaijan", correct: true))
        flagsArray.append(FlagModel(flagName: "Belarus", flagImageName: "Belarus", correct: true))
        flagsArray.append(FlagModel(flagName: "Belgium", flagImageName: "Belgium", correct: true))
        flagsArray.append(FlagModel(flagName: "Bosnian", flagImageName: "Bosnian", correct: true))
        flagsArray.append(FlagModel(flagName: "Bulgaria", flagImageName: "Bulgaria", correct: true))
        flagsArray.append(FlagModel(flagName: "Croatian", flagImageName: "Croatian", correct: true))
        flagsArray.append(FlagModel(flagName: "Cyprus", flagImageName: "Cyprus", correct: true))
        flagsArray.append(FlagModel(flagName: "Czech Republic", flagImageName: "Czech Republic", correct: true))
        flagsArray.append(FlagModel(flagName: "Estonia", flagImageName: "Estonia", correct: true))
        flagsArray.append(FlagModel(flagName: "Finland", flagImageName: "Finland", correct: true))
        flagsArray.append(FlagModel(flagName: "France", flagImageName: "France", correct: true))
        flagsArray.append(FlagModel(flagName: "Georgia", flagImageName: "Georgia", correct: true))
        flagsArray.append(FlagModel(flagName: "Germany", flagImageName: "Germany", correct: true))
        flagsArray.append(FlagModel(flagName: "Greece", flagImageName: "Greece", correct: true))
        flagsArray.append(FlagModel(flagName: "Hungary", flagImageName: "Hungary", correct: true))
        flagsArray.append(FlagModel(flagName: "Iceland", flagImageName: "Iceland", correct: true))
        flagsArray.append(FlagModel(flagName: "Ireland", flagImageName: "Ireland", correct: true))
        flagsArray.append(FlagModel(flagName: "Italy", flagImageName: "Italy", correct: true))
        flagsArray.append(FlagModel(flagName: "Kosovo", flagImageName: "Kosovo", correct: true))
        flagsArray.append(FlagModel(flagName: "Latvia", flagImageName: "Latvia", correct: true))
        flagsArray.append(FlagModel(flagName: "Liechtenstein", flagImageName: "Liechtenstein", correct: true))
        flagsArray.append(FlagModel(flagName: "Lithuania", flagImageName: "Lithuania", correct: true))
        flagsArray.append(FlagModel(flagName: "Luxembourg", flagImageName: "Luxembourg", correct: true))
        flagsArray.append(FlagModel(flagName: "Macedonia", flagImageName: "Macedonia", correct: true))
        flagsArray.append(FlagModel(flagName: "Malta", flagImageName: "Malta", correct: true))
        flagsArray.append(FlagModel(flagName: "Moldova", flagImageName: "Moldova", correct: true))
        flagsArray.append(FlagModel(flagName: "Monaco", flagImageName: "Monaco", correct: true))
        flagsArray.append(FlagModel(flagName: "Montenegro", flagImageName: "Montenegro", correct: true))
        flagsArray.append(FlagModel(flagName: "Netherlands", flagImageName: "Netherlands", correct: true))
        flagsArray.append(FlagModel(flagName: "Norway", flagImageName: "Norway", correct: true))
        flagsArray.append(FlagModel(flagName: "Poland", flagImageName: "Poland", correct: true))
        flagsArray.append(FlagModel(flagName: "Portugal", flagImageName: "Portugal", correct: true))
        flagsArray.append(FlagModel(flagName: "Romania", flagImageName: "Romania", correct: true))
        flagsArray.append(FlagModel(flagName: "Russia", flagImageName: "Russia", correct: true))
        flagsArray.append(FlagModel(flagName: "San Marino", flagImageName: "San Marino", correct: true))
        flagsArray.append(FlagModel(flagName: "Serbia", flagImageName: "Serbia", correct: true))
        flagsArray.append(FlagModel(flagName: "Slovakia", flagImageName: "Slovakia", correct: true))
        flagsArray.append(FlagModel(flagName: "Slovenia", flagImageName: "Slovenia", correct: true))
        flagsArray.append(FlagModel(flagName: "Spain", flagImageName: "Spain", correct: true))
        flagsArray.append(FlagModel(flagName: "Sweden", flagImageName: "Sweden", correct: true))
        flagsArray.append(FlagModel(flagName: "Switzerland", flagImageName: "Switzerland", correct: true))
        flagsArray.append(FlagModel(flagName: "Turkey", flagImageName: "Turkey", correct: true))
        flagsArray.append(FlagModel(flagName: "Ukraine", flagImageName: "Ukraine", correct: true))
        flagsArray.append(FlagModel(flagName: "United Kingdom", flagImageName: "United Kingdom", correct: true))
        flagsArray.append(FlagModel(flagName: "Vatican City", flagImageName: "Vatican City", correct: true))
        
        flagsArray.append(FlagModel(flagName: "Albania", flagImageName: "wAlbania", correct: false))
        flagsArray.append(FlagModel(flagName: "Andorra", flagImageName: "wAndorra", correct: false))
        flagsArray.append(FlagModel(flagName: "Armenia", flagImageName: "wArmenia", correct: false))
        flagsArray.append(FlagModel(flagName: "Austria", flagImageName: "wAustria", correct: false))
        flagsArray.append(FlagModel(flagName: "Azerbaijan", flagImageName: "wAzerbaijan", correct: false))
        flagsArray.append(FlagModel(flagName: "Belarus", flagImageName: "wBelarus", correct: false))
        flagsArray.append(FlagModel(flagName: "Belgium", flagImageName: "wBelgium", correct: false))
        flagsArray.append(FlagModel(flagName: "Bosnian", flagImageName: "wBosnian", correct: false))
        flagsArray.append(FlagModel(flagName: "Bulgaria", flagImageName: "wBulgaria", correct: false))
        flagsArray.append(FlagModel(flagName: "Croatian", flagImageName: "wCroatian", correct: false))
        flagsArray.append(FlagModel(flagName: "Cyprus", flagImageName: "wCyprus", correct: false))
        flagsArray.append(FlagModel(flagName: "Czech Republic", flagImageName: "wCzech Republic", correct: false))
        flagsArray.append(FlagModel(flagName: "Estonia", flagImageName: "wEstonia", correct: false))
        flagsArray.append(FlagModel(flagName: "Finland", flagImageName: "wFinland", correct: false))
        flagsArray.append(FlagModel(flagName: "France", flagImageName: "wFrance", correct: false))
        flagsArray.append(FlagModel(flagName: "Georgia", flagImageName: "wGeorgia", correct: false))
        flagsArray.append(FlagModel(flagName: "Germany", flagImageName: "wGermany", correct: false))
        flagsArray.append(FlagModel(flagName: "Greece", flagImageName: "wGreece", correct: false))
        flagsArray.append(FlagModel(flagName: "Hungary", flagImageName: "wHungary", correct: false))
        flagsArray.append(FlagModel(flagName: "Iceland", flagImageName: "wIceland", correct: false))
        flagsArray.append(FlagModel(flagName: "Ireland", flagImageName: "wIreland", correct: false))
        flagsArray.append(FlagModel(flagName: "Italy", flagImageName: "wItaly", correct: false))
        flagsArray.append(FlagModel(flagName: "Kosovo", flagImageName: "wKosovo", correct: false))
        flagsArray.append(FlagModel(flagName: "Latvia", flagImageName: "wLatvia", correct: false))
        flagsArray.append(FlagModel(flagName: "Liechtenstein", flagImageName: "wLiechtenstein", correct: false))
        flagsArray.append(FlagModel(flagName: "Lithuania", flagImageName: "wLithuania", correct: false))
        flagsArray.append(FlagModel(flagName: "Luxembourg", flagImageName: "wLuxembourg", correct: false))
        flagsArray.append(FlagModel(flagName: "Macedonia", flagImageName: "wMacedonia", correct: false))
        flagsArray.append(FlagModel(flagName: "Malta", flagImageName: "wMalta", correct: false))
        flagsArray.append(FlagModel(flagName: "Moldova", flagImageName: "wMoldova", correct: false))
        flagsArray.append(FlagModel(flagName: "Monaco", flagImageName: "wMonaco", correct: false))
        flagsArray.append(FlagModel(flagName: "Montenegro", flagImageName: "wMontenegro", correct: false))
        flagsArray.append(FlagModel(flagName: "Netherlands", flagImageName: "wNetherlands", correct: false))
        flagsArray.append(FlagModel(flagName: "Norway", flagImageName: "wNorway", correct: false))
        flagsArray.append(FlagModel(flagName: "Poland", flagImageName: "wPoland", correct: false))
        flagsArray.append(FlagModel(flagName: "Portugal", flagImageName: "wPortugal", correct: false))
        flagsArray.append(FlagModel(flagName: "Romania", flagImageName: "wRomania", correct: false))
        flagsArray.append(FlagModel(flagName: "Russia", flagImageName: "wRussia", correct: false))
        flagsArray.append(FlagModel(flagName: "San Marino", flagImageName: "wSan Marino", correct: false))
        flagsArray.append(FlagModel(flagName: "Serbia", flagImageName: "wSerbia", correct: false))
        flagsArray.append(FlagModel(flagName: "Slovakia", flagImageName: "wSlovakia", correct: false))
        flagsArray.append(FlagModel(flagName: "Slovenia", flagImageName: "wSlovenia", correct: false))
        flagsArray.append(FlagModel(flagName: "Spain", flagImageName: "wSpain", correct: false))
        flagsArray.append(FlagModel(flagName: "Sweden", flagImageName: "wSweden", correct: false))
        flagsArray.append(FlagModel(flagName: "Switzerland", flagImageName: "wSwitzerland", correct: false))
        flagsArray.append(FlagModel(flagName: "Turkey", flagImageName: "wTurkey", correct: false))
        flagsArray.append(FlagModel(flagName: "Ukraine", flagImageName: "wUkraine", correct: false))
        flagsArray.append(FlagModel(flagName: "United Kingdom", flagImageName: "wUnited Kingdom", correct: false))
        flagsArray.append(FlagModel(flagName: "Vatican City", flagImageName: "wVatican City", correct: false))
    }
}
