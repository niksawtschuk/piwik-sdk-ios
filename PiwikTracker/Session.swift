//
//  Session.swift
//  PiwikTracker
//
//  Created by Cornelius Horstmann on 26.02.17.
//  Copyright © 2017 PIWIK. All rights reserved.
//

import Foundation

struct Session {
    /// The number of sessions of the current user.
    /// api-key: _idvc
    let sessionsCount: Int
    
    /// The timestamp of the previous visit.
    /// Discussion: Should this be now for the first request?
    /// api-key: _viewts
    let lastVisit: Date
    
    /// The timestamp of the fist visit.
    /// Discussion: Should this be now for the first request?
    /// api-key: _idts
    let firstVisit: Date
}

extension Session {
    static func current(in piwikUserDefaults: PiwikUserDefaults) -> Session {
        var piwikUserDefaults = piwikUserDefaults
        guard let firstVisit = piwikUserDefaults.firstVisit else {
            piwikUserDefaults.firstVisit = Date()
            return current(in: piwikUserDefaults)
        }
        let sessionCount = piwikUserDefaults.totalNumberOfVisits
        let lastVisit = piwikUserDefaults.previousVisit ?? Date()
        return Session(sessionsCount: sessionCount, lastVisit: lastVisit, firstVisit: firstVisit)
    }
}
