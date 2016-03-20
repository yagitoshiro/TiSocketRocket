/**
 * TiSocketRocket
 *
 * Created by Toshiro Yagi
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "RoToshiTiModTisocketrocketModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation RoToshiTiModTisocketrocketModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"fef7bed6-71b2-4872-bd4c-e4a3aef990e3";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ro.toshi.ti.mod.tisocketrocket";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

//-(void)dealloc
//{
//	// release any resources that have been retained by the module
//	//[super dealloc];
//}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)createWebSocket:(id)args
{
//    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSLog(@"[INFO] opening url: %@", [args objectForKey:@"url"]);
    WS = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[args objectForKey:@"url"]]]];
    [WS setDelegate:self];
    [WS open];
}

-(void)open:(id)args
{
    
}

-(void)close:(id)args
{
    [WS close];
}

-(void)sendString:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    [WS send:args];
}

-(void)sendObject:(id)args
{
//    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [WS send:args];
}

-(void)send:(id)args
{
    [self sendString:args];
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
