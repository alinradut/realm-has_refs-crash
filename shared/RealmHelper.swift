//
//  RealmHelper.swift
//  realmcrash
//
//  Created by Alin Radut on 11/2/23.
//

import Foundation
import RealmSwift

class RealmHelper {

    static var encryptedRealmURL: URL {
        let directory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.example.realmcrash")!
        return directory.appendingPathComponent("shared.realm")
    }

    static let encryptionKey: Data = Data(repeating: 97, count: 64)

    static func readWriteInstance() -> Realm {
        let configuration: Realm.Configuration = .init(fileURL: encryptedRealmURL, encryptionKey: encryptionKey)
        return try! Realm(configuration: configuration)
    }

    static func readOnlyInstance() -> Realm {
        let configuration: Realm.Configuration = .init(fileURL: encryptedRealmURL, encryptionKey: encryptionKey, readOnly: true)
        return try! Realm(configuration: configuration)
    }

    static func startWriteTest() {
        let realm = readWriteInstance()

        realm.beginWrite()
        realm.deleteAll()
        try? realm.commitWrite()

        DispatchQueue.global(qos: .userInitiated).async {
            let realm = readWriteInstance()

            print("test started")
            for i in 0..<UInt64.max {
                realm.beginWrite()
                if i % 100 == 0 {
                    print("transaction \(i) started")
                }
                let contact = SVContact()
                contact.identifier = UUID().uuidString
                contact.property1 = UUID().uuidString
                realm.add(contact)
                try? realm.commitWrite()
                if i % 100 == 0 {
                    print("transaction \(i) committed")
                }
            }
        }
    }

    static func startReadTest() {

        DispatchQueue.global(qos: .default).async {

            while true {
                let realm = readOnlyInstance()
                let objects = realm.objects(SVContact.self)
                print("fetched \(Array(objects).count) records")
            }
        }
    }
}
