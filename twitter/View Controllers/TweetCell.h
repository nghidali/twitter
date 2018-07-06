//
//  TweetCell.h
//  twitter
//
//  Created by Natalie Ghidali on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@protocol TweetCellDelegate
//- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
// TODO: Add required methods the delegate needs to implement
@end

@interface TweetCell : UITableViewCell
//@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *retweet;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender;
@property (strong,nonatomic) Tweet *tweet;

- (void) setAttributes: (Tweet*) tweet;
@end
