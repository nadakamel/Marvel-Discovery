//
//  ThumbnailsImagesViewController.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/8/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit

class ThumbnailsImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var gallery = [(name: String, image: String)]()
    var resuseIdentifier = "GalleryCollectionCell"
    
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        // Right Navigation Bar Item
        let closeBtn = UIBarButtonItem(image: UIImage(named: "icn-nav-close-white"), style: .plain, target: self, action: #selector(closeBtnTapped))
        self.navigationItem.rightBarButtonItem = closeBtn
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func closeBtnTapped() {
        print("Close Button Pressed!")
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.resuseIdentifier, for: indexPath) as! ThumbnailsImagesCollectionViewCell
        cell.imageView.sd_setShowActivityIndicatorView(true)
        cell.imageView.sd_setIndicatorStyle(.white)
        cell.imageView.sd_setImage(with: URL(string: gallery[indexPath.row].image))
        cell.imageTitleLbl.text = gallery[indexPath.row].name
        cell.imageNumLbl.text = "\(indexPath.row+1)/\(gallery.count)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected section: \(indexPath.section), row: \(indexPath.row)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
