//
//  Meme.swift
//  image-picker
//
//  Created by Aqib Shah on 4/17/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {

  var topText: String
  var bottomText: String
  var originalImage: UIImage
  var memedImage: UIImage
  
  init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
    self.topText = topText
    self.bottomText = bottomText
    originalImage = image
    self.memedImage = memedImage
  }
  
  
  
}
