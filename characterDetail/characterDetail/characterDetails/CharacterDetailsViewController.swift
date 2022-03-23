//
//  CharacterDetailsViewController.swift
//  characterDetail
//
//  Created by Anton Tropashko on 23.03.2022.
//

import UIKit
//import SDWebImage

class CharacterDetailsViewController: UIViewController {
    var character: MarvelCharacter?
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = character?.name
        
        if let url = character?.thumbnail?.path {
//            sd_we
        }
    }

}
