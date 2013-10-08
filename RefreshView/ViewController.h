//
//  ViewController.h
//  RefreshView
//
//  Created by xuwf on 13-9-29.
//  Copyright (c) 2013年 xuwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

- (IBAction)onDownUpPullButtonPressed:(id)sender;
- (IBAction)onRightLeftPullButtonPressed:(id)sender;

@end
