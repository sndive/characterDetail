//
//  ErrorViewController.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import UIKit

class ErrorViewController: UIViewController {
    @IBOutlet private weak var errorTitle: UILabel!
    var errorText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTitle.text = errorText
        title = "Error"
    }

}
