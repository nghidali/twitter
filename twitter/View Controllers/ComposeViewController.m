//
//  ComposeViewController.m
//  twitter
//
//  Created by Natalie Ghidali on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TweetButton;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@end

@implementation ComposeViewController

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    self.characterCount.text = [NSString stringWithFormat:@"%lu",140 - [newText length]];
    
    // The new text should be allowed? True/False
    return [newText length] < characterLimit;
}

//close button
- (IBAction)onClick:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onTweetClick:(id)sender {
    [[APIManager shared] postStatusWithText:_tweetTextView.text completion:^(Tweet *tweet, NSError *error){
        if(tweet){
            NSLog(@"😎😎😎 Successfull Post!");
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            NSLog(@"Failed to Post");
        }
    }];
}
//Tweet button

- (void)viewDidLoad {
    [super viewDidLoad];
    _tweetTextView.delegate = self;
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
