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
}
@end

@implementation OrderedJobsKataTests

- (void)setUp
{
    testQueue = [[JobQueue alloc] init];
}

- (void)testSimpleJobShouldBeQueued
{
    [testQueue addJob:@"a"];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], @"a");
}

- (void)testIndependentJobsAreQueuedFiFo
{
    [testQueue addJob:@"a"];
    [testQueue addJob:@"b"];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], @"ab");
}

- (void)testJobsAreQueuedBeforeTheirDependency
{
    [testQueue addJob:@"a"];
    [testQueue addJob:@"b" dependingOn:@"a"];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], @"ba");
}

- (void)testDependenciesAreAddedWhenNotAlreadyRegistered
{
    [testQueue addJob:@"a" dependingOn:@"b"];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], @"ab");
}

- (void)testForTransitiveDependencies
{
    [testQueue addJob:@"c"];
    [testQueue addJob:@"a" dependingOn:@"b"];
    [testQueue addJob:@"b" dependingOn:@"c"];
    
    XCTAssertEqualObjects([testQueue scheduledJobs], @"abc");
}

@end
