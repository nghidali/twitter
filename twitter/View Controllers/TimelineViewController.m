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
#import "InfiniteScrollActivityView.h"
#import "ProfileViewController.h"

@interface TimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *tweets;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property InfiniteScrollActivityView* loadingMoreView;
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
    
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    _loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    _loadingMoreView.hidden = true;
    [self.tableView addSubview:_loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
    
    [self GetTimeline];
}
- (void)tweetCell: (TweetCell *) tweetCell didTap: (User *) user{
    [self performSegueWithIdentifier:@"profileSegue" sender:tweetCell];
}

/*-(void) scrollViewDidScroll:(UIScrollView *) scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && !self.isMoreDataLoading )
        
        {
            self.isMoreDataLoading = true;
            
            // Update position of loadingMoreView, and start loading indicator
            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            _loadingMoreView.frame = frame;
            [_loadingMoreView startAnimating];
            
            [self loadData];
        }
    }
}*/

-(void) loadData {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletionReload:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [Tweet tweetsWithArray:tweets];
            // Stop the loading indicator
            [self->_loadingMoreView stopAnimating];
            [self.tableView reloadData];
            self.isMoreDataLoading = false;
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

-(void) GetTimeline {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [Tweet tweetsWithArray:tweets];
            //self.isMoreDataLoading = true;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    tweetCell.delegate = self;
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
    }
    else if ([segue.identifier isEqualToString:@"profileSegue"]){
        TweetCell *cell = (TweetCell *) sender; //this aint right
        ProfileViewController *profileViewController = segue.destinationViewController;
        profileViewController.tweetCell = cell;
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
