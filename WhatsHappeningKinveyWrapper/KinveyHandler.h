//
//  KinveyHandler.h
//  Whats Happening
//
//  Created by Michael Katz on 6/5/14.
//  Copyright (c) 2014 Kinvey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KCSUser;

@interface KinveyHandler : NSObject

+ (instancetype) sharedInstance;
- (KCSUser*)user;
- (void) getPost:(void(^)(NSString* title, NSError* error))completion;

@end
