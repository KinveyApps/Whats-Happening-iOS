//
//  KinveyHandler.m
//  Whats Happening
//
//  Created by Michael Katz on 6/5/14.
//  Copyright (c) 2014 Kinvey. All rights reserved.
//

#import "KinveyHandler.h"
#import <KinveyKit/KinveyKit.h>

@implementation KinveyHandler

+ (instancetype) sharedInstance
{
    static KinveyHandler* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance setup];
        [instance login:^{
            
        }];
    });
    return instance;
}


- (void) setup
{
    KCSClientConfiguration* config = [KCSClientConfiguration configurationWithAppKey:@"kid_TTRtv78pQi" secret:@"c2782b9421d94869bc268494cfb0901b"];
    [[KCSClient sharedClient] initializeWithConfiguration:config];
    [KCSClient configureLoggingWithNetworkEnabled:YES debugEnabled:YES traceEnabled:YES warningEnabled:YES errorEnabled:YES];
}

- (void) login:(void(^)())completion
{
    if (![KCSUser activeUser]) {
        [KCSUser loginWithUsername:@"foo" password:@"foo" withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
            NSLog(@"logged in? %@", errorOrNil);
        }];
    }
}

- (KCSUser *)user
{
    return [KCSUser activeUser];
}

- (void) getPost:(void(^)(NSString* title, NSError* error))completion
{
    if (![KCSUser activeUser]) {
        [self login:^{
            [self getPost:completion];
        }];
    } else {
        KCSQuery* query = [KCSQuery query];
        [query addSortModifier:[[KCSQuerySortModifier alloc] initWithField:KCSMetadataFieldLastModifiedTime inDirection:kKCSDescending]];
        query.limitModifer = [[KCSQueryLimitModifier alloc] initWithLimit:1];
        
        KCSCollection* collection = [KCSCollection collectionFromString:@"objects" ofClass:[NSDictionary class]];
        KCSAppdataStore* store = [KCSAppdataStore storeWithCollection:collection options:nil];
        [store queryWithQuery:query withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
            NSString* s = errorOrNil ? [errorOrNil localizedFailureReason] : objectsOrNil[0][@"title"];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(s, errorOrNil);
            });
        } withProgressBlock:nil];

    }
    
}

@end
