//
//  ScrollViewController.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var data = [ProtoModel]()
    var repository:ProtoRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        view.bringSubviewToFront(activityIndicator)
        repository = FlickrRepository()
        
        if let repository = repository {
            repository.getData { pictures in
                
                switch pictures {
                case .success(let picture, let isCache):
                    self.data = picture
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    if isCache
                    {
                        self.present(Utils.alertInfo(title: "Offline", message: "No Actual data"),animated: true, completion: nil)
                    }
                    
                case .failure(let networkError):
                    self.present(Utils.alertInfo(title: "Internet", message: "Internet error"),animated: true, completion: nil)
                    print("\(networkError)")
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(ImageInfoController.self)", let indexPath = tableView.indexPathForSelectedRow
        {
            let dcv = segue.destination as! ImageInfoController
            dcv.model = data[indexPath.row]
            dcv.repository = repository
        }
    }
}


extension ScrollViewController:UITabBarDelegate{}

extension ScrollViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newImageCell = tableView.dequeueReusableCell(withIdentifier: "\(ImageCell.self)", for: indexPath) as! ImageCell
        newImageCell.bind(picture: data[indexPath.row], repository:repository!)
        
        return newImageCell
    }
}
