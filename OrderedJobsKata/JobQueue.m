//
//  JobQueue.m
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 06/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import "JobQueue.h"

@interface JobQueue ()
@property BOOL jobAdded;
@property (strong) NSMutableArray* jobs;
@end

@implementation JobQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _jobs = [NSMutableArray array];
    }
    return self;
}

-(NSString *) sortedJobs;
{
    return [self.jobs componentsJoinedByString:nil];
}

-(void) addJob:(NSString *)aJob
{
    [self.jobs addObject:aJob];
}

@end
