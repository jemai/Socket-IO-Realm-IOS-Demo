//
//  ViewController.swift
//  SocketIoRealmSample
//
//  Created by Abdelhak Jemaii on 08/03/2017.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    let cellId = "FeedCollectionCell"
    var notificationToken: NotificationToken? = nil
    
    
    
    lazy var collection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(FeedCollectionCell.self, forCellWithReuseIdentifier: "FeedCollectionCell")
        collection.backgroundColor = .white
        collection.contentMode = .center
        return collection
    }()
    
    
    var dataSource : Results<Feed>?{
        didSet {
            self.collection.reloadData()
        }
    }
    
    func initDataSource(){
        dataSource = FeedDAO.getAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: view.topAnchor , constant: 44).isActive = true
        collection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collection.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //
        FeedDAO.deleteAll()
        initDataSource()
        registerForNotif()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (timer) in
            SocketManager.shared.testingResult(input: "Hello Dear server") { (result) in
                let feed = Feed()
                if result.count == 0 {
                    return
                }
                
                if let text = result[0] as? String {
                    feed.title = text
                }
                
                if let text = result[1] as? String {
                    feed.content = text
                }
                
                if !feed.title.isEmpty || !feed.content.isEmpty {
                    FeedDAO.insert(feed: feed)
                }
            }
        }
        
    }
    
    
    //
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = dataSource {
            return data.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCollectionCell
        if let data = dataSource {
            cell.title.text = data[indexPath.item].title
            cell.label.text = data[indexPath.item].content
        } else {
            cell.backgroundColor = .red
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width*0.9, height: 100)
    }
    
    
    // MARK: - Realm notification
    
    func registerForNotif(){
        notificationToken = dataSource?.addNotificationBlock({ (changes) in
            switch changes {
            case .initial:
                self.collection.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                
                if deletions != nil || insertions != nil || modifications != nil {
                    self.collection.reloadData()
                }
            default :
                debugPrint(changes)
            }
        })
    }
    
    deinit {
        notificationToken?.stop()
    }
    
}



