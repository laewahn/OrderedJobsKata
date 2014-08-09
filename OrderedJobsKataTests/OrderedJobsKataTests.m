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
	NSString* someJob;
	NSString* someOtherJob;
}
@end

@implementation OrderedJobsKataTests

- (void)setUp
{
	testQueue = [[JobQueue alloc] init];
	someJob = @"a";
	someOtherJob = @"b";
}

- (void)testIndependentJobCanBeAdded
{
	[testQueue addJob:someJob];
	
	XCTAssertEqualObjects([testQueue scheduledJobs], someJob, @"Only the one job should be scheduled.");
}

- (void)testMultipleIndependentJobsAreOrderedFIFO
{
	[testQueue addJob:someJob];
	[testQueue addJob:someOtherJob];
	
	XCTAssertEqualObjects(@"ab", [testQueue scheduledJobs]);
}

- (void)testJobsAreUnique
{
    [testQueue addJob:someJob];
	[testQueue addJob:someJob];
	
	XCTAssertEqualObjects([testQueue scheduledJobs], someJob);
}

- (void)testDependenciesAreAddedAsNewJobsIfNotAlreadyThere
{
	NSString* dependencyJob = @"c";

	[testQueue addJob:someJob];
    [testQueue addJob:someOtherJob dependingOnJob:dependencyJob];
	
	XCTAssertEqualObjects(@"acb", [testQueue scheduledJobs]);
}

- (void)testDependenciesAreResolvedWhenAddingNewDependentJob
{
    [testQueue addJob:someJob]; // a
	[testQueue addJob:someOtherJob]; // ab
	
	[testQueue addJob:@"c" dependingOnJob:someJob]; // acb
	
	XCTAssertEqualObjects(@"acb", [testQueue scheduledJobs]);
}

- (void)testDependenciesAreResolvedWhenDeclaredForExistingJobs
{
    [testQueue addJob:someJob];
	[testQueue addJob:someOtherJob];
	[testQueue addJob:@"c"]; // abc
	
	[testQueue job:someJob dependsOnJob:@"c	"]; // cab
	
	XCTAssertEqualObjects([testQueue scheduledJobs], @"cab");
}

@end
