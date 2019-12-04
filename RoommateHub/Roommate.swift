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

struct Roommate {
    var id: Int32
    var firstName, lastName: String
    var username, hometown, concentration: String
    var year, age: Int
    // var firstName: String
}

class RoommateManager {
    var database: OpaquePointer?
    
    static let shared = RoommateManager()
    
    private init () {}
    
    // Connect to SQLite3 database
    func connect() {
        if database != nil {
            return
        }
        
        let databaseURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("roommates.sqlite")
        
        if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
            print("Error opening database")
            return
        }
        
        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS roommates (firstName TEXT, lastName TEXT, username TEXT, hometown TEXT, concentration TEXT, year INTEGER, age INTEGER)", nil, nil, nil) != SQLITE_OK {
            print("Error creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    // Fill database with dummy profiles before implementing sign-in/sign-up feature
    func fillDummyData() {
       connect()
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "INSERT INTO roommates (firstName, lastName, username, hometown, concentration, year, age) VALUES ('Geena', 'Kim', 'GnaKim', 'Staten Island', 'Computer Science', 2023, 18)", -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error adding roommate profile")
            }
        } else {
            print("Error creating roommate insert statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    // Get all the roommate profiles
    func getRoommates() -> [Roommate] {
        connect()
        
        var result: [Roommate] = []
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(database, "SELECT rowid, firstName, lastName, username, hometown, concentration, year, age FROM roommates ORDER BY lastName, firstName ASC", -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(Roommate(
                    id: sqlite3_column_int(statement, 0),
                    firstName: String(cString: sqlite3_column_text(statement, 1)),
                    lastName: String(cString: sqlite3_column_text(statement, 2)),
                    username: String(cString: sqlite3_column_text(statement, 3)),
                    hometown: String(cString: sqlite3_column_text(statement, 4)),
                    concentration: String(cString: sqlite3_column_text(statement, 5)),
                    year: Int(sqlite3_column_int(statement, 6)),
                    age: Int(sqlite3_column_int(statement, 7))
                ))
                
                print(result.last)
            }
        }
        
        sqlite3_finalize(statement)
        return result
    }
    
    func clear() {
        connect()
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "DELETE FROM roommates", -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleting")
            }
        } else {
            print("Error creating the delete statement")
        }
    }
}


