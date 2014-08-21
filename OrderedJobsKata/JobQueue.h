//
//  JobQueue.h
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 20/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobQueue : NSObject

-(void) addJob:(NSString *)job;
-(void) addJob:(NSString *)job dependingOn:(NSString *)dependency;

-(NSString *) scheduledJobs;

@end
