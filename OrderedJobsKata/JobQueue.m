//
//  JobQueue.m
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 09/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import "JobQueue.h"

@interface JobQueue () {
	NSMutableArray* _jobs;
}
@end


@implementation JobQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _jobs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addJob:(NSString *)someJob
{
	if (![_jobs containsObject:someJob]) {
		[_jobs addObject:someJob];
	}
}

- (void) addJob:(NSString *)someJob dependingOnJob:(NSString *)dependencyJob
{
	[self addJob:dependencyJob];
	
	NSUInteger indexOfDependency = [_jobs indexOfObject:dependencyJob];
	
	[_jobs insertObject:someJob atIndex:indexOfDependency+1];
}

- (void) job:(NSString *)someJob dependsOnJob:(NSString *)someOtherJob
{
	NSUInteger indexOfDependingJob = [_jobs indexOfObject:someJob];
}

- (NSString *) scheduledJobs
{
	return [_jobs componentsJoinedByString:@""];
}



@end
