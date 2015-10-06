//
//  ViewController.swift
//  MiniBlog
//
//  Created by Allister Alambra on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import UIKit
import CoreData

class HomeController: BaseController, UITableViewDataSource, UITableViewDelegate{

    var homeView: HomeView?
    var blogPosts: [Post]?
    var postIndexPath: NSInteger = 0
    
    // MARK: Lifecycle method override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("HomeView")
        self.homeView = (self.view as! HomeView)
        self.homeView?.blogTable.dataSource = self
        self.homeView?.blogTable.delegate = self
        
        // Initialize UI Elements
        self.initializeNavigationBar()
        
        // Register Custom TableView Class
        let nibName = UINib(nibName: "BlogPostCell", bundle:nil)
        self.homeView?.blogTable.registerNib(nibName, forCellReuseIdentifier: "BlogPostCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Post")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            self.blogPosts = results as? [Post]
            self.homeView?.blogTable.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Segue to AddBlogView
    func addBlogPost(){
        self.performSegueWithIdentifier("HomeToAddBlogSegue", sender: self)
    }
    
    // MARK: Controller Initializers
    
    func initializeNavigationBar(){
        
        let addBlogButtonItem = UIBarButtonItem(title: "Blog Now!", style: .Plain, target: self, action: Selector("addBlogPost"))
        
        self.navigationItem.rightBarButtonItem = addBlogButtonItem
        
    }

    // MARK: UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (blogPosts?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.homeView?.blogTable.dequeueReusableCellWithIdentifier("BlogPostCell", forIndexPath: indexPath) as! BlogPostCell
        
        let blogPost:Post = self.blogPosts![indexPath.row]
        
        cell.blogTitleLabel.text = blogPost.title! + " by " + blogPost.post_author!.name!
        cell.blogPreviewLabel.text = blogPost.content!
        cell.blogDateLabel.text = String(blogPost.date!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        postIndexPath = indexPath.row
        self.performSegueWithIdentifier("HomeToUpdateBlogSegue", sender: self)
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 70.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "HomeToUpdateBlogSegue") {
            if let destController:UpdateBlogController = segue.destinationViewController as? UpdateBlogController {
                let blogPost = self.blogPosts?[postIndexPath]
                destController.postTitle = (blogPost?.title)!
                destController.postContent = (blogPost?.content)!
//                self.navigationController?.pushViewController(destController, animated: true)
            }
        }
    }
    
}

