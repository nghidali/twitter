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
#import "APIManager.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

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
    if(!_tweetCell){
        [self GetProfile];
        User * u = self.user;
        self.followingLabel.text = [NSString stringWithFormat:@"%lu", u.followingCount];
        self.followersLabel.text = [NSString stringWithFormat:@"%lu", u.followersCount];;
        self.tweetsLabel.text = [NSString stringWithFormat:@"%lu", u.tweetCount];
    }
    Tweet * t = _tweetCell.tweet;
    User * u = t.user;
    NSString *backgroundPathString = u.backgroundURL;
    if(backgroundPathString != (id)[NSNull null] && backgroundPathString.length != 0){
        NSURL *backgroundUrl = [NSURL URLWithString:backgroundPathString];
        NSURLRequest *brequest = [NSURLRequest requestWithURL:backgroundUrl];
        
        [self.backgroundView setImageWithURLRequest:brequest placeholderImage:nil
                                           success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
                                               
                                               // imageResponse will be nil if the image is cached
                                               if (imageResponse) {
                                                   NSLog(@"Image was NOT cached, fade in image");
                                                   self.backgroundView.image = image;
                                               }
                                               else {
                                                   NSLog(@"Image was cached so just update the image");
                                                   self.backgroundView.image = image;
                                               }
                                           } failure:^(NSURLRequest *brequest, NSHTTPURLResponse * response, NSError *error) {
                                               NSLog(@"FAILURE!!!!!!!!");
                                           }];
    }
    self.followingLabel.text = [NSString stringWithFormat:@"%lu", u.followingCount];
    self.followersLabel.text = [NSString stringWithFormat:@"%lu", u.followersCount];;
    self.tweetsLabel.text = [NSString stringWithFormat:@"%lu", u.tweetCount];
    self.profilePic.image = _tweetCell.profilePic.image;
    /*if(_tweetCell.backgroundPic){
        self.backgroundView.image = _tweetCell.backgroundPic.image;
    }*/
    // Do any additional setup after loading the view.
}

-(void) GetProfile {
    // Get timeline
    [[APIManager shared] getProfile:^void(NSDictionary * userdict, NSError *error) {
        if (userdict) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            User * user = [[User alloc] initWithDictionary:userdict];
            self.user = user;
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
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
