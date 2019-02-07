//
//  ViewController.swift
//  PerformanceMonitoringDebug
//
//  Created by Kazuhiro Hayashi on 2019/02/07.
//  Copyright © 2019 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operationQueue.addOperation(FooOperation())
    }
}

