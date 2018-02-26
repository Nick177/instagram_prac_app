//
//  DetailsViewController.swift
//  instagram_app
//
//  Created by Nicholas Rosas on 2/25/18.
//  Copyright © 2018 Nicholas Rosas. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var postTimeStamp: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        postAuthor.text = post?.author.username
        postCaption.text = post?.caption
        postTimeStamp.text = dateFormatter.string(from: (post?.createdAt!)!)
        postImageView.file = post?.media
        postImageView.loadInBackground()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
