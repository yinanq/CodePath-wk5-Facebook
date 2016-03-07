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
    
    let contentInset = CGFloat(100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photoImage
        
//        photoImageView.contentMode = .ScaleAspectFit
        
        // MARK: - 2askTim
        // hacky solution that solves the problem of contentMode cannot be animated but breaks zooming
        if photoImage.size.width > photoImage.size.height {
            photoImageView.bounds.size.height = 214
        } else {
            photoImageView.bounds.size.height = 460
        }
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.contentInset.top = contentInset
        scrollView.contentInset.bottom = contentInset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - my methods
    func setButtonsAlpha(alpha: CGFloat) {
        UIView.animateWithDuration(0.1, animations: {
            self.doneButton.alpha = alpha
            self.toolBarImage.alpha = alpha
        })
    }
    
    // MARK: - Zooming
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    var zoomed = false
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        zoomed = true
//        print("zoomed", zoomed)
        UIView.animateWithDuration(0.3, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 1)
        })
        self.view.backgroundColor = UIColor(white: 0, alpha: 1)
        setButtonsAlpha(0)
    }
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if scale == 1 {
            zoomed = false
            UIView.animateWithDuration(0.1, animations: {
                self.scrollView.contentOffset.y = 0
                self.doneButton.alpha = 1
                self.toolBarImage.alpha = 1
            })
        } else {
            zoomed = true
        }
        print("zoomed",zoomed,"to scale",scale)
    }
    
    // MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // scroll to fade out background to peak fromViewController, scroll enough to fade out background and dismiss view, scroll not enough to bounce back
    var backgroundAlpha = CGFloat(1)
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var toolBarImage: UIImageView!
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        setButtonsAlpha(0)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scroll view did scroll to Y:", scrollView.contentOffset.y)
//        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.contentSize.height = view.frame.height
        scrollView.contentInset.top = contentInset
        scrollView.contentInset.bottom = contentInset
        if zoomed == false {
            let scrollLimit = CGFloat(50)
            let minimumAlpha = CGFloat(0.3)
            if scrollView.contentOffset.y < -scrollLimit || scrollView.contentOffset.y > scrollLimit {
                view.backgroundColor = UIColor(white: 0, alpha: minimumAlpha)
            } else {
                backgroundAlpha = minimumAlpha + (scrollLimit - abs(scrollView.contentOffset.y) ) / scrollLimit
                view.backgroundColor = UIColor(white: 0, alpha: backgroundAlpha)
            }
        }
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scroll view did end dragging on Y:", scrollView.contentOffset.y)
        if zoomed == false {
            if scrollView.contentOffset.y > -50 && scrollView.contentOffset.y < 50 && decelerate == false {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    scrollView.contentOffset.y = 0
                    self.doneButton.alpha = 1
                    self.toolBarImage.alpha = 1
                })
            } else {
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
}
