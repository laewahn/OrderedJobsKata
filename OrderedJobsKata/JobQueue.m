//
//  JobQueue.m
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 20/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import "JobQueue.h"

@interface Job : NSObject
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSMutableArray* dependencies;
-(void)addDependency:(Job *)dependency;
@end

@implementation Job

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dependencies = [NSMutableArray array];
    }
    return self;
}

-(void)addDependency:(Job *)dependency
{
    [self.dependencies addObject:dependency];
}

@end



@interface JobQueue ()
@property(readonly, strong) NSMutableArray* independentJobs;
@end


@implementation JobQueue

@synthesize independentJobs = _independentJobs;

-(void) addJob:(NSString *)job
{
    if ([self jobNamed:job] == nil) {
        Job* newJob = [[Job alloc] init];
        [newJob setName:job];
        
        [self.independentJobs addObject:newJob];
    }
}

-(Job *)jobNamed:(NSString *)jobName
{
    for (Job* aJob in [self independentJobs]) {
        if ([[aJob name] isEqualToString:jobName]) {
            return aJob;
        }
    }
    
    return nil;
}

-(void) addJob:(NSString *)job dependingOn:(NSString *)dependency
{
    Job* theJob = [self jobNamed:job];

    if (theJob == nil) {
        [self addJob:job];
        theJob = [self jobNamed:job];
    }
    
    Job* dependencyJob = [[Job alloc] init];
    [dependencyJob setName:dependency];

    [theJob addDependency:dependencyJob];
}

-(NSString *) scheduledJobs
{
    NSMutableArray* jobNames = [NSMutableArray array];
    [self.independentJobs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [jobNames addObject:[(Job *)obj name]];
    }];
     
    return [jobNames componentsJoinedByString:@""];
}

-(NSMutableArray *)independentJobs
{
    if (_independentJobs == nil) {
        _independentJobs = [NSMutableArray array];
    }
    
    return _independentJobs;
}

@end
