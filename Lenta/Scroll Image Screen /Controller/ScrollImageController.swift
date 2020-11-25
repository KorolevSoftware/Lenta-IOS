//
//  ScrollViewController.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    var data = [ProtoModel]()
    
    @IBOutlet weak var tableView:UITableView!

    var repository:FlickrRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository = FlickrRepository()
        
        if let repository = repository {
            repository.getData { pictures in
                self.data = pictures
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageInfoController"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let dcv = segue.destination as! ImageInfoController
                dcv.model = data[indexPath.row]
                dcv.repository = repository
            }
        }
    }
}


extension ScrollViewController:UITabBarDelegate{}

extension ScrollViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        newImageCell.bind(picture: data[indexPath.row])
        newImageCell.repository = repository
        return newImageCell
    }
}
