//
//  Blog.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import Foundation

struct Blog: Codable, Identifiable{
    var id: UUID 
    var title: String
    var imageName:String
    var content: String
    var author: String //stores pen name
    var group : Group
    var authorObject: User
    var datePosted: String
    // Add other blog-related properties as needed

    // CodingKeys enum to specify custom mapping
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageName
        case content
        case author
        case group
        case authorObject
        case datePosted
        // Add other coding keys for additional properties
    }

    init() {
        self.id = UUID()
        self.title = "NA"
        self.imageName = "NA"
        self.content = "NA"
        self.author = "NA"
        self.group = Group()
        self.authorObject = User()
        self.datePosted = "NA"
    }
    // Initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode values for each key
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        imageName = try container.decode(String.self, forKey: .imageName)
        content = try container.decode(String.self, forKey: .content)
        author = try container.decode(String.self, forKey: .author)
        group = try container.decode(Group.self, forKey: .group)
        authorObject = try container.decode(User.self, forKey: .authorObject)
        datePosted = try container.decode(String.self, forKey: .datePosted)
        // Decode additional properties if any
    }
    // Function for encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        // Encode values for each key
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(content, forKey: .content)
        try container.encode(author, forKey: .author)
        try container.encode(group, forKey: .group)
        try container.encode(authorObject,forKey: .authorObject)
        try container.encode(datePosted, forKey: .datePosted)
        // Encode additional properties if any
    }
}
