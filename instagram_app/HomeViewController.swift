//
//  HomeViewController.swift
//  instagram_app
//
//  Created by Nicholas Rosas on 2/20/18.
//  Copyright © 2018 Nicholas Rosas. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource {
    
    var posts: [Post]! = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //if let currentUser = PFUser.current() {
            //homeLabel.text = currentUser.username
        //}
        self.tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        fetchLast20Posts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.posts != nil {
            return self.posts!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        cell.postCaption.text = self.posts[indexPath.row].caption
        let image = Post.getImageFromPFFile(file: self.posts[indexPath.row].media)
        
        if image != nil {
            cell.postImageView.image = image
        } else {
            print("Not working")
        }
        
        return cell
    }
    
    func fetchLast20Posts() {
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                // handle error
            }
        })
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchLast20Posts()
    }
    
    
}
