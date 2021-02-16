//
//  CharacterDetailsViewController.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 12/30/17.
//  Copyright © 2017 Nada Kamel. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import ImageViewer

let blurRadious:CGFloat = 25.0
let blurTintColor:UIColor = UIColor(white: 0, alpha: 0.75)
let blurDeltaFactor:CGFloat = 1.4

extension CharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return middleSectionCurrentRowData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiddleSectionCell", for: indexPath) as! MiddleSectionCollectionViewCell
//        cell.middleSectionImageView.sd_setShowActivityIndicatorView(true)
//        cell.middleSectionImageView.sd_setIndicatorStyle(.white)
        cell.middleSectionImageView.sd_setImage(with: URL(string: middleSectionCurrentRowData[indexPath.row].image))
        cell.middleSectionTitleLbl.text = middleSectionCurrentRowData[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected section: \(collectionView.tag)")
        switch collectionView.tag {
        case 0:
            middleSectionCurrentRowData = comics
        case 1:
            middleSectionCurrentRowData = series
        case 2:
            middleSectionCurrentRowData = stories
        default:
            middleSectionCurrentRowData = events
        }
        self.performSegue(withIdentifier:"ThumbnailsImagesViewSegueID",sender: nil)
    }
}

class CharacterDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var character = Character()
    var items: [Item] = []
    var urls: [Url] = []
    
    var comics = [(name: String, image: String)]()
    var series = [(name: String, image: String)]()
    var stories = [(name: String, image: String)]()
    var events = [(name: String, image: String)]()
    
    var topCellReuseIdentifier = "TableTopCell"
    var middleCellReuseIdentifier = "TableMiddleCell"
    var bottomCellReuseIdentifier = "TableBottomCell"
    
    var middleSectionCurrentRowData = [(name: String, image: String)]()
    
    var selectedBottomSectionCell : (type: String, url: String) = ("","")
    
    @IBOutlet weak var characterDetailsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = true
        self.title = character.name
        
        if(self.comics.count == 0 && self.series.count == 0 && self.stories.count == 0 && self.events.count == 0) {
            if Connectivity.isConnectedToInternet() {
                print("Yes! Internet is available.")
                // Empty Thumbnail entity from database
                self.deleteThumbnailEntityData()
                // Get and save Thumbnails in database
                self.getThumbnails(list: self.items)
            }
            else {
                print("No internet is available!")
                let thumbnailsList = self.fetchThumbnailEntityDataPerCharacterID(characterID: Int32(character.id))
                for thumbnail in thumbnailsList {
                    if(thumbnail.category == "comics") {
                        self.comics.append((thumbnail.name,thumbnail.path))
                    }
                    else if(thumbnail.category == "series") {
                        self.series.append((thumbnail.name,thumbnail.path))
                    }
                    else if(thumbnail.category == "stories") {
                        self.stories.append((thumbnail.name,thumbnail.path))
                    }
                    else if(thumbnail.category == "events") {
                        self.events.append((thumbnail.name,thumbnail.path))
                    }
                }
                self.characterDetailsTableView.reloadData()
            }
        }
    }
    
    func getThumbnails(list: [Item]) {
        var thumbnails: [[String:AnyObject]] = []
//        let group = DispatchGroup()
//        for item in list {
//            let urlPath = item.resourceURI!+"?ts=1&apikey="+NetworkLayer.publicKey+"&hash="+NetworkLayer.hash
//            group.enter()
//            Alamofire.request(urlPath, method: .get, parameters: nil).responseJSON() { response in
//                let statusCode = response.response?.statusCode
//                if (statusCode == 200) {
//                    if let requestResponse = response.result.value {
//                        let responseDict = requestResponse as! NSDictionary
//                        let data = responseDict["data"] as! NSDictionary
//                        let results = data["results"] as! NSArray
//                        let resultsDict = results[0] as! NSDictionary
//                        let thumbnailDict = resultsDict["thumbnail"] as? NSDictionary
//                        if(thumbnailDict != nil) {
//                            var imageURL: String = thumbnailDict!["path"] as! String
//                            imageURL.append(".")
//                            imageURL.append(thumbnailDict!["extension"] as! String)
//                            thumbnails.append(["category":item.category as AnyObject,
//                                               "fk_character_id":self.character.id as AnyObject,
//                                               "name":item.name as AnyObject,
//                                               "path":imageURL as AnyObject])
//                            if(item.category == "comics") {
//                                self.comics.append((item.name!,imageURL))
//                            }
//                            else if(item.category == "series") {
//                                self.series.append((item.name!, imageURL))
//                            }
//                            else if(item.category == "stories") {
//                                self.stories.append((item.name!, imageURL))
//                            }
//                            else if(item.category == "events") {
//                                self.events.append((item.name!, imageURL))
//                            }
//                        }
//                    }
//                }
//                group.leave()
//            }
//        }
//        group.notify(queue: .main) {
//            print("Finished all requests.")
//            // Save thumbnails in database for offline use
//            self.saveThumbnailInCoreDataWith(array: thumbnails)
//
//            // Reload table view
//            self.characterDetailsTableView.reloadData()
//        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {               // Details
            return 1
        }
        else if section == 1 {          // Comics, Series, Stories, Events
            return 4
        }
        else {                          // Related Links
            return self.urls.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {               // Details
            return 390
        }
        else if indexPath.section == 1 {          // Comics, Series, Stories, Events
            return 256
        }
        else {                                    // Related Links
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return CGFloat.leastNormalMagnitude
        }
        else {
            return 18.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1 {
            return nil
        }
        else {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.black
            let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: tableView.frame.size.width, height: 18.0))
            label.text = "Related Links".uppercased()
            label.textColor = UIColor.red
            label.font = UIFont.boldSystemFont(ofSize: 15.0)
            headerView.addSubview(label)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.topCellReuseIdentifier, for: indexPath) as! CharacterDetailsTopTableViewCell
            // Configure the cell...
            cell.characterImageView.sd_setImage(with: URL(string: character.thumbnail))
            cell.characterNameLbl.text = character.name
            if (character.desc.isEmpty) {
                cell.characterDescriptionLbl.text = "No description found."
            }
            else {
                cell.characterDescriptionLbl.text = character.description
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.middleCellReuseIdentifier, for: indexPath) as! CharacterDetailsMiddleTableViewCell
            // Configure the cell...
            switch indexPath.row {
            case 0:
                cell.middleSectionTitle.text = "Comics".uppercased()
                middleSectionCurrentRowData = comics
            case 1:
                cell.middleSectionTitle.text = "Series".uppercased()
                middleSectionCurrentRowData = series
            case 2:
                cell.middleSectionTitle.text = "Stories".uppercased()
                middleSectionCurrentRowData = stories
            default:
                cell.middleSectionTitle.text = "Events".uppercased()
                middleSectionCurrentRowData = events
            }
            cell.middleSectionCollectionView.tag = indexPath.row
            cell.middleSectionCollectionView.reloadData()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.bottomCellReuseIdentifier, for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = urls[indexPath.row].type.capitalized
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            selectedBottomSectionCell.type = urls[indexPath.row].type
            selectedBottomSectionCell.url = urls[indexPath.row].urlPath
            self.performSegue(withIdentifier:"RelatedLinksViewSegueID",sender: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destViewController = segue.destination as? RelatedLinksViewController {
            destViewController.relatedLink = selectedBottomSectionCell
        }
        if let destViewController = segue.destination as? ThumbnailsImagesViewController {
            destViewController.gallery = middleSectionCurrentRowData
        }
    }
    

}
