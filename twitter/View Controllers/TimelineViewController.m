//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "User.h"
#import "TweetCell.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TweetDetailViewController.h"

@interface TimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tweets;
@end

@implementation TimelineViewController 
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = 200;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    [super viewDidLoad];
    [self GetTimeline];
}

-(void) GetTimeline {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [Tweet tweetsWithArray:tweets];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [tweetCell setAttributes:self.tweets[indexPath.row]];
    return tweetCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.tweets.count;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self GetTimeline];
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"composeSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self; //this line breaks logout
    }
    else if ([segue.identifier isEqualToString:@"detailTweetSegue"]){
        TweetCell *cell = (TweetCell *) sender;
        TweetDetailViewController *tweetDetailViewController = segue.destinationViewController;
        tweetDetailViewController.tweetCell = cell;
        /*NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if(indexPath != nil){
            Tweet* clickedTweet = self.tweets[indexPath.row];
            TweetDetailViewController *tweetDetailViewController = segue.destinationViewController;
            tweetDetailViewController.tweet = clickedTweet;
        }*/
    }
}

- (void)didTweet:(Tweet *)tweet {
    //[_tweets addObject:tweet];
    [_tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

@end
