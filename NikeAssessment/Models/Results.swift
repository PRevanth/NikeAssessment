//
//  Results.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

struct Results: Codable {
    let id: String
    let artistId: String
    let artistName: String
    let name: String
    let artworkUrl100: String
    let releaseDate: String
    let copyright: String?
    let genres: [Genres]
    let url: String
}
