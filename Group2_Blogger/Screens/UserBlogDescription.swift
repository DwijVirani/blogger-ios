//
//  UserBlogDescription.swift
//  Group2_Blogger
//
//  Created by Harsh Goyal on 14/02/24.
//

import SwiftUI

struct UserBlogDescription: View {
    var item : Blog = Blog()
    
    @State private var isFavorited = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image("\(item.imageName)") // Placeholder blog image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200).padding()
                
                HStack {
                    Text("\(item.title)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        isFavorited.toggle()
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .foregroundColor(isFavorited ? .red : .gray)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
                
                Text(item.datePosted)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, -5)
                
                Text(item.content)
                    .padding()
                
                Spacer()
            }
            
            .navigationBarTitle("Post", displayMode: .inline)
        }
    }
}

struct UserBlogDescription_Previews: PreviewProvider {
    static var previews: some View {
        UserBlogDescription()
    }
}
