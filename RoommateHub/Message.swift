//
//  Message.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Message {
  // var id: Int32
  var content: String
  var currentTime: String
}

class MessageManager {
  var database: OpaquePointer?
  
  // Create singleton
  static let shared = MessageManager()
  
  private init() {}
}
