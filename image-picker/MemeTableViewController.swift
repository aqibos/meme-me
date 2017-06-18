//
//  MemeTableViewController.swift
//  image-picker
//
//  Created by Apple on 6/17/17.
//  Copyright © 2017 Aqib Shah. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

  var memes: [Meme]! {
    return (UIApplication.shared.delegate as! AppDelegate).memes // Keep in sync
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    tableView.reloadData()
  }

  // MARK: UITableViewDataSource methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableViewCell
    let meme = memes[indexPath.row]
    cell.previewImage.image = meme.memedImage
    cell.previewText.text = "\(meme.topText) \(meme.bottomText)"
    return cell
  }
}
