//
//  NSOject+Extensions.swift
//  Gay
//
//  Created by Huy Nguyen on 11/22/19.
//  Copyright © 2019 Huy Nguyen. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
