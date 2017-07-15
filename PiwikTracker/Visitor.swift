//
//  Visitor.swift
//  PiwikTracker
//
//  Created by Cornelius Horstmann on 26.02.17.
//  Copyright © 2017 PIWIK. All rights reserved.
//

import Foundation

struct Visitor {
    /// Unique ID per visitor (device in this case). Should be
    /// generated upon first start and never changed after.
    /// api-key: _id
    let id: String
    
    /// An optional user identifier such as email or username.
    /// api-key: uid
    let userId: String?
}

extension Visitor {
    static func current(in piwikUserDefaults: PiwikUserDefaults) -> Visitor {
        var piwikUserDefaults = piwikUserDefaults
        guard let id = piwikUserDefaults.clientId else {
            piwikUserDefaults.clientId = newVisitorID()
            return current(in: piwikUserDefaults)
        }
        let userId: String? = nil // we can add the userid later
        return Visitor(id: id, userId: userId)
    }
    
    static func newVisitorID() -> String {
        let uuid = UUID().uuidString
        let sanitizedUUID = uuid.replacingOccurrences(of: "-", with: "")
        let start = sanitizedUUID.startIndex
        let end = sanitizedUUID.index(start, offsetBy: 16)
        return sanitizedUUID.substring(with: start..<end)
    }
}
