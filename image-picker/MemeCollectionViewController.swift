//
//  MemeCollectionViewController.swift
//  image-picker
//
//  Created by Apple on 6/17/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

  var memes: [Meme]! {
    return (UIApplication.shared.delegate as! AppDelegate).memes
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    collectionView?.reloadData()
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath)
    return cell
  }


  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Handle cell press
  }
}
