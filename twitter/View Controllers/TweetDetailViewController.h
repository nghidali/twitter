//
//  TweetDetailViewController.h
//  twitter
//
//  Created by Natalie Ghidali on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "Tweet.h"

@interface TweetDetailViewController : UIViewController
@property (strong, nonatomic) TweetCell* tweetCell;
@end
