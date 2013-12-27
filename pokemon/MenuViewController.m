//
//  MenuViewController.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-22.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "MenuViewController.h"
#import "NVSlideMenuController.h"
#import "xkViewController.h"
#import "TestViewController.h"
#import "Globle.h"
#import "SqliteHelper.h"

@interface MenuViewController () {
    NSMutableArray *menuArray;
    BOOL nextPM;
    int currentPM;
}
@end

@implementation MenuViewController

@synthesize menuTableView;
@synthesize bgImageView;
@synthesize currentMenu;
@synthesize headerView;
@synthesize medallionView;
@synthesize pmImageView;
@synthesize nameLabel;
@synthesize imagePanel;

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
    menuArray = [NSMutableArray arrayWithObjects:@" 精 灵 列 表", @" 技 能 列 表", @" 特 性 列 表", @" 个 体 值 计 算", @" 属 性 相 克 表", nil];
    menuTableView.backgroundColor = [UIColor clearColor];
    bgImageView.frame = CGRectMake(0, 0, [Globle shareInstance].globleWidth, [Globle shareInstance].globleHeight);

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(medallionDidTap:)];
    [self.medallionView addGestureRecognizer:tapGestureRecognizer];
    [self getRandPMImage];
    pmImageView.layer.cornerRadius = 35;
    pmImageView.layer.masksToBounds = YES;
    nextPM = NO;
}

- (void)getRandPMImage
{
    int pmIndex = arc4random() % 649;
    pmIndex += 1;
    currentPM = pmIndex;
    pmImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03d", pmIndex]];
}

- (void)medallionDidTap:(id)sender
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
    shake.toValue = [NSNumber numberWithFloat:+M_PI/32];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 3;
    [imagePanel.layer addAnimation:shake forKey:@"shakeAnimation"];
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{} completion:nil];
    
    if (nextPM == YES) {
        [self getRandPMImage];
        nameLabel.text = @"猜猜我是谁";
        nextPM = NO;
    } else {
        NSMutableArray *pmList = [[SqliteHelper sharedHelper] getPokemon:currentPM];
        Pokemon *pokemon = [pmList objectAtIndex:0];
        nameLabel.text = pokemon.name;
        nextPM = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [menuTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [menuArray objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor whiteColor];
    //cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [cell.textLabel setShadowColor:[UIColor blackColor]];
    [cell.textLabel setShadowOffset:CGSizeMake(0, 0.3)];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
	UIViewController *menuVC;
    switch (indexPath.row) {
        case 0:
            menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"PMListViewController"];
            break;
        case 1:
            menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"MoveListViewController"];
            break;
        case 2:
            menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"AbilityListViewController"];
            break;
        case 3:
            menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"EntityCalculatorController"];
            break;
        case 4:
            menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"SHUXINGViewController"];
            break;
        default:
            menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"TestViewController"];
            break;
    }
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [self.slideMenuController closeMenuBehindContentViewController:navController animated:YES completion:nil];
}

- (void) startBtnClick
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	TestViewController *menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"TestViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:menuVC];

    [self.slideMenuController closeMenuBehindContentViewController:navController animated:YES completion:nil];
}

@end
