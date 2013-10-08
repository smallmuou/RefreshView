//
//  ViewController.m
//  RefreshView
//
//  Created by xuwf on 13-9-29.
//  Copyright (c) 2013年 xuwf. All rights reserved.
//

#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface ViewController () <EGORefreshTableHeaderDelegate, UIScrollViewDelegate> {
    EGORefreshTableHeaderView* _PullDownRefreshView;
    EGORefreshTableHeaderView* _PullUpRefreshView;
    EGORefreshTableHeaderView* _PullRightRefreshView;
    EGORefreshTableHeaderView* _PullLeftRefreshView;
    
    UIScrollView* _scrollView;
    BOOL _reloading;
}
@end

@implementation ViewController
@synthesize scrollView = _scrollView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.delegate = self;
    [self onDownUpPullButtonPressed:nil];
    
    _PullDownRefreshView = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.scrollView orientation:EGOPullOrientationDown];
    _PullDownRefreshView.delegate = self;
    
    _PullUpRefreshView = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.scrollView orientation:EGOPullOrientationUp];
    _PullUpRefreshView.delegate = self;
    
    _PullRightRefreshView = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.scrollView orientation:EGOPullOrientationRight];
    _PullRightRefreshView.delegate = self;
    
    _PullLeftRefreshView = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.scrollView orientation:EGOPullOrientationLeft];
    _PullLeftRefreshView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDownUpPullButtonPressed:(id)sender {
    CGSize size = self.scrollView.frame.size;
    size.height +=1;
    self.scrollView.contentSize = size;
    [_PullDownRefreshView adjustPosition];
    [_PullUpRefreshView adjustPosition];
}

- (IBAction)onRightLeftPullButtonPressed:(id)sender {
    CGSize size = self.scrollView.frame.size;
    size.width +=1;
    self.scrollView.contentSize = size;
    [_PullRightRefreshView adjustPosition];
    [_PullLeftRefreshView adjustPosition];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_PullDownRefreshView egoRefreshScrollViewDidScroll:scrollView];
    [_PullUpRefreshView egoRefreshScrollViewDidScroll:scrollView];
    [_PullRightRefreshView egoRefreshScrollViewDidScroll:scrollView];
    [_PullLeftRefreshView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_PullDownRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
    [_PullUpRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
    [_PullRightRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
    [_PullLeftRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)refreshDone {
    _reloading = NO;
    [_PullDownRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
    [_PullUpRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
    [_PullRightRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
    [_PullLeftRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self performSelector:@selector(refreshDone) withObject:nil afterDelay:1.0f];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return _reloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return [NSDate date];
}


@end
