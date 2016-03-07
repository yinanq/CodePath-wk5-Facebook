//
//  LightboxTransition.swift
//  CodePath-wk5-Facebook
//
//  Created by Yinan iMac on 3/5/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LightboxTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // hide toViewController
        toViewController.view.alpha = 0
        
        // access fromViewController and toViewController's properties
        let newsFeedViewController = fromViewController as! NewsFeedViewController
        let photoViewContorller = toViewController as! PhotoViewController
        
        // create window
        let window = UIApplication.sharedApplication().keyWindow
        
        // create temp views
        let tempBackgroundView = UIView()
        let tempImageView = UIImageView()
        
        // set up temp views
        tempBackgroundView.backgroundColor = UIColor(white: 0, alpha: 1)
        tempBackgroundView.alpha = 0
        tempBackgroundView.frame = toViewController.view.frame
//        tempImageView.frame = newsFeedViewController.tappedPhotoImageView.frame
        tempImageView.frame = window!.convertRect(newsFeedViewController.tappedPhotoImageView.frame, fromView: newsFeedViewController.scrollView)
        tempImageView.image = newsFeedViewController.tappedPhotoImageView.image
        tempImageView.clipsToBounds = newsFeedViewController.tappedPhotoImageView.clipsToBounds
        tempImageView.contentMode = newsFeedViewController.tappedPhotoImageView.contentMode
        
        // add temp views
//        containerView.addSubview(tempBackgroundView)
//        containerView.addSubview(tempImageView)
        window?.addSubview(tempBackgroundView)
        window?.addSubview(tempImageView)
        
        // hide photo tile
        newsFeedViewController.tappedPhotoImageView.alpha = 0
        
        // animation
        UIView.animateWithDuration(duration, animations: {
            tempBackgroundView.alpha = 1
            tempImageView.frame = photoViewContorller.photoImageView.frame
//            tempImageView.contentMode = photoViewContorller.photoImageView.contentMode
        }) { (finished: Bool) -> Void in
            
            // unhide toViewController
            toViewController.view.alpha = 1
            
            // remove temp views
            tempBackgroundView.removeFromSuperview()
            tempImageView.removeFromSuperview()
            
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // hide fromViewController
        fromViewController.view.alpha = 0
        
        // access fromViewController and toViewController's properties
        let newsFeedViewController = toViewController as! NewsFeedViewController
        let photoViewContorller = fromViewController as! PhotoViewController
        
        // create window
        let window = UIApplication.sharedApplication().keyWindow
        
        // create temp views
        let tempBackgroundView = UIView()
        let tempImageView = UIImageView()
        
        // set up temp views
        tempBackgroundView.backgroundColor = UIColor(white: 0, alpha: 1)
        tempBackgroundView.frame = fromViewController.view.frame
        tempImageView.frame = window!.convertRect(photoViewContorller.photoImageView.frame, fromView: photoViewContorller.scrollView)
        tempImageView.image = photoViewContorller.photoImageView.image
        tempImageView.clipsToBounds = photoViewContorller.photoImageView.clipsToBounds
        tempImageView.contentMode = photoViewContorller.photoImageView.contentMode
        
        // add temp views
//        containerView.addSubview(tempBackgroundView)
//        containerView.addSubview(tempImageView)
        window?.addSubview(tempBackgroundView)
        window?.addSubview(tempImageView)
        
        // animation
        tempBackgroundView.alpha = photoViewContorller.backgroundAlpha
        UIView.animateWithDuration(duration, animations: {
            tempBackgroundView.alpha = 0
            tempImageView.frame = window!.convertRect(newsFeedViewController.tappedPhotoImageView.frame, fromView: newsFeedViewController.scrollView)
//            tempImageView.contentMode = newsFeedViewController.tappedPhotoImageView.contentMode
            }) { (finished: Bool) -> Void in
                
                // unhide photo tile
                newsFeedViewController.tappedPhotoImageView.alpha = 1
                
                // remove temp views
                tempBackgroundView.removeFromSuperview()
                tempImageView.removeFromSuperview()
                
                self.finish()
        }
    }
    
}
