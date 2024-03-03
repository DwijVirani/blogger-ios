//
//  Group.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import Foundation



struct Group: Codable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var owner: User // owner's username
    var members: [User]
    // Add other group-related properties as needed
    // CodingKeys enum to specify custom mapping
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case owner
        case members
        // Add other coding keys for additional properties
    }
    
    
    init() {
        self.id = UUID()
        self.title = "NA"
        self.description = "NA"
        self.owner = User()
        self.members = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode values for each key
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        owner = try container.decode(User.self, forKey: .owner)
        members = try container.decode([User].self, forKey: .members)
        // Decode additional properties if any
    }
    
    
    func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           // Encode values for each key
           try container.encode(id, forKey: .id)
           try container.encode(title, forKey: .title)
           try container.encode(description, forKey: .description)
           try container.encode(owner, forKey: .owner)
           try container.encode(members, forKey: .members)
           // Encode additional properties if any
       }
   }
