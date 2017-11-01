//
//  UIScrollView+Helper.swift
//  ios-flickr-api
//
//  Created by OkuderaYuki on 2017/10/16.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    func isScrollEnd() -> Bool {
        return self.contentOffset.y >= (self.contentSize.height - self.bounds.size.height)
    }
}
