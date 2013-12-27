//
//  AWActionSheet.m
//  AWIconSheet
//
//  Created by Narcissus on 10/26/12.
//  Copyright (c) 2012 Narcissus. All rights reserved.
//

#import "AWActionSheet.h"
#import <QuartzCore/QuartzCore.h>
#define itemPerPage 18

@interface AWActionSheet()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@property (nonatomic, assign)id<AWActionSheetDelegate> IconDelegate;
@end
@implementation AWActionSheet
@synthesize scrollView;
@synthesize pageControl;
@synthesize items;
@synthesize IconDelegate;

-(id)initWithIconSheetDelegate:(id<AWActionSheetDelegate>)delegate ItemCount:(int)cout
{
    int rowCount = 6;
    NSString* titleBlank = @"\n\n\n\n\n\n";
    for (int i = 1 ; i<rowCount; i++) {
        titleBlank = [NSString stringWithFormat:@"%@%@",titleBlank,@"\n\n\n\n\n\n"];
    }
    self = [super initWithTitle:titleBlank
                       delegate:nil
              cancelButtonTitle:@"Cancel"
         destructiveButtonTitle:nil
              otherButtonTitles:nil];
    if (self) {
        [self setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        IconDelegate = delegate;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 78*rowCount)];
        [scrollView setPagingEnabled:YES];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setDelegate:self];
        [scrollView setScrollEnabled:YES];
        [scrollView setBounces:NO];
        
        [self addSubview:scrollView];
        
        if (cout > 18) {
            self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 105*rowCount, 0, 20)];
            [pageControl setNumberOfPages:0];
            [pageControl setCurrentPage:0];
            [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
            [self addSubview:pageControl];
        }
        
        
        self.items = [[NSMutableArray alloc] initWithCapacity:cout];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    [super showInView:view];
    [self reloadData];
}

- (void)reloadData
{
    for (AWActionSheetCell* cell in items) {
        [cell removeFromSuperview];
        [items removeObject:cell];
    }
    
    int count = [IconDelegate numberOfItemsInActionSheet];
    int rowCount = 6;
    int pageNumber = (count % itemPerPage == 0) ? count / itemPerPage : count / itemPerPage + 1;
    [scrollView setContentSize:CGSizeMake(320 * pageNumber, scrollView.frame.size.height)];
    [pageControl setNumberOfPages:pageNumber];
    [pageControl setCurrentPage:0];
    
    
    for (int i = 0; i< count; i++) {
        AWActionSheetCell* cell = [IconDelegate cellForActionAtIndex:i];
        int PageNo = i/itemPerPage;
        //        NSLog(@"page %d",PageNo);
        int index  = i%itemPerPage;
        
        if (itemPerPage == 18) {
            
            int row = index/3;
            int column = index%3;
            
            
            float centerY = (1+row*2)*self.scrollView.frame.size.height/(2*rowCount);
            float centerX = (1+column*2)*self.scrollView.frame.size.width/6;
            
            [cell setCenter:CGPointMake(centerX+320*PageNo, centerY)];
            [self.scrollView addSubview:cell];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
            [cell addGestureRecognizer:tap];
            
            //            [cell.iconView addTarget:self action:@selector(actionForItem:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        [items addObject:cell];
    }
    
}

- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    AWActionSheetCell* cell = (AWActionSheetCell*)[recongizer view];
    [IconDelegate DidTapOnItemAtIndex:cell.index];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(320 * page, 0)];
}
#pragma mark -
#pragma scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x /320;
    pageControl.currentPage = page;
}


@end

#pragma mark - AWActionSheetCell
@interface AWActionSheetCell ()
@end
@implementation AWActionSheetCell
@synthesize iconView;
@synthesize titleLabel;

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 60, 60)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(6.5, 0, 52, 52)];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:8.0f];
        [[iconView layer] setMasksToBounds:YES];
        
        [self addSubview:iconView];
    
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.5, 0, 52, 52)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setShadowColor:[UIColor blackColor]];
        [titleLabel setShadowOffset:CGSizeMake(0, 0.5)];
        [titleLabel setText:@""];
        [self addSubview:titleLabel];
    }
    return self;
}

@end


