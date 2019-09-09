//
//  ViewController.swift
//  concurrency
//
//  Created by albert coelho oliveira on 9/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var countryTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var country = [Countries](){
        didSet{
            countryTable.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        countryTable.delegate = self
        countryTable.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    private func loadData(){
        Countries.getCountry{ (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let country):
                    self.country = country
                }
            }
        }
    }
    var userSearchTerm: String? {
        didSet {
            self.countryTable.reloadData()
        }
    }
    var filteredCountry: [Countries]  {
        guard let userSearchTerm = userSearchTerm else {
            return country
        }
        guard userSearchTerm != "" else {
            return country
        }
        
        return country.filter({ (country) -> Bool in
            country.name.lowercased().contains(userSearchTerm.lowercased())
            }
        )
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return filteredCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTable.dequeueReusableCell(withIdentifier: "cellCountry", for: indexPath) as! cellDesignTableViewCell
        ImageHelper.shared.fetchImage(urlString:filteredCountry[indexPath.row].flag) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.imageCell.image = image
                    
                }
            }
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchTerm = searchText
    }
    
}
