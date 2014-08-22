//
//  JobQueue.m
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 21/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import "JobQueue.h"

@interface JobQueue ()
@property(strong) NSString* jobs;
@end

@implementation JobQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _jobs = @"";
    }
    return self;
}

- (NSString *)scheduledJobs
{
    return [self jobs];
}


- (void)addJob:(NSString *)aJob
{
    NSRange rangeOfJob = [self.jobs rangeOfString:aJob];
    if (rangeOfJob.location == NSNotFound) {
        NSString* updatedJobs = [self.jobs stringByAppendingString:aJob];
        [self setJobs:updatedJobs];
    }
}

- (void)addJob:(NSString *)aJob dependsOn:(NSString *)dependency
{
    NSRange rangeOfJob = [self.jobs rangeOfString:aJob];
    if (rangeOfJob.location != NSNotFound) {
        
        NSRange rangeOfDependency = [self.jobs rangeOfString:dependency];
        if (rangeOfDependency.location == NSNotFound) {
            NSString* updatedJobs = [self.jobs stringByReplacingCharactersInRange:rangeOfJob withString:[dependency stringByAppendingString:aJob]];
            [self setJobs:updatedJobs];
        } else {
            NSString* updatedJobs = [self.jobs stringByReplacingOccurrencesOfString:aJob withString:@""];
            updatedJobs = [updatedJobs stringByReplacingOccurrencesOfString:dependency withString:[dependency stringByAppendingString:aJob]];
            [self setJobs:updatedJobs];
        }
    }
    
    [self addJob:dependency];
    [self addJob:aJob];
}

@end
