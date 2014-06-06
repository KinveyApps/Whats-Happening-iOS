//
//  TodayViewController.m
//  WhatsHappening
//
//  Created by Michael Katz on 6/5/14.
//  Copyright (c) 2014 Kinvey. All rights reserved.
//

#import "TodayViewController.h"
#import <KinveyKit/KinveyKit.h>

@import WhatsHappeningKinveyWrapper;

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor]; //revert back to clear since SB has black to make text legible
}

- (void) getPost:(void (^)(NCUpdateResult))completionHandler {
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[KinveyHandler sharedInstance] getPost:^(NSString *title, NSError *error) {
        if (!error) {
            self.textLabel.text = [NSString stringWithFormat:@"Last Event Was A '%@'", title];
        }
    }];

}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
    [[KinveyHandler sharedInstance] getPost:^(NSString *title, NSError *error) {
        if (error) {
            completionHandler(NCUpdateResultFailed);
        } else {
            self.textLabel.text = [NSString stringWithFormat:@"Last Event Was A '%@'", title];
            completionHandler(NCUpdateResultNewData);
        }
    }];
}

@end
