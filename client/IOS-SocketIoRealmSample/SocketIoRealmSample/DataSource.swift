//
//  DataSource.swift
//  SocketIoRealmSample
//
//  Created by Abdelhak Jemaii on 30/03/2017.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import RealmSwift

class Feed : Object {
    
    //
    dynamic var title = ""
    dynamic var content = ""
    
    //    
}

class FeedDAO {
    
    /*
     *
     * *** // MARK: - readers
     *
     */
    
    //read all Publications objects
    class func getAll() -> Results<Feed>?{
        let realm = try! Realm()
        let pubs = realm.objects(Feed.self)
        return pubs
    }
    
    /*
     *
     * *** // MARK: - writers
     *
     */
    
    //insert Publications
    class func insert(feeds :[Feed]?)    {
        if let feeds = feeds{
            let realm = try! Realm()
            try! realm.write {
                realm.add(feeds, update: true)
            }
            
        }
    }
    
    //insert Publication
    class func insert(feed: Feed)    {
        let realm = try! Realm()
        try! realm.write{
            realm.add(feed)
        }
    }
    
    class func deleteAll(){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Feed.self))
        }
    }

}
