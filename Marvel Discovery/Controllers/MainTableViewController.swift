//
//  MainTableViewController.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 12/30/17.
//  Copyright © 2017 Nada Kamel. All rights reserved.
//

import UIKit
import SDWebImage


class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}

class MainTableViewController: UITableViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
    var pageNo: Int = 0
    
    var characters = [Character]()

    var selectedCharacter = Character()
    
    let networkManager = NetworkManager()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Image Title
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "icn-nav-marvel"))

        // Right Navigation Bar Item
        let searchBtn = UIBarButtonItem(image: UIImage(named: "icn-nav-search"), style: .plain, target: self, action: #selector(searchBtnTapped))
        self.navigationItem.rightBarButtonItem = searchBtn
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.tableView.backgroundView = activityIndicatorView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = false
        
        if (self.characters.count == 0) {
            tableView.separatorStyle = .none
            if Connectivity.isConnectedToInternet() {
                print("Yes! Internet is available.")
                activityIndicatorView.startAnimating()
                self.tableView.separatorStyle = .none
                // Empty entities from database
                self.deleteCharacterEntityData()
                self.deleteItemEntityData()
                self.deleteThumbnailEntityData()
                self.deleteUrlEntityData()
                // Get and save Characters in database
                self.getCharacters(offset: 0)
            }
            else {
                print("No internet is available!")
                characters = RealmHelper.getRealmCharacters() ?? []
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Get Characters List
    
    func getCharacters(offset: Int) {
        var characters: [[String:AnyObject]] = []
        var items: [[String:AnyObject]] = []
        var urls: [[String:AnyObject]] = []
        networkManager.fetchCharacters(offset: offset) { result in
            switch result {
            case .success(let response):
                print(response as Array<Character>)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        let group = DispatchGroup()
//        group.enter()
//        NetworkLayer.getCharactersHTTPRequest(offset: offset) { response in
//            let result = response as NSArray
//            let dict = result[0] as! NSDictionary
//            if let val = dict["error"] {
//                self.activityIndicatorView.stopAnimating()
//                let alert = UIAlertController(title: "Error", message: val as? String, preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//            else {
//                for results in response {
//                    let result = results as! NSDictionary
//                    // Character
//                    let thumbnailDict = result["thumbnail"] as! NSDictionary
//                    let path: String = thumbnailDict["path"] as! String
//                    let ext: String = thumbnailDict["extension"] as! String
//                    let thumbnail: String = path + "." + ext
//                    characters.append(["description":result["description"] as AnyObject,
//                                       "id": result["id"] as! Int as AnyObject,
//                                       "name":result["name"] as AnyObject,
//                                       "resourceURI":result["resourceURI"] as AnyObject,
//                                       "thumbnail":thumbnail as AnyObject])
//
//                    self.characters.append((result["id"] as! Int32, result["name"] as? String, thumbnail, result["description"] as? String))
//
//                    // Comics
//                    let comics = result["comics"] as! NSDictionary
//                    let comics_items = comics["items"] as! NSArray
//                    for item in comics_items {
//                        let itemDict = item as! NSDictionary
//                        items.append(["category":"comics" as AnyObject,
//                                      "fk_character_id":result["id"] as! Int as AnyObject,
//                                      "name":itemDict["name"] as AnyObject,
//                                      "resourceURI":itemDict["resourceURI"] as AnyObject])
//                    }
//                    // Series
//                    let series = result["series"] as! NSDictionary
//                    let series_items = series["items"] as! NSArray
//                    for item in series_items {
//                        let itemDict = item as! NSDictionary
//                        items.append(["category":"series" as AnyObject,
//                                      "fk_character_id":result["id"] as! Int as AnyObject,
//                                      "name":itemDict["name"] as AnyObject,
//                                      "resourceURI":itemDict["resourceURI"] as AnyObject])
//                    }
//                    // Stories
//                    let stories = result["stories"] as! NSDictionary
//                    let stories_items = stories["items"] as! NSArray
//                    for item in stories_items {
//                        let itemDict = item as! NSDictionary
//                        items.append(["category":"stories" as AnyObject,
//                                      "fk_character_id":result["id"] as! Int as AnyObject,
//                                      "name":itemDict["name"] as AnyObject,
//                                      "resourceURI":itemDict["resourceURI"] as AnyObject,
//                                      "type":itemDict["type"] as AnyObject])
//                    }
//                    // Events
//                    let events = result["events"] as! NSDictionary
//                    let events_items = events["items"] as! NSArray
//                    for item in events_items {
//                        let itemDict = item as! NSDictionary
//                        items.append(["category":"events" as AnyObject,
//                                      "fk_character_id":result["id"] as! Int as AnyObject,
//                                      "name":itemDict["name"] as AnyObject,
//                                      "resourceURI":itemDict["resourceURI"] as AnyObject])
//                    }
//                    // Urls
//                    let URLs = result["urls"] as! NSArray
//                    for url in URLs {
//                        let urlDict = url as! NSDictionary
//                        urls.append(["fk_character_id":result["id"] as! Int as AnyObject, "type":urlDict["type"] as AnyObject, "url":urlDict["url"] as AnyObject])
//                    }
//                }
//                group.leave()
//            }
//
//            group.notify(queue: .main, execute: {
//                print("Finished all requests.")
//
//                // Save to database
//                print("----------------------")
//                self.saveCharacterInCoreDataWith(array: characters)
//                self.saveItemInCoreDataWith(array: items)
//                self.saveUrlInCoreDataWith(array: urls)
//
//                self.activityIndicatorView.stopAnimating()
//
//                self.navigationItem.rightBarButtonItem?.isEnabled = true
//
//                self.tableView.separatorStyle = .singleLine
//                self.tableView.reloadData()
//            })
//        }
    }
    
    // MARK: - Search Button Tapped
    
    @objc func searchBtnTapped() {
        print("Search Button Pressed!")
        self.performSegue(withIdentifier:"FilterCharactersViewSegueID",sender: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.characters.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableCell", for: indexPath) as! MainTableViewCell
        // Configure the cell...
        // Name
        cell.titleLabel.text = characters[indexPath.row].name
        // Image
        cell.characterImageView?.sd_setImage(with: URL(string: characters[indexPath.row].thumbnail))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.characters.count - 1
        if indexPath.row == lastItem {
            // Request more data
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        pageNo+=1
        self.getCharacters(offset: pageNo*6)
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter.id = characters[indexPath.row].id
        selectedCharacter.thumbnail = characters[indexPath.row].thumbnail
        selectedCharacter.name = characters[indexPath.row].name
        selectedCharacter.desc = characters[indexPath.row].desc
     
        self.performSegue(withIdentifier:"CharacterDetailsViewSegueID",sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destViewController = segue.destination as? CharacterDetailsViewController {
            destViewController.character = selectedCharacter
            destViewController.items = self.fetchItemEntityDataPerCharacterID(characterID: Int32(selectedCharacter.id))
            destViewController.urls = self.fetchUrlEntityDataPerCharacterID(characterID: Int32(selectedCharacter.id))
        }
        if let destViewController = segue.destination as? FilteredCharactersViewController {
            destViewController.characters = self.characters
        }
    }

}


