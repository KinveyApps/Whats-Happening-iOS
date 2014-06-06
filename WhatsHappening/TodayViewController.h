//
//  TodayViewController.h
//  WhatsHappening
//
//  Created by Michael Katz on 6/5/14.
//  Copyright (c) 2014 Kinvey. All rights reserved.
//

@import UIKit;
@import NotificationCenter;

@interface TodayViewController : UIViewController <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
