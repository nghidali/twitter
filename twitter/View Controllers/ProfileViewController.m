//
//  ProfileViewController.m
//  twitter
//
//  Created by Natalie Ghidali on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Tweet * t = _tweetCell.tweet;
    User * u = t.user;
    self.followingLabel.text = [NSString stringWithFormat:@"%lu", u.followingCount];
    self.followersLabel.text = [NSString stringWithFormat:@"%lu", u.followersCount];;
    self.tweetsLabel.text = [NSString stringWithFormat:@"%lu", u.tweetCount];
    self.profilePic.image = _tweetCell.profilePic.image;
    if(_tweetCell.backgroundPic){
        self.backgroundView.image = _tweetCell.backgroundPic.image;
    }
    // Do any additional setup after loading the view.
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
