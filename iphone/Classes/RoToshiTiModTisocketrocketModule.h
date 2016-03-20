/**
 * TiSocketRocket
 *
 * Created by Toshiro Yagi
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "SRWebSocket.h"

@interface RoToshiTiModTisocketrocketModule : TiModule <SRWebSocketDelegate>
{
    SRWebSocket* WS;
}

@end
