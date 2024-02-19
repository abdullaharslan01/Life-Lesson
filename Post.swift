//
//  Post.swift
//  firebaseLearn
//
//  Created by abdullah on 19.02.2024.
//

import Foundation

class Post {
    
    var email: String?
    var comment: String?
    var imageUrl: String?
    
    init(email: String? = nil, comment: String? = nil, imageUrl: String? = nil) {
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
    }
    
}
