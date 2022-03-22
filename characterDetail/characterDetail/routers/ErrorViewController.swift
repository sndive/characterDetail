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
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
