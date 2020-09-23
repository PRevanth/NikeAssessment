//
//  RSSFeed.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

struct RSSFeed: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let id: String
    let results: [Results]
}
