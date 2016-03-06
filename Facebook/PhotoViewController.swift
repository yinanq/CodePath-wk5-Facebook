//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Yinan iMac on 3/5/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    var photoImage: UIImage!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photoImage
        if photoImage.size.width >= photoImage.size.height {
            photoImageView.contentMode = .ScaleAspectFit
        } else {
            photoImageView.contentMode = .ScaleAspectFill
        }
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        let contentInset = CGFloat(100)
        scrollView.contentInset.top = contentInset
        scrollView.contentInset.bottom = contentInset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // scroll to fade out background to peak fromViewController, scroll enough to fade out background and dismiss view, scroll not enough to bounce back
    var backgroundAlpha = CGFloat(1)
    @IBOutlet weak var doneButtonImage: UIImageView!
    @IBOutlet weak var toolBarImage: UIImageView!
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.1, animations: {
            self.doneButtonImage.alpha = 0
            self.toolBarImage.alpha = 0
        })
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollY = scrollView.contentOffset.y
        print(scrollY)
        let scrollLimit = CGFloat(50)
        let minimumAlpha = CGFloat(0.3)
        if scrollY < -scrollLimit || scrollY > scrollLimit {
            view.backgroundColor = UIColor(white: 0, alpha: minimumAlpha)
        } else {
            backgroundAlpha = minimumAlpha + (scrollLimit - abs(scrollY) ) / scrollLimit
            view.backgroundColor = UIColor(white: 0, alpha: backgroundAlpha)
        }
    }
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        let scrollY = scrollView.contentOffset.y
//        print(scrollY)
//        if scrollY < -50 || scrollY > 50 {
//            dismissViewControllerAnimated(true, completion: nil)
//        } else {
//            scrollView.contentOffset.y = 0
//            UIView.animateWithDuration(0.05, animations: { () -> Void in
//                self.doneButtonImage.alpha = 1
//                self.toolBarImage.alpha = 1
//            })
//        }
//    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollY = scrollView.contentOffset.y
        print(scrollY)
        if scrollY < -50 || scrollY > 50 {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            scrollView.contentOffset.y = 0
            UIView.animateWithDuration(0.05, animations: { () -> Void in
                self.doneButtonImage.alpha = 1
                self.toolBarImage.alpha = 1
            })
        }
    }
    
}
