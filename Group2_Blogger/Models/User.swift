//
//  User.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import Foundation


class User: Codable, CustomStringConvertible, ObservableObject, Identifiable {
    var id: UUID = UUID()
    @Published var email: String
    var password: String
    var name: String
    var phoneNumber: String
    var favourites: [Blog]
    var profileImg: String
    var joinedGroup:[Group]

    var description: String {
        return "User - Name: \(self.name), Email: \(self.email), Password: \(self.password), Phone Number: \(self.phoneNumber)"
    }

    init(email: String, password: String, name: String, phoneNumber: String, favourites: [Blog], profileImg: String, joinedGroup:[Group]) {
        self.email = email
        self.password = password
        self.name = name
        self.phoneNumber = phoneNumber
        self.favourites = favourites
        self.profileImg = profileImg
        self.joinedGroup = joinedGroup
    }

    init() {
        self.email = "NA"
        self.password = "NA"
        self.name = "NA"
        self.phoneNumber = "NA"
        self.favourites = []
        self.profileImg = "N/A"
        self.joinedGroup = []
    }

    enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case phoneNumber
        case favourites
        case profileImg
        case joinedGroup
        // other coding keys for additional properties
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.favourites = try container.decode([Blog].self, forKey: .favourites)
        self.profileImg = try container.decode(String.self, forKey: .profileImg)
        self.joinedGroup = try container.decode([Group].self, forKey: .joinedGroup)

        // decode additional properties if any
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(favourites, forKey: .favourites)
        try container.encode(profileImg, forKey: .profileImg )
        try container.encode(joinedGroup, forKey: .joinedGroup)
    }
}
