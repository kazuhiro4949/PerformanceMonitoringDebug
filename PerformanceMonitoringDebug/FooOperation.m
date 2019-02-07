//
//  FooOperation.m
//  FirebasePerformanceMonitoringDebug
//
//  Created by Kazuhiro Hayashi on 2019/02/07.
//  Copyright © 2019 Kazuhiro Hayashi. All rights reserved.
//

#import "FooOperation.h"
@implementation FooOperation {
    BOOL _isExecuting;
    NSURLConnection *_connection;
}


- (void)requestStart
{
    _connection = [[NSURLConnection alloc] initWithRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://example.com"]]
                                                  delegate:self
                                          startImmediately:NO];
    
    if (_connection) {
        do {
            [_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            [_connection start];
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        }
        while (_isExecuting);
    }
}

- (void)main
{
    _isExecuting = YES;
    [self requestStart];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _isExecuting = NO;
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    _isExecuting = NO;
    
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    if ([self.class checkOperationStatusForKey:key]) {
        return YES;
    }

    return [super automaticallyNotifiesObserversForKey:key];
}

+ (BOOL)checkOperationStatusForKey:(NSString *)key
{
    return ([key isEqualToString:@"isExecuting"] ||
            [key isEqualToString:@"isFinished"]  ||
            [key isEqualToString:@"isCancelled"]);
}

@end
