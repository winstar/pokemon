//
//  xkViewController.m
//  pokemon
//
//  Created by 王建平 on 13-7-8.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "xkViewController.h"
#import "PMTypeColor.h"
#import "NVSlideMenuController.h"

@interface xkViewController ()

@end

@implementation xkViewController {
    UIScrollView *xkScrollView;
    PMTypeColor *pmTypeColor;
}
@synthesize panelView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.isOpenInView == NO) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    }
    panelView.contentSize = CGSizeMake(320, 504);
    panelView.showsVerticalScrollIndicator = NO;
    panelView.showsHorizontalScrollIndicator = NO;
    [panelView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [self setTitle:@"属性相克表"];
    pmTypeColor = [PMTypeColor shareInstance];
    int sxxk[18][18] = {
        {2,4,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2},
        {2,2,4,2,2,1,1,2,2,2,2,2,2,4,2,2,1,2},
        {2,1,2,2,0,4,1,2,2,2,2,1,4,2,4,2,2,2},
        {2,1,2,1,4,2,1,2,2,2,2,1,2,4,2,2,2,2},
        {2,2,2,1,2,1,2,2,2,2,4,4,0,2,4,2,2,2},
        {1,4,1,1,4,2,2,2,4,1,4,4,2,2,2,2,2,2},
        {2,1,4,2,1,4,2,2,2,4,2,1,2,2,2,2,2,2},
        {0,0,2,1,2,2,1,4,2,2,2,2,2,2,2,2,4,2},
        {1,4,1,0,4,1,1,1,1,4,2,1,2,1,1,1,1,2},
        {2,2,2,2,4,4,1,2,1,1,4,1,2,2,1,2,2,2},
        {2,2,2,2,2,2,2,2,1,1,1,4,4,2,1,2,2,2},
        {2,2,4,4,1,2,4,2,2,4,1,1,1,2,4,2,2,2},
        {2,2,1,2,4,2,2,2,1,2,2,2,1,2,2,2,2,2},
        {2,1,2,2,2,2,4,4,2,2,2,2,2,1,2,2,4,2},
        {2,4,2,2,2,4,2,2,4,4,2,2,2,2,1,2,2,2},
        {2,2,2,2,2,2,2,2,2,1,1,1,1,2,4,4,2,2},
        {2,4,2,2,2,2,4,1,2,2,2,2,2,0,2,2,1,2},
        {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2}
    };
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 312, 20)];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:13];
    topLabel.text = @"防御方";
    topLabel.backgroundColor = [UIColor colorWithRed:0 green:0.9 blue:0.5 alpha:0.2];
    [panelView addSubview:topLabel];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 24, 20, 476)];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:13];
    leftLabel.textColor = [UIColor redColor];
    leftLabel.text = @"攻击方";
    leftLabel.lineBreakMode = NSLineBreakByCharWrapping;
    leftLabel.numberOfLines = 0;
    leftLabel.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.9 alpha:0.2];
    [panelView addSubview:leftLabel];
    
    UILabel *leftLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(28, 24, 24, 20)];
    leftLabel1.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.9 alpha:0.2];
    [panelView addSubview:leftLabel1];
    
    UILabel *leftLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(28, 480, 24, 20)];
    leftLabel2.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.9 alpha:0.2];
    [panelView addSubview:leftLabel2];
    
    xkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(56, 24, 264, 476)];
    xkScrollView.contentSize = CGSizeMake(432, 476);
    xkScrollView.pagingEnabled = YES;
    xkScrollView.scrollEnabled = YES;
    xkScrollView.showsHorizontalScrollIndicator = NO;
    xkScrollView.showsVerticalScrollIndicator = NO;
    xkScrollView.delegate = self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 432, 452)];
    
    for (int i=0; i<18; i++) {
        for (int k=0; k<18; k++) {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
            label.frame = CGRectMake(24 * i, 24 + 24 * k, 20, 20);
            int value = sxxk[i][k];
            if (value == 1) {
                label.text = @"½";
                label.textColor = [UIColor colorWithRed:0 green:0.3 blue:1 alpha:0.9];
            } else {
                label.text = [NSString stringWithFormat:@"%d", value / 2];
            }
            if (value == 4) {
                label.textColor = [UIColor colorWithRed:1 green:0.1 blue:0 alpha:0.9];
            } else if (value == 2) {
                label.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
            }
            [view addSubview:label];
        }
        
        UILabel *_topLabel = [[UILabel alloc] initWithFrame:CGRectMake(24 * i, 0, 20, 20)];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont systemFontOfSize:13];
        _topLabel.backgroundColor = [pmTypeColor getTypeColor:i + 1];
        _topLabel.text = [pmTypeColor getTypeName:i + 1];
        _topLabel.textColor = [UIColor whiteColor];
        [view addSubview:_topLabel];
        
        UILabel *_bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(24 * i, 456, 20, 20)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = [UIFont systemFontOfSize:13];
        _bottomLabel.backgroundColor = [pmTypeColor getTypeColor:i + 1];
        _bottomLabel.text = [pmTypeColor getTypeName:i + 1];
        _bottomLabel.textColor = [UIColor whiteColor];
        [view addSubview:_bottomLabel];
        
        UILabel *_leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 48 + 24 * i, 20, 20)];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont systemFontOfSize:13];
        _leftLabel.backgroundColor = [pmTypeColor getTypeColor:i + 1];
        _leftLabel.text = [pmTypeColor getTypeName:i + 1];
        _leftLabel.textColor = [UIColor whiteColor];
        [panelView addSubview:_leftLabel];
    }
    [xkScrollView addSubview:view];
    [panelView addSubview:xkScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
