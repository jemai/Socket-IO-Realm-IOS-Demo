//
//  SocketManager.swift
//  SocketIoRealmSample
//
//  Created by Abdelhak Jemaii on 08/03/2017.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import SocketIO

class SocketManager {
    
    var socket : SocketIOClient? = nil
    
    static let shared : SocketManager = {
        let instance = SocketManager()
        return instance
    }()
    
    func connect(){
        socket?.connect()
    }
    
    func testingResult(input: String, completion: @escaping (_ result: [Any]) -> Void) {
        
        socket?.emit("test", input)
        
        
        socket?.on("test") {data, ack in
            completion(data)
        }
        
    }
    
    func testingFeeds(input: String, completion: @escaping (_ result: String) -> Void) {
        
        socket?.emit("feed", input)
        
        
        socket?.on("feed") {data, ack in
            completion("success \(data)")
        }
        
        
    }
    
    
}
