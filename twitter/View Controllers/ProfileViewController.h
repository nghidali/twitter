//
//  ProfileViewController.h
//  twitter
//
//  Created by Natalie Ghidali on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "User.h"
@interface ProfileViewController : UIViewController

@property (strong, nonatomic) TweetCell * tweetCell;
@property (strong, nonatomic) User * user;

@end
