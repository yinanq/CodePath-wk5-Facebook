//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var tappedPhotoImageView: UIImageView!
    var lightboxTransition = LightboxTransition()
    // this line above equals the combination of these two lines below, declaring an object of a class and then instantiating an instance of the object:
    // var lightboxTransition: LightboxTransition!
    // lightboxTransition = LightboxTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }

    @IBAction func didTapPhoto(sender: UITapGestureRecognizer) {
        tappedPhotoImageView = sender.view as! UIImageView
        performSegueWithIdentifier("photoSegue", sender: self)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        let destinationViewController = segue.destinationViewController as! PhotoViewController
        
        // Pass the selected object to the new view controller.
        destinationViewController.photoImage = self.tappedPhotoImageView.image
        
        // custom transition 
        // http://courses.codepath.com/courses/ios_for_designers/pages/custom_view_controller_transitions
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = lightboxTransition
    }
    
}
