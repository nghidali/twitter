//
//  ComposeViewController.m
//  twitter
//
//  Created by Natalie Ghidali on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TweetButton;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

//close button
- (IBAction)onClick:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onTweetClick:(id)sender {
    [[APIManager shared] postStatusWithText:_tweetTextView.text completion:^(Tweet *tweet, NSError *error){
        if(tweet){
            NSLog(@"😎😎😎 Successfull Post!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Failed to Post");
        }
    }];
}
//Tweet button

- (void)viewDidLoad {
    [super viewDidLoad];
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
