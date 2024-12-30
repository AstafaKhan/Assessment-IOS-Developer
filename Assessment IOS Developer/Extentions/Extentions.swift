//
//  Extentions.swift
//  Assessment IOS Developer
//
//  Created by Mohammad Astafa Khan on 19/12/2024.
//

import Foundation

extension NSObject {

    // Instance property to get the class name of the object
    var className: String {
        return String(describing: type(of: self))
    }

    // Class property to get the class name of the type
    class var className: String {
        return String(describing: self)
    }
    
    // Optional: If you'd like to get the full class hierarchy
    var classHierarchy: String {
        var currentClass: AnyClass? = type(of: self)
        var classNames: [String] = []
        
        while let cls = currentClass {
            classNames.append(String(describing: cls))
            currentClass = class_getSuperclass(cls)
        }
        
        return classNames.joined(separator: " -> ")
    }
}
