//
//  DetailViewController.swift
//  image-picker
//
//  Created by Apple on 6/19/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var image: UIImage? = nil
  @IBOutlet weak var memeImage: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.memeImage.image = self.image
  }
  
}
