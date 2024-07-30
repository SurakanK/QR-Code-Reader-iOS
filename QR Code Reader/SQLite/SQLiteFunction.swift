//
//  SQLiteFunction.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 14/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//
import Foundation
import SQLite

struct Person: Identifiable {
    var id = UUID()
    var subject: String
    var type: String
    var favorite : String
    var imageQr: Data
    var Date: String
    var IDlist: String
    var imageicon: Data
    var TextScane:String
    var Create: Bool
}

class SQLiteHelper{
    
    var db: Connection!
    
    let personsTable = Table("QRcode")
    let id = Expression<Int>("id")
    let subject = Expression<String>("subject")
    let type = Expression<String>("type")
    let favorite = Expression<String>("favorite")
    let imageQr = Expression<Data>("imageQr")
    let Date = Expression<String>("Date")
    let IDlist = Expression<String>("IDlist")
    let imageicon = Expression<Data>("imageicon")
    let TextScane = Expression<String>("TextScane")
    let Create = Expression<Bool>("Create")
    
    init() {
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let dbTemp = try Connection("\(path)/myDb.sqlite3") //Create db if not existing
            self.db = dbTemp
        }
        catch {
            print("Error info: \(error)")
        }
    }

    public func insertData(subjectVal: String,
                           typeVal: String,
                           favoriteVal: String,
                           imageQrVal: Data,
                           dateVal: String,
                           IDlistVal:String,
                           imageiconVal:Data,
                           TextScaneVal:String,
                           isCreate:Bool){

        do{
            //Create a new table only if it does not exist yet
            try db.run(personsTable.create(ifNotExists: true) { t in      // CREATE TABLE "person" (
                t.column(id, primaryKey: true)          //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(subject)                       //     "subject" TEXT,
                t.column(type)                          //     "type" TEXT,
                t.column(favorite)                      //     "favorite" TEXT,
                t.column(imageQr)                       //     "imageQr" TEXT,
                t.column(Date)                          //     "Date" DATETIME)
                t.column(IDlist)
                t.column(imageicon)
                t.column(TextScane)
                t.column(Create)
                
            })
        }
        catch {
            print("The new SQLite3 Table could not be added: \(error)")
        }

        do{
            //Check untitle
            if subjectVal == ""{
                
                var Untitleindex = 0
                var textUntitle = ""
                
                for row in try db.prepare(personsTable) {
                    let Subject = row[subject]
                    
                    //fine Subject Untitle
                    let arrUntitle = Subject.components(separatedBy: "Untitle")
                    if arrUntitle.count > 1 && arrUntitle.last != ""{
                        if Int(arrUntitle.last!)! >= Untitleindex{
                            Untitleindex = Int(arrUntitle.last!)! + 1
                        }
                    }else{
                        if Untitleindex == 0{
                            Untitleindex = 1
                        }
                    }
                   
                }
                
                if Untitleindex > 0{
                    textUntitle = "Untitle" + String(Untitleindex)
                }else{
                    textUntitle = "Untitle"
                }
                
                try db.run(personsTable.insert(subject <- textUntitle,
                                               type <- typeVal,
                                               favorite <- favoriteVal,
                                               imageQr <- imageQrVal,
                                               Date <- dateVal,
                                               IDlist <- IDlistVal,
                                               imageicon <- imageiconVal,
                                               TextScane <- TextScaneVal,
                                               Create <- isCreate
                                               
                ))
                                
            }else{
    
                try db.run(personsTable.insert(subject <- subjectVal,
                                               type <- typeVal,
                                               favorite <- favoriteVal,
                                               imageQr <- imageQrVal,
                                               Date <- dateVal,
                                               IDlist <- IDlistVal,
                                               imageicon <- imageiconVal,
                                               TextScane <- TextScaneVal,
                                               Create <- isCreate
                ))
                
            }
            
            //reset filter history
            NotificationCenter.default.post(name: NSNotification.Name("RefilterHistory"), object: nil)

            print("insertData")
            
        }
        catch {
            print("Could not insert row: \(error)")
        }
    }
    
    public func getData() -> [Person]{
        
        var persons = [Person]()
        
        do{
            for row in try db.prepare(personsTable) {
                
                let person: Person = Person(subject: row[subject],
                                            type: row[type],
                                            favorite: row[favorite],
                                            imageQr: row[imageQr],
                                            Date: row[Date],
                                            IDlist: row[IDlist],
                                            imageicon: row[imageicon],
                                            TextScane: row[TextScane],
                                            Create: row[Create])
                                            

                persons.append(person)
            }
        }
        catch {
            print("Could not get row: \(error)")
        }
        
        return persons
    }
    
    public func DeleteRow(ID:String){
        
        let alice = personsTable.filter(IDlist == ID)
        do {
            if try db.run(alice.delete()) > 0{
                print("deleted alice")
            } else {
                print("alice not found")
            }
        } catch {
            print("delete failed: \(error)")
        }
    
    }
    
    public func DeleteTable(){
        
        do {
           try db.run(personsTable.delete())
        } catch {
            print("delete failed: \(error)")
        }
    
    }
    
    public func EdittingSubjectRow(ID:String , SubjectUpdate:String){
        let alice = personsTable.filter(IDlist == ID)
        do {
            if try db.run(alice.update(subject <- SubjectUpdate)) > 0 {
                print("updated alice")
            } else {
                print("alice not found")
            }
        } catch {
            print("update failed: \(error)")
        }
    }
    
    public func EdittingFavoriteRow(ID:String , FavoriteUpdate:String){
        let alice = personsTable.filter(IDlist == ID)
        do {
            if try db.run(alice.update( favorite <- FavoriteUpdate)) > 0 {
                print("updated alice")
            } else {
                print("alice not found")
            }
        } catch {
            print("update failed: \(error)")
        }
    }
    
}
