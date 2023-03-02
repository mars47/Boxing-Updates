//
//  String+Extensions.swift
//  Boxing 247
//
//  Created by Omar on 08/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    func isValid() -> Bool {
        
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
/*
    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
    09/12/2018                        --> MM/dd/yyyy
    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
    Sep 12, 2:11 PM                   --> MMM d, h:mm a
    September 2018                    --> MMMM yyyy
    Sep 12, 2018                      --> MMM d, yyyy
    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
    12.09.18                          --> dd.MM.yy
    10:41:02.112                      --> HH:mm:ss.SSS
 */
}
