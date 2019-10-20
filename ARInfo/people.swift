//
//  people.swift
//  ARInfo
//
//  Created by Pop on 20/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
struct People {
    var name: String
    var email: String
    var fb_link: String
    var twitter_link: String
    var linkedin_link: String
    var github_link: String
    var website_link: String
    var access_boolean: Bool
    
    
    init(_ dictionary: [String: Any]) {
      self.name = dictionary["name"] as? String ?? ""
      self.email = dictionary["email"] as? String ?? ""
      self.fb_link = dictionary["fb_link"] as? String ?? ""
      self.twitter_link = dictionary["twitter_link"] as? String ?? ""
      self.linkedin_link = dictionary["linkedin_link"] as? String ?? ""
      self.github_link = dictionary["github_link"] as? String ?? ""
      self.website_link = dictionary["website_link"] as? String ?? ""
      self.access_boolean = dictionary["access"] as? Bool ?? false
        
    }
}
