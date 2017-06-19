//
//  MemeCollectionViewController.swift
//  image-picker
//
//  Created by Apple on 6/17/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  var memes: [Meme]! {
    return (UIApplication.shared.delegate as! AppDelegate).memes // Sync data
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureFlowLayout(view.frame.width)
  }

  func configureFlowLayout(_ width: CGFloat) {
    let space: CGFloat = 1.0
    let cellsPerRow: CGFloat = 4.0

    let dimension = (width - ((cellsPerRow - 1) * space)) / cellsPerRow

    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//    if UIDevice.current.orientation.isPortrait {
//      configureFlowLayout(view.frame.height)
//      print("Height")
//    } else {
//      configureFlowLayout(view.frame.width)
//      print("Width")
//    }

//    collectionView!.collectionViewLayout.invalidateLayout()p
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    collectionView?.reloadData()
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
    cell.previewImage.image = memes[indexPath.row].memedImage
    return cell
  }


  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let meme = memes[indexPath.row]
    let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    detailViewController.image = meme.memedImage
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
