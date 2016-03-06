//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    // 5 wedding photos and their array
    @IBOutlet weak var photoImageView1: UIImageView!
    @IBOutlet weak var photoImageView2: UIImageView!
    @IBOutlet weak var photoImageView3: UIImageView!
    @IBOutlet weak var photoImageView4: UIImageView!
    @IBOutlet weak var photoImageView5: UIImageView!
    var photoImageViews: [UIImageView]!
    var tappedPhotoIndex: Int!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageViews = [photoImageView1,photoImageView2,photoImageView3,photoImageView4,photoImageView5]
        
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
    
//    @IBAction func didTapPhoto(sender: UITapGestureRecognizer) {
//        performSegueWithIdentifier("photoSegue", sender: self)
//    }
    // use UIButton instead of UITapGestureRecognizer in order to access sender.tag
    @IBAction func didTapButtonOnPhoto(sender: UIButton) {
        tappedPhotoIndex = sender.tag
        performSegueWithIdentifier("photoSegue", sender: self)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    // Get the new view controller using segue.destinationViewController.
        let destinationViewController = segue.destinationViewController as! PhotoViewController
        
    // Pass the selected object to the new view controller.
        destinationViewController.photoImage = self.photoImageViews[tappedPhotoIndex].image
    }
    
}
