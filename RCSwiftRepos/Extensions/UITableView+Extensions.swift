//
//  UITableView+Extensions.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNibForCell(withClass classType: AnyClass) {
        let className = String(describing: classType)
        register(
            UINib(nibName: className, bundle: Bundle(for: classType)),
            forCellReuseIdentifier: className
        )
    }
    
    func registerCell(withClass classType: AnyClass) {
        let className = String(describing: classType)
        register(classType, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(withClass classType: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: classType)) as! T
    }
}
