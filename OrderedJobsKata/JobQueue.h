//
//  JobQueue.h
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 09/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobQueue : NSObject

- (void) addJob:(NSString *)someJob;
- (void) addJob:(NSString *)someJob dependingOnJob:(NSString *)dependencyJob;

- (void) job:(NSString *)someJob dependsOnJob:(NSString *)someOtherJob;

- (NSString *) scheduledJobs;

@end
