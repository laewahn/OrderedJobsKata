//
//  JobQueue.h
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 21/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobQueue : NSObject

- (NSString *)scheduledJobs;
- (void)addJob:(NSString *)aJob;
- (void)addJob:(NSString *)aJob dependsOn:(NSString *)dependency;
@end
