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

- (void)testEmptyQueueReturnEmptyString
{
    XCTAssertEqualObjects([testQueue sortedJobs], @"");
}

- (void)testJobsCanBeAdded
{
    NSString* testJob = @"a";
    [testQueue addJob:testJob];
    
    XCTAssertEqualObjects(testJob, [testQueue sortedJobs]);
}

- (void)testIndependentJobsAreExecutedInTeSameOrderTheyWereAdded
{
    NSString* firstJob = @"a";
    NSString* secondJob = @"b";
    
    [testQueue addJob:firstJob];
    [testQueue addJob:secondJob];
    
    XCTAssertEqualObjects([testQueue sortedJobs], @"ab", @"Jobs should appear in the same order they were added");
}

- (void)testJobsCanBeAddedWithDependencies
{
    NSString* firstJob = @"a";
    NSString* secondJob = @"b";
    
    [testQueue addJob:secondJob dependingOnJob:firstJob];
    XCTAssertEqualObjects([testQueue sortedJobs], @"ab", @"a should appear before b");
}


@end
