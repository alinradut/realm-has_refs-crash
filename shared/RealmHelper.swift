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

    static func startWriteTest(onUpdate: @escaping ((Int) -> Void)) {
        let realm = readWriteInstance()

        realm.beginWrite()
        realm.deleteAll()
        try? realm.commitWrite()

        var tx: Int = 0
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = readWriteInstance()

            print("test started")

            while true {
                realm.beginWrite()
                print("transaction \(tx) started")

                for _ in 0..<100 {
                    let contact = SVContact()
                    contact.identifier = UUID().uuidString
                    contact.property1 = UUID().uuidString
                    realm.add(contact)
                }

                do {
                    try realm.commitWrite()
                    print("transaction \(tx) committed")
                    DispatchQueue.main.async {
                        onUpdate(tx)
                    }
                }
                catch {
                    print("error while committing \(tx): \(error)")
                }
                tx += 1
            }
        }
    }

    static func startReadTest(onUpdate: @escaping ((Int) -> Void)) {

        DispatchQueue.global(qos: .default).async {

            while true {
                autoreleasepool {
                    let realm = readWriteInstance()
                    let objects = realm.objects(SVContact.self)
                    let count = Array(objects).count
                    print("fetched \(count) records")
                    sleep(1)
                    DispatchQueue.main.async {
                        onUpdate(count)
                    }
                }
            }
        }
    }
}
