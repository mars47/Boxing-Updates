//
//  UIScrollView+Extensions.swift
//  Boxing 247
//
//  Created by Omar on 08/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    var isAtBottom: Bool {
        bounds.maxY >= contentSize.height - 100
    }
    
    func isAtBottom(using contentSizeHeight: CGFloat) -> Bool{
        bounds.maxY >= contentSizeHeight - 100
    }
}
