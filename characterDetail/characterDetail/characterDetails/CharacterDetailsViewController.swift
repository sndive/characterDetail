//
//  CharacterDetailsViewController.swift
//  characterDetail
//
//  Created by Anton Tropashko on 23.03.2022.
//

import UIKit
import SDWebImage

class CharacterDetailsViewController: UIViewController {
    var character: MarvelCharacter? {
        didSet {
            if lblTitle != nil {
                updateUI()
            }
        }
    }
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI()
    {
        lblTitle.text = character?.name
        
        if let thumb = character?.thumbnail, let url = thumb.path, let ext = thumb.fileextension
        {
            guard let url = URL(string: url + "." + ext) else {
                NSLog("invalid url \(url)")
                return
            }
            imageView.sd_setImage(with: url)
        }
    }

}
