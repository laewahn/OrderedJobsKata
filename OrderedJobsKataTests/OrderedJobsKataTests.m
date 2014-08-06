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
    
    NSString* firstJob;
    NSString* secondJob;
}
@end

@implementation OrderedJobsKataTests

- (void)setUp
{
    testQueue = [[JobQueue alloc] init];
    
    firstJob = @"a";
    secondJob = @"b";
}

- (void)testEmptyQueueReturnEmptyString
{
    XCTAssertEqualObjects([testQueue sortedJobs], @"");
}

- (void)testJobsCanBeAdded
{
    [testQueue addJob:firstJob];
    
    XCTAssertEqualObjects(firstJob, [testQueue sortedJobs]);
}

- (void)testIndependentJobsAreExecutedInTeSameOrderTheyWereAdded
{
    [testQueue addJob:firstJob];
    [testQueue addJob:secondJob];
    
    XCTAssertEqualObjects([testQueue sortedJobs], @"ab", @"Jobs should appear in the same order they were added");
}

- (void)testJobsCanBeAddedWithDependencies
{
    [testQueue addJob:secondJob dependingOnJob:firstJob];
    XCTAssertEqualObjects([testQueue sortedJobs], @"ab", @"a should appear before b");
}

- (void)testDependenciesWithMultipleDependentJobs
{
    NSString* thirdJob = @"c";
    
    [testQueue addJob:firstJob];
    [testQueue addJob:secondJob dependingOnJob:firstJob];
    [testQueue addJob:thirdJob dependingOnJob:secondJob];
    
    XCTAssertEqualObjects([testQueue sortedJobs], @"abc");
}


@end
