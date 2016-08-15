//
//  RNGModel.m
//  Whats-for-lunch
//
//  Created by Steven Xu on 2016-08-16.
//  Copyright © 2016 Steven Xu. All rights reserved.
//

#import "RNGModel.h"

@implementation RNGModel

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.exceptions = [NSMutableSet set];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static RNGModel *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (NSNumber*)getRandomNumFrom:(int)from to:(int)to {
    if (from > to) { return nil; }
    if ([self hasAllNumbersExcepted:from to:to]) { return nil; }
    while (YES) {
        int randNum = arc4random_uniform(to - from + 1) + from;
        NSNumber *num = [NSNumber numberWithInt:randNum];
        if ([self.exceptions containsObject:num]) {
            continue;
        }
        NSLog(@"randNum is: %d", randNum);
        return [NSNumber numberWithInt:randNum];
    }
}

- (BOOL)hasAllNumbersExcepted:(int)from to:(int)to {
    BOOL allNumbersExcepted = YES;
    for (int i = from; i <= to; i++) {
        if (![self.exceptions containsObject:[NSNumber numberWithInt:i]]) {
            allNumbersExcepted = NO;
            break;
        }
    }
    return allNumbersExcepted;
}

@end

