//
//  User.h
//  twitter
//
//  Created by Natalie Ghidali on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *screenName;
@property (strong,nonatomic) NSString * profilePicURL;
@end
