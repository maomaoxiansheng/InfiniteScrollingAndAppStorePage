//
//  ViewController.swift
//  AppStorePage
//
//  Created by MOMO on 16/5/23.
//  Copyright © 2016年 MOMO. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{

    var tableView:UITableView!
    var headerView:InfiniteScrollingView!
    var bottomInset:CGFloat!
    var AppStoreTVCellIdentifier = "AppStoreTVCell"
    var headerHeight:CGFloat = 130.0
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.bottomInset = 0.0
        
        tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib.init(nibName: "AppStoreTVCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: AppStoreTVCellIdentifier)
        
        // 初始
        headerView =  InfiniteScrollingView.init(frame:  CGRectMake(0, -headerHeight, self.view.frame.size.width, headerHeight))
        
        // 添加到tableView上
        tableView.addSubview(headerView)
        
        // 设置tableView的contentInset
        tableView.contentInset = UIEdgeInsets.init(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        // 添加观察（contentOffset）
        self.tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        if keyPath == "contentOffset"
        {
            if tableView.contentOffset.y < -164
            {
                self.headerView.frame = CGRectMake(0,self.tableView.contentOffset.y + 64,self.view.frame.size.width,headerHeight)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = self.tableView.dequeueReusableCellWithIdentifier(AppStoreTVCellIdentifier, forIndexPath: indexPath)
        cell = NSBundle.mainBundle().loadNibNamed("AppStoreTVCell", owner: nil, options: nil).last as! AppStoreTVCell
        return cell
    }
}

extension ViewController : UITableViewDelegate
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 225
    }
}

