/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "RoToshiTiModTisocketrocketSocketProxy.h"

@implementation RoToshiTiModTisocketrocketSocketProxy

-(void)_initWithProperties:(NSDictionary *)properties
{
    WS = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[properties objectForKey:@"url"]]]];
    [WS setDelegate:self];
    [WS open];
    [super _initWithProperties:properties];
}
-(void)_destroy
{
    [super _destroy];
}

-(void)send:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    [WS send:args];
}

#pragma SRWebSocketDelegate
-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    
    [self fireEvent:@"closed" withObject:@{@"status": [NSNumber numberWithBool: wasClean], @"reason": reason}];
}

-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    [self fireEvent:@"error" withObject:@{@"message": [error localizedDescription]}];
}

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"[INFO] you got a message");
    [self fireEvent:@"message" withObject:@{@"message": message}];
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"[INFO] web socket is opened");
    [self fireEvent:@"open" withObject:@{@"message": @"socket is open"}];
    
}


@end
