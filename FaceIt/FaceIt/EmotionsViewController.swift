//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Aaditya Deowanshi on 9/9/17.
//  Copyright © 2017 Aaditya Deowanshi. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navCon = destinationViewController as? UINavigationController {
            destinationViewController = navCon.visibleViewController ?? destinationViewController
        }
        if let faceViewController = destinationViewController as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    faceViewController.expression = expression
                    if let sendingButton = sender as? UIButton {
                        faceViewController.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }
    
    private let emotionalFaces : Dictionary<String, FacialExpression> =  [
        "happy" : FacialExpression(eyes : .Open,eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open,eyeBrows: .Relaxed, mouth: .Smirk),
        "angry" :  FacialExpression(eyes: .Closed, eyeBrows : .Furrowed, mouth : .Frown),
        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)]
    
}
