//
//  Roommate.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
//  Integrate code from Notes app for roommate profiles

import Foundation
import SQLite3
import FirebaseDatabase

struct Roommate {
    var firstName, lastName: String
    var hometown, concentration: String
    var gradYear, age: Int
    var cellPhoneNumber: Int
    // var firstName: String
}

class RoommateManager {
    static let shared = RoommateManager()
    let ref = Database.database().reference()
    
    private init() {}
    
//    // Return an Array of all the roommate profiles nested within a specified roomIdentifier
    func getRoommates(roomIdentifier: String) -> [Roommate] {
        var roommates: [Roommate] = []
        
        let group = DispatchGroup()
        group.enter()
        
        ref.child(roomIdentifier).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get NSDictionary of user profiles
            let roommateProfiles = snapshot.value as? NSDictionary
            
            // Unwrap roommateProfiles
            guard let profiles = roommateProfiles else { return }
            
            // Iterate through NSDictionary
            for (key, value) in profiles {
                // Cast profile as a Swift Dictionary
                let profileDict = (value as! [String : Any])
                print(profileDict)
                
                // Unwrap each property of profile
                guard let firstName = profileDict["firstName"] else { return }
                guard let lastName = profileDict["lastName"] else { return }
                guard let hometown = profileDict["hometown"] else { return }
                guard let concentration = profileDict["concetration"] else { return }
                guard let gradYear = profileDict["gradYear"] else { return }
                guard let age = profileDict["age"] else { return }
                guard let cellPhoneNumber = profileDict["cellPhoneNumber"] else { return }
                
                // Append new Roommate to result Array
                roommates.append(Roommate(
                    firstName: firstName as! String,
                    lastName: lastName as! String,
                    hometown: hometown as! String,
                    concentration: concentration as! String,
                    gradYear: gradYear as! Int,
                    age: age as! Int,
                    cellPhoneNumber: cellPhoneNumber as! Int
                ))
                
                group.leave()
//
//                print("JEREMY WE DID IT")
//                print(result)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        group.notify(queue: .main) {
            return roommates
        }
        
        return [] 
    } 
}

//class RoommateManager {
//    var database: OpaquePointer?
//
//    static let shared = RoommateManager()
//
//    private init () {}
//
//    // Connect to SQLite3 database
//    func connect() {
//        if database != nil {
//            return
//        }
//
//        let databaseURL = try! FileManager.default.url(
//            for: .documentDirectory,
//            in: .userDomainMask,
//            appropriateFor: nil,
//            create: false
//        ).appendingPathComponent("roommates1.sqlite")
//
//        if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
//            print("Error opening database")
//            return
//        }
//
//        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS roommates1 (firstName TEXT, lastName TEXT, username TEXT, hometown TEXT, concentration TEXT, year INTEGER, age INTEGER, number TEXT)", nil, nil, nil) != SQLITE_OK {
//            print("Error creating table: \(String(cString: sqlite3_errmsg(database)!))")
//        }
//    }
//
//    // Fill database with dummy profiles before implementing sign-in/sign-up feature
//    func fillDummyData() {
//       connect()
//
//        var statement: OpaquePointer? = nil
//
//        if sqlite3_prepare_v2(database, "INSERT INTO roommates1 (firstName, lastName, username, hometown, concentration, year, age, number) VALUES ('Geena', 'Kim', 'GnaKim', 'Staten Island', 'Computer Science', 2023, 18, '6502184411')", -1, &statement, nil) == SQLITE_OK {
//            if sqlite3_step(statement) != SQLITE_DONE {
//                print("Error adding roommate profile")
//            }
//        } else {
//            print("Error creating roommate insert statement")
//        }
//
//        sqlite3_finalize(statement)
//    }
//
//    // Get all the roommate profiles
//    func getRoommates() -> [Roommate] {
//        connect()
//
//        var result: [Roommate] = []
//        var statement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(database, "SELECT rowid, firstName, lastName, username, hometown, concentration, year, age, number FROM roommates1 ORDER BY lastName, firstName ASC", -1, &statement, nil) == SQLITE_OK {
//            while sqlite3_step(statement) == SQLITE_ROW {
//                result.append(Roommate(
//                    id: sqlite3_column_int(statement, 0),
//                    firstName: String(cString: sqlite3_column_text(statement, 1)),
//                    lastName: String(cString: sqlite3_column_text(statement, 2)),
//                    username: String(cString: sqlite3_column_text(statement, 3)),
//                    hometown: String(cString: sqlite3_column_text(statement, 4)),
//                    concentration: String(cString: sqlite3_column_text(statement, 5)),
//                    year: Int(sqlite3_column_int(statement, 6)),
//                    age: Int(sqlite3_column_int(statement, 7)),
//                    number: String(cString: sqlite3_column_text(statement, 8))
//                ))
//            }
//        }
//
//        sqlite3_finalize(statement)
//        return result
//    }
//
//    func clear() {
//        connect()
//
//        var statement: OpaquePointer? = nil
//
//        if sqlite3_prepare_v2(database, "DELETE FROM roommates1", -1, &statement, nil) == SQLITE_OK {
//            if sqlite3_step(statement) != SQLITE_DONE {
//                print("Error deleting")
//            }
//        } else {
//            print("Error creating the delete statement")
//        }
//    }
//}
//
//
