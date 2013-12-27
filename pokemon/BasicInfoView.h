//
//  BasicInfoView.h
//  pokemon
//
//  Created by 王建平 on 13-6-25.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoView : UIView <UIScrollViewDelegate>

- (void) loadUI:(int)pmId;
- (void) loadData:(int)pmId;

@end
