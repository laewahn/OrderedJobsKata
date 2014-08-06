//
//  JobQueue.h
//  OrderedJobsKata
//
//  Created by Dennis Lewandowski on 06/08/14.
//  Copyright (c) 2014 de.mobile2b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobQueue : NSObject

-(NSString *) sortedJobs;
-(void) addJob:(NSString *)aJob;
-(void) addJob:(NSString *)dependentJob dependingOnJob:(NSString *)independentJob;
@end
