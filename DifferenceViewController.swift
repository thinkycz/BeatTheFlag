//
//  DifferenceViewController.swift
//  BeatTheFlag
//
//  Created by Long Do Hai on 14.05.15.
//  Copyright (c) 2015 Long Do Hai. All rights reserved.
//

import UIKit


class DifferenceViewController: UIViewController {
    
    var countryName: String!
    var aspectRatioConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var gvc: GameViewController!
    var correctImage: UIImage!
    var incorrectImage: UIImage!
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        gvc.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.correctImage = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(countryName, ofType: "png")!)
        self.incorrectImage = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("w" + countryName, ofType: "png")!)
        
        self.aspectRatioConstraint = NSLayoutConstraint(
            item: self.correctImageView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.correctImageView,
            attribute: NSLayoutAttribute.Height,
            multiplier: self.correctImage.size.height == 0 ? 0 : self.correctImage.size.width / self.correctImage.size.height,
            constant: 0)
        view.addConstraint(aspectRatioConstraint)
        self.aspectRatioConstraint = NSLayoutConstraint(
            item: self.incorrectImageView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.incorrectImageView,
            attribute: NSLayoutAttribute.Height,
            multiplier: self.incorrectImage.size.height == 0 ? 0 : self.incorrectImage.size.width / self.incorrectImage.size.height,
            constant: 0)
        view.addConstraint(aspectRatioConstraint)
        
        self.correctImageView.image = correctImage
        self.incorrectImageView.image = incorrectImage
        
        self.backButton.layer.cornerRadius = 10
        self.backButton.clipsToBounds = true
        
        self.countryNameLabel.text = self.countryName
    }
}
