//
//  TweetCell.m
//  twitter
//
//  Created by Natalie Ghidali on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "User.h"
#import "Tweet.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setAttributes: (Tweet*)tweet {
    User* user = [tweet user];
    self.userLabel.text = [user name];
    self.bodyLabel.text = [tweet text];
    self.dateLabel.text = [tweet createdAtString];
    self.screenName.text = [tweet screenName];
    self.retweet.text = [NSString stringWithFormat:@"%i",[tweet retweetCount]];
    self.like.text = [NSString stringWithFormat:@"%i",[tweet favoriteCount]];
    
    NSString *posterPathString = user.profilePicURL;
    NSURL *url = [NSURL URLWithString:posterPathString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak TweetCell *weakSelf = self;
    [self.profilePic setImageWithURLRequest:request placeholderImage:nil
                                         success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
        
        // imageResponse will be nil if the image is cached
        if (imageResponse) {
            NSLog(@"Image was NOT cached, fade in image");
            weakSelf.profilePic.alpha = 0.0;
            weakSelf.profilePic.image = image;
            
            //Animate UIImageView back to alpha 1 over 0.3sec
            [UIView animateWithDuration:1.5 animations:^{
                weakSelf.profilePic.alpha = 1.0;
            }];
        }
        else {
            NSLog(@"Image was cached so just update the image");
            weakSelf.profilePic.image = image;
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
        NSLog(@"FAILURE!!!!!!!!");
    }];
}
@end
