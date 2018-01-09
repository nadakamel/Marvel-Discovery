//
//  FilteredCharactersViewController.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/9/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit

class FilteredCharactersTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
}


class FilteredCharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var characters = [(id: Int32, name: String?, thumbnail: String?, description: String?)]()
    var filteredCharacters = [(id: Int32, name: String?, thumbnail: String?, description: String?)]()
    
    var selectedCharacter: (id: Int32, name: String?, thumbnail: String?, description: String?) = (0,"","","")
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var filteredCharactersTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        self.filteredCharactersTableView.backgroundColor = UIColor(red: 41.0/255.0, green: 44.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        self.filteredCharactersTableView.separatorStyle = .none
        self.filteredCharactersTableView.tableFooterView = UIView()
        
        configureSearchController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Hide navigation bar while swip up, or show navigation bar while swip down.
        navigationController?.hidesBarsOnSwipe = false
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return self.filteredCharacters.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilteredCharactersTableCell", for: indexPath) as! FilteredCharactersTableViewCell
        cell.backgroundColor = UIColor(red: 60.0/255.0, green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        // Configure the cell...
        // Name
        cell.characterNameLabel?.text = filteredCharacters[indexPath.row].name
        cell.characterNameLabel?.textColor = UIColor.white
        // Image
        cell.characterImageView?.sd_setImage(with: URL(string: filteredCharacters[indexPath.row].thumbnail!))
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter.id = filteredCharacters[indexPath.row].id
        selectedCharacter.thumbnail = filteredCharacters[indexPath.row].thumbnail
        selectedCharacter.name = filteredCharacters[indexPath.row].name!
        selectedCharacter.description = filteredCharacters[indexPath.row].description
        
        self.performSegue(withIdentifier:"CharacterDetailsViewSegueID",sender: nil)
    }

    // MARK: - Configure Search Bar
    
    func configureSearchController() {
        if #available(iOS 11.0, *) {
            // Initialize and perform a minimum configuration to the search controller.
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.title = nil
            navigationController?.navigationBar.largeTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
            navigationController?.navigationBar.barTintColor = UIColor.black
            navigationItem.hidesSearchBarWhenScrolling = false
            self.searchController.delegate = self
            self.searchController.searchResultsUpdater = self
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.dimsBackgroundDuringPresentation = false
            self.searchController.searchBar.sizeToFit()
            self.searchController.searchBar.delegate = self
            self.searchController.searchBar.tintColor = UIColor.red
            self.searchController.searchBar.placeholder = "Search..."
            self.searchController.searchBar.setShowsCancelButton(true, animated: true)
            definesPresentationContext = true
            
            // Place the search bar view to the navigation bar view..
            navigationItem.searchController = self.searchController
        }
        else {
            // Initialize and perform a minimum configuration to the search controller.
            navigationItem.title = nil
            navigationController?.navigationBar.barTintColor = UIColor.black
            self.searchController.delegate = self
            self.searchController.searchResultsUpdater = self
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.dimsBackgroundDuringPresentation = false
            self.searchController.searchBar.sizeToFit()
            self.searchController.searchBar.delegate = self
            self.searchController.searchBar.tintColor = UIColor.red
            self.searchController.searchBar.placeholder = "Search..."
            self.searchController.searchBar.setShowsCancelButton(true, animated: true)
            definesPresentationContext = true
            
            // Place the search bar view to the navigation bar view.
            navigationItem.titleView = self.searchController.searchBar
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destViewController = segue.destination as? CharacterDetailsViewController {
            destViewController.character = selectedCharacter
            destViewController.items = self.fetchItemEntityDataPerCharacterID(characterID: selectedCharacter.id)
            destViewController.urls = self.fetchUrlEntityDataPerCharacterID(characterID: selectedCharacter.id)
        }
    }

}

// MARK: - UISearchResultsUpdating Delegate

extension FilteredCharactersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text?.isEmpty)! {
            // Remove all characters from previous filterations.
            self.filteredCharacters.removeAll(keepingCapacity: false)
            // Reload the tableview.
            self.filteredCharactersTableView.separatorStyle = .none
            self.filteredCharactersTableView.reloadData()
        }
        else {
            // Remove all characters from previous filterations.
            self.filteredCharacters.removeAll(keepingCapacity: false)
            // Get search text.
            let searchText = searchController.searchBar.text
            // Filter the data array and get only those name that match the search text.
            self.filteredCharacters = self.characters.filter({( character : (id: Int32, name: String?, thumbnail: String?, description: String?)) -> Bool in
                return (character.name?.lowercased().contains(searchText!.lowercased()))!
            })
            // Reload the tableview.
            self.filteredCharactersTableView.separatorStyle = .singleLine
            self.filteredCharactersTableView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate

extension FilteredCharactersViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchControllerDelegate

extension FilteredCharactersViewController: UISearchControllerDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        guard let firstSubview = searchBar.subviews.first else { return }
        firstSubview.subviews.forEach {
            ($0 as? UITextField)?.clearButtonMode = .never
        }
    }
}
