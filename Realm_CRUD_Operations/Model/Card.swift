//
//  Card.swift
//  Realm_CRUD_Operations
//
//  Created by Maxim Macari on 5/1/21.
//

import SwiftUI
import RealmSwift

class Card: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
}
