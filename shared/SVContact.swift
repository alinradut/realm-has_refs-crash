//
//  SVContact.swift
//  realmcrash
//
//  Created by Alin Radut on 11/2/23.
//

import Foundation
import RealmSwift

class SVContact: Object {

    override class func primaryKey() -> String? {
        return "identifier"
    }

    @objc dynamic var identifier: String!
    @objc dynamic var property1: String!
}
