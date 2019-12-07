//
//  Message.swift
//  RoommateHub
//
//  Created by Geena Kim on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import SQLite3

struct Message {
    var id: Int32
    var content: String
    
    //var changedAlready = false
    let currentTime = Date().time()
}

//coderwall.com date timestamp formatting
extension Date {
    func time() -> String! {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        /*
        let calendar = Calendar.current
        calendar.component(.year, from: date)
        calendar.component(.month, from: date)
        calendar.component(.day, from: date)
*/
        
        return(formattedDate)
    }
}

class MessageManager {
    var database: OpaquePointer? //pointer to database
    
    static let shared = MessageManager() //a singleton (create an instance of this inside of itself to save the connection and only ever have 1 instance of this thing)
    
    private init() { //nobody else can instantiate this class (the private)-compiler will say nO
    }
    
    func connect() {
        if database != nil { //if you connected to query, don't do anything lol ur already connected
            return
        }
        //have to change this part because this only allows local access
        let databaseURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("messages.sqlite")
        
        // where you want to connect (path to filename u created, address of database)
        if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
            print("Error opening database")
            return
        }
        //use this to execute sq commands
        if sqlite3_exec(
            database,
            """
            CREATE TABLE IF NOT EXISTS messages (
                content TEXT
            )
            """, //sqlite3 will automatically create rowid
            nil,
            nil,
            nil
        ) != SQLITE_OK { //check if it's ok/exists
            print("Error creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    func create() -> Int { //make sure ur using the same database pointer so this isn't slow
        connect()
        
        //3 steps to execute query: prepare, execute, finalize
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(
            database,
            "INSERT INTO messages (content) VALUES ('Write a message.')",
            -1,
            &statement,
            nil
        ) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting message")
            }
        }
        else {
            print("Error creating message insert statement")
        }
        
        sqlite3_finalize(statement) //behind the scenes clean up
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    func getMessages() -> [Message] { //
        connect()
        
        var result: [Message] = []
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(database, "SELECT rowid, content FROM messages", -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW { //there is a row
                result.append(Message( //add an element to array
                    id: sqlite3_column_int(statement, 0), //id of a column
                    content: String(cString: sqlite3_column_text(statement, 1))
                ))
            }
        }
        
        sqlite3_finalize(statement) //behind the scenes clean up
        return result
    }
    
    func saveMessage(message: Message) {
        connect()
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(
            database,
            "UPDATE messages SET content = ? WHERE rowid = ?", //? passes data into query (str interpolation would open u up to sql injection attacks). parameter binding passes data into query saFELY
            -1,
            &statement,
            nil
        ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string:  message.content).utf8String, -1, nil) // ? indexes start at 1!!!!!!!! don't forgetttt, swift to sqllite3 format string
            sqlite3_bind_int(statement, 2, message.id)
            if sqlite3_step(statement) != SQLITE_DONE { //execute
                print("Error saving message")
            }
        }
        else {
            print("Error creating message update statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func deleteMessage(message: Message) {
        connect()
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(
            database,
            "DELETE FROM messages WHERE rowid = ?",
            -1,
            &statement,
            nil
        ) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, message.id)
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleting message")
            }
        }
        else {
            print("Error creating message delete statement")
        }
        
        sqlite3_finalize(statement)
    }

}

