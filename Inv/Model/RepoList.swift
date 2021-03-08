//
//  RepoList.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//
import RealmSwift
import Foundation

class RepoList {
    
    func queryListFromRealm() -> Results<MyRepos>? {
       var repos: Results<MyRepos>?
        do {
            let realm = try Realm()
            repos = realm.objects(MyRepos.self)
            
        } catch let error as NSError {
            print("ALARM ERROR________")
            print(error)
        }
        return repos
    }
    
    func saveToList(_ repo: MyRepos) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(repo)
           
            }
        } catch let error as NSError {
            print("ALARM ERROR________")
            print(error)
        }
    }
    
    func deleteRepoFromRealm(_ id: String) {
        do {
            let realm = try Realm()
            let tmp = realm.objects(MyRepos.self).filter("id == %@", id)
            print(tmp)
            try! realm.write {
                realm.delete(tmp)
            }
        } catch let error as NSError {
            print("ALARM ERROR________")
            print(error)
        }
    }
    
    func checkUnique(_ id: String) -> Bool {
        var flag = false
        do {
            let realm = try Realm()
            guard let tmp = realm.object(ofType: MyRepos.self, forPrimaryKey: id) else { return flag}
            print(tmp)
            flag = true
        } catch let error as NSError {
            print("ALARM ERROR________")
            print(error)
        }
        return flag
    }
    
}

class MyRepos: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var specification = ""
    @objc dynamic var language = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
