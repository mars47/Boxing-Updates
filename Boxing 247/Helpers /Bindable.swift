//
//  Bindable.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation

class Bindable<T> {
    typealias Listener = ((T) -> Void)
    var listener: Listener? // 'listener' is a function
    
    var value: T {
        didSet { // 'didset' stipulates: any time an instance of bindable has been changed -> run listener
            //print("Value has been changed: \(value) ")
            listener?(value)
        }
    }
    
    init(_ v: T) {
        self.value = v
    }
    
    // listener can be whatever function you want it to be, but it must be assigned first using one of the 'bind' functions, othwerwise it will return a function with no implementation if called
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
