//
//  ConversationViewController.h
//  JWChat
//
//  Created by jerry on 17/4/1.
//  Copyright © 2017年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationViewController : UIViewController

// 网络/登录状态回调显示
- (void)updateTitleWithLinkState:(NSString *)state showIndicator:(BOOL)show;

@end

