//
//  Dynamic.swift
//  DemoHcl
//
//  Created by Vishal on 15/08/21.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
