//
//  items.swift
//  Gesture
//
//  Created by Pham Ngoc Hai on 11/21/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class Item: UIImageView{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    func setup()
    {
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(Item.onPan(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.minimumNumberOfTouches = 1
        self.addGestureRecognizer(panGesture)
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(Item.pinchPhoto(_:)))
        self.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(Item.rotateItem(_:)))
        rotateGesture.delegate = self
        self.addGestureRecognizer(rotateGesture)
    }
    func onPan(_ panGesture: UIPanGestureRecognizer)
    {
        if (panGesture.state == .began || panGesture.state == .changed)
        {
            let point = panGesture.location(in: self.superview)
            self.center = point;
            
        }
        
    }
    func pinchPhoto(_ pinchGestrureRecognizer: UIPinchGestureRecognizer)
    {
               self.adjustAnchorPointForGestureRecognizer(pinchGestrureRecognizer)
        if let view = pinchGestrureRecognizer.view
        {
            view.transform = view.transform.scaledBy(x: pinchGestrureRecognizer.scale, y: pinchGestrureRecognizer.scale)
            pinchGestrureRecognizer.scale = 1
        }
    }
    func rotateItem(_ rotateGestureRecognizer: UIRotationGestureRecognizer)
    {
               self.adjustAnchorPointForGestureRecognizer(rotateGestureRecognizer)
        if let view = rotateGestureRecognizer.view
        {
            view.transform = view.transform.rotated(by: rotateGestureRecognizer.rotation)
            rotateGestureRecognizer.rotation = 0
        }
        
    }
    func adjustAnchorPointForGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer)
    {
        if (gestureRecognizer.state == .began)
        {
            let locationInCurrentView = gestureRecognizer.location(in: gestureRecognizer.view)
            let locationInSuperView = gestureRecognizer.location(in: gestureRecognizer.view!.superview)
            self.layer.anchorPoint = CGPoint(x: locationInCurrentView.x / gestureRecognizer.view!.bounds.size.width, y: locationInCurrentView.y / gestureRecognizer.view!.bounds.size.height)
            self.center = locationInSuperView
        }
    }
}
extension Item: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
}
