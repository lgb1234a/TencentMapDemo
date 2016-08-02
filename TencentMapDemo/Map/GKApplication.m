//
//  GKApplication.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/1.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKApplication.h"

NSString *const notiScreenTouch = @"notiScreenTouch";
NSString *const notiScreenMoved = @"notiScreenMoved";

@implementation GKApplication

- (void)sendEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeTouches) {
        if ([[event.allTouches anyObject] phase] == UITouchPhaseBegan) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:notiScreenTouch object:nil userInfo:[NSDictionary dictionaryWithObject:event forKey:@"data"]]];
        }
        
        if ([[event.allTouches anyObject] phase] == UITouchPhaseMoved) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:notiScreenMoved object:nil userInfo:[NSDictionary dictionaryWithObject:event forKey:@"data"]]];
        }
    }
    [super sendEvent:event];
}

@end
