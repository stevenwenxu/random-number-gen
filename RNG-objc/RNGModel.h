//
//  RNGModel.h
//  Whats-for-lunch
//
//  Created by Steven Xu on 2016-08-16.
//  Copyright © 2016 Steven Xu. All rights reserved.
//

#ifndef RNGModel_h
#define RNGModel_h

#import <Foundation/Foundation.h>

@interface RNGModel : NSObject

+ (instancetype)sharedInstance;

// list of numbers that RNG will avoid
@property NSMutableSet<NSNumber*> *exceptions;

// get a random number
- (NSNumber*)getRandomNumFrom:(int)from to:(int)to;

@end


#endif /* RNGModel_h */
