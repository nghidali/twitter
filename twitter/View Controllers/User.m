//
//  User.m
//  twitter
//
//  Created by Natalie Ghidali on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicURL = dictionary[@"profile_image_url_https"];
        self.followersCount = [dictionary[@"followers_count"] longValue];
        self.followingCount = [dictionary[@"friends_count"] longValue];
        self.tweetCount = [dictionary[@"statuses_count"] longValue];
        self.backgroundURL = dictionary[@"profile_background_image_url_https"];
    }
    return self;
}

@end
