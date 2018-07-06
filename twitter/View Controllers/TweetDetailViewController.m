//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Natalie Ghidali on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "TweetCell.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *retweet;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userLabel.text = _tweetCell.userLabel.text;
    self.screenName.text = _tweetCell.screenName.text;
    self.bodyLabel.text = _tweetCell.bodyLabel.text;
    self.dateLabel.text = _tweetCell.dateLabel.text;
    self.profilePic.image = _tweetCell.profilePic.image;
    self.comment.text = _tweetCell.comment.text;
    self.retweet.text = _tweetCell.retweet.text;
    self.like.text = _tweetCell.like.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
