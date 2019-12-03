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
    var firstName, middleName, lastName: String
    var username, hometown, concentration: String
    var year, age: Int
}

class RoommateManager {
    var database: OpaquePointer!
    
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
        ).appendingPathComponent("notes.sqlite")
        
        if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
            print("Error opening database")
            return
        }
        
        if sqlite3_exec(database,"CREATE TABLE IF NOT EXISTS roommates (firstName TEXT, middleName TEXT, lastName TEXT, username TEXT, hometown TEXT, concentration TEXT, year INTEGER, age INTEGER)", nil, nil, nil) != SQLITE_OK {
            print("Error creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    // Fill database with dummy profiles before implementing sign-in/sign-up feature
    func fillDummyData() {
       connect()
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "INSERT INTO roommates (firstName, middleName, lastName, username, hometown, concentration, year, age) VALUES ('Jeremy', 'E', 'Hsu', 'HsuJeremy', 'Los Altos', 'Computer Science', 2023, 18)", -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error adding roommate profile")
            }
            print("Set up")
        } else {
            print("Error creating roommate insert statement")
        }
        
        sqlite3_finalize(statement)
    }
    
//    // Create new user profile
//    func createRoommate() -> Int {
//        connect()
//
//        var statement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(
//            database,
//            "INSERT INTO notes (content) VALUES ('Write a note!')",
//            -1,
//            &statement,
//            nil
//        ) == SQLITE_OK {
//            if sqlite3_step(statement) != SQLITE_DONE {
//                print("Error inserting note")
//            }
//        }
//        else {
//            print("Error creating note insert statement")
//        }
//
//        sqlite3_finalize(statement)
//        return Int(sqlite3_last_insert_rowid(database))
//    }
    
    // Get all the roommate profiles
    func getRoommates() -> [Roommate] {
        connect()
        
        var result: [Roommate] = []
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(database, "SELECT rowid, lastName, firstName FROM roommates", -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(Roommate(
                    id: sqlite3_column_int(statement, 0),
                    firstName: String(cString: sqlite3_column_text(statement, 1)),
                    middleName: String(cString: sqlite3_column_text(statement, 2)),
                    lastName: String(cString: sqlite3_column_text(statement, 3)),
                    username: String(cString: sqlite3_column_text(statement, 4)),
                    hometown: String(cString: sqlite3_column_text(statement, 5)),
                    concentration: String(cString: sqlite3_column_text(statement, 6)),
                    year: Int(sqlite3_column_int(statement, 7)),
                    age: Int(sqlite3_column_int(statement, 8))
                ))
            }
        }
        
        sqlite3_finalize(statement)
        return result
    }
    
//    // Save roommate profile
//    func saveNote(note: Note) {
//        connect()
//
//        var statement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(database, "UPDATE notes SET content = ? WHERE rowid = ?", -1, &statement, nil) == SQLITE_OK {
//            sqlite3_bind_text(statement, 1, NSString(string: note.content).utf8String, -1, nil)
//            sqlite3_bind_int(statement, 2, note.id)
//            if sqlite3_step(statement) != SQLITE_DONE {
//                print("Error saving note")
//            }
//        } else {
//            print("Error creating note update statement")
//        }
//
//        sqlite3_finalize(statement)
//    }
     
//    // Remove roommate profile
//    func delete(note: Note) {
//    connect()
//
//    var statement: OpaquePointer? = nil
//    if sqlite3_prepare_v2(database, "DELETE FROM notes WHERE rowid = ?", -1, &statement, nil) == SQLITE_OK {
//            sqlite3_bind_int(statement, 1, note.id)
//        if sqlite3_step(statement) != SQLITE_DONE {
//            print("Error deleting note")
//        }
//    } else {
//        print("Error creating note delete statement")
//    }
//
//    sqlite3_finalize(statement)
//    }
}


