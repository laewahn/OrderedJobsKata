//
//  OrderedJobsKataTests.m
//  OrderedJobsKataTests
//
//  Created by Dennis Lewandowski on 06.08.14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "JobQueue.h"

@interface OrderedJobsKataTests : XCTestCase {
    JobQueue* testQueue;
    
    NSString* jobA;
    NSString* jobB;
}
@end

@implementation OrderedJobsKataTests

- (void)setUp
{
    testQueue = [[JobQueue alloc] init];
    
    jobA = @"a";
    jobB = @"b";
}

- (void)testEmptyQueueReturnsEmptyString
{
    XCTAssert([testQueue scheduledJobs], @"");
}

- (void)testAddOneJob
{
    [testQueue addJob:jobA];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], jobA);
}

- (void)testIndependentJobsAreScheduledAfterAnother
{
    NSString* firstJob = jobA;
    NSString* secondJob = jobB;
    
    [testQueue addJob:firstJob];
    [testQueue addJob:secondJob];
    
    [self assertThatJob:firstJob isScheduledBefore:secondJob];
}

- (void)testDependenciesAreScheduledBeforeTheirJob
{
    [testQueue addJob:jobB dependsOn:jobA];
    [self assertThatJob:jobA isScheduledBefore:jobB];
}

- (void)testDependenciesAreScheduledBeforeTheirJobIfJobExists
{
    [testQueue addJob:jobB];
    [testQueue addJob:jobA dependsOn:jobB];
}

- (void)testJobsWithDependencyAreScheduledAfterTheirDependencyIfDependencyExists
{
    [testQueue add]
}

- (void)testJobsAreNotScheduledTwice
{
    NSString* aJob = @"a";
    
    [testQueue addJob:aJob];
    [testQueue addJob:aJob];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], aJob);
}

- (void) assertThatJob:(NSString *)firstJob isScheduledBefore:(NSString *)secondJob
{
    XCTAssertTrue([[testQueue scheduledJobs] rangeOfString:firstJob].location < [[testQueue scheduledJobs] rangeOfString:secondJob].location);
}

@end
