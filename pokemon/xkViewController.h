//
//  xkViewController.h
//  pokemon
//
//  Created by 王建平 on 13-7-8.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xkViewController : UIViewController <UIScrollViewDelegate>

@property BOOL isOpenInView;

@property (nonatomic, strong) IBOutlet UIScrollView *panelView;

@end
