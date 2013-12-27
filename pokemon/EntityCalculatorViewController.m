//
//  EntityCalculatorViewController.m
//  pokemon
//
//  Created by 王建平 on 13-7-11.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "EntityCalculatorViewController.h"
#import "NVSlideMenuController.h"
#import "EntityPMCell.h"
#import "EntitySelectCell.h"
#import "PMSelectController.h"
#import "EntitySelectViewController.h"
#import "SqliteHelper.h"
#import "Globle.h"
#import "QuartzCore/QuartzCore.h"

@interface EntityCalculatorViewController () {
    NSMutableArray *zzzArray;
    NSMutableArray *nulzArray;
    NSMutableArray *xgArray;
    NSMutableArray *nenglzArray;
    NSMutableArray *gtArray;
    UITextField *editField;
    int selectIndex;
}

@end

@implementation EntityCalculatorViewController

//@synthesize pokemon;
@synthesize level;
@synthesize nameLabel;
@synthesize idLabel;
@synthesize pmImageView;
@synthesize levelLabel;
@synthesize nuliLabel;
@synthesize xinggeLabel;
@synthesize panelView;
@synthesize entityTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (IBAction)backgroundTap:(id)sender
{
    [editField resignFirstResponder];
    [entityTableView setContentOffset:CGPointMake(0, -20) animated:YES];
}

- (IBAction)editField:(id)sender
{
    editField = sender;
    [entityTableView setContentOffset:CGPointMake(0, 112) animated:YES];

}

- (IBAction)finishEditField:(id)sender
{
    UITextField *_editField = sender;
    if ([_editField.text isEqualToString:@""]) {
        _editField.text = @"0";
    }
    [self reflashAllScope];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.slideMenuController.panGestureEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    self.title = @"个体值计算器";
    NSLog(@"个体值计算器");
    //entityTableView.contentSize = CGSizeMake(320, 740);
    [entityTableView setContentOffset:CGPointMake(0, -20) animated:NO];
    [panelView addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(selectPM:) name:@"selectPM" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(selectLevel:) name:@"selectLevel" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(selectNature:) name:@"selectNature" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(selectNuli:) name:@"selectNuli" object:nil];
    
    zzzArray = [NSMutableArray arrayWithCapacity:6];
    nulzArray = [NSMutableArray arrayWithCapacity:6];
    xgArray = [NSMutableArray arrayWithCapacity:5];
    nenglzArray = [NSMutableArray arrayWithCapacity:6];
    gtArray = [NSMutableArray arrayWithCapacity:6];
    UIFont *font = [UIFont systemFontOfSize:15];
    for (int i=0; i<6; i++) {
        UITextField *zhongzuField = [[UITextField alloc] initWithFrame:CGRectMake(50, 54 + i * 36, 45, 30)];
        [zzzArray addObject:zhongzuField];
        zhongzuField.textAlignment = NSTextAlignmentRight;
        [panelView addSubview:zhongzuField];
        zhongzuField.text = @"0";
        zhongzuField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        zhongzuField.borderStyle = UITextBorderStyleRoundedRect;
        zhongzuField.font = font;
        [zhongzuField addTarget:self action:@selector(editField:) forControlEvents:UIControlEventEditingDidBegin];
        [zhongzuField addTarget:self action:@selector(finishEditField:) forControlEvents:UIControlEventEditingDidEnd];
        zhongzuField.keyboardType = UIKeyboardTypeNumberPad;
        
        UITextField *nuliField = [[UITextField alloc] initWithFrame:CGRectMake(105, 54 + i * 36, 45, 30)];
        nuliField.textAlignment = NSTextAlignmentRight;
        nuliField.text = @"0";
        nuliField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nuliField.borderStyle = UITextBorderStyleRoundedRect;
        [nulzArray addObject:nuliField];
        [panelView addSubview:nuliField];
        nuliField.font = font;
        [nuliField addTarget:self action:@selector(editField:) forControlEvents:UIControlEventEditingDidBegin];
        [nuliField addTarget:self action:@selector(finishEditField:) forControlEvents:UIControlEventEditingDidEnd];
        nuliField.keyboardType = UIKeyboardTypeNumberPad;
        
        UITextField *nengliField = [[UITextField alloc] initWithFrame:CGRectMake(207, 54 + i * 36, 45, 30)];
        nengliField.textAlignment = NSTextAlignmentRight;
        nengliField.text = @"0";
        nengliField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nengliField.borderStyle = UITextBorderStyleRoundedRect;
        [nenglzArray addObject:nengliField];
        [panelView addSubview:nengliField];
        nengliField.font = font;
        [nengliField addTarget:self action:@selector(editField:) forControlEvents:UIControlEventEditingDidBegin];
        [nengliField addTarget:self action:@selector(finishEditField:) forControlEvents:UIControlEventEditingDidEnd];
        nengliField.keyboardType = UIKeyboardTypeNumberPad;
        
        if (i > 0) {
            UIButton *xinggeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            xinggeBtn.frame = CGRectMake(157, 54 + i * 36, 43, 30);
            xinggeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            [xinggeBtn addTarget:self action:@selector(changeXingGe:) forControlEvents:UIControlEventTouchUpInside];
            [xinggeBtn setTitle:@" " forState:UIControlStateNormal];
            [xgArray addObject:xinggeBtn];
            [panelView addSubview:xinggeBtn];
        }
        
        UILabel *getiLabel = [[UILabel alloc] initWithFrame:CGRectMake(262, 54 + i * 36, 50, 30)];
        getiLabel.text = @"    ?";
        getiLabel.font = font;
        [gtArray addObject:getiLabel];
        [panelView addSubview:getiLabel];
        
        level = 1;
    }
}

- (void)changeXingGe:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([@"+" isEqualToString:btn.titleLabel.text]) {
        [btn setTitle:@"-" forState:UIControlStateNormal];
    } else if ([@"-" isEqualToString:btn.titleLabel.text]) {
        [btn setTitle:@" " forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"+" forState:UIControlStateNormal];
    }
    [self reflashAllScope];
}

- (void)selectLevel:(NSNotification*) notification
{
    NSString *strLevel = notification.object;
    self.level = strLevel.intValue;
    levelLabel.text = [NSString stringWithFormat:@"Lv%d", self.level];
    NSLog(@"NSNotification: %d", self.level);
    [self reflashAllScope];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)selectNature:(NSNotification*) notification
{
    NSString *strNature = notification.object;
    xinggeLabel.text = strNature;
    //NSLog(@"NSNotification: %@", strNature);
    
    NSString *natureValue = [[Globle shareInstance] getNatureValue:strNature];
    //NSLog(@"%@", natureValue);
    NSArray *natureFlag = [natureValue componentsSeparatedByString:@"/"];
    int firstFlag = ((NSString *)[natureFlag objectAtIndex:0]).intValue;
    int secondFlag = ((NSString *)[natureFlag objectAtIndex:1]).intValue;
    int xgFlag[5] = {0, 0, 0, 0, 0};
    if (firstFlag != secondFlag) {
        xgFlag[firstFlag] = 1;
        xgFlag[secondFlag] = 2;
    }
    for (int i=0; i<5; i++) {
        UIButton *xgBtn = [xgArray objectAtIndex:i];
        if (xgFlag[i] == 0) {
            [xgBtn setTitle:@" " forState:UIControlStateNormal];
        } else if (xgFlag[i] == 1) {
            [xgBtn setTitle:@"+" forState:UIControlStateNormal];
        } else if (xgFlag[i] == 2) {
            [xgBtn setTitle:@"-" forState:UIControlStateNormal];
        }
    }
    [self reflashAllScope];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)selectNuli:(NSNotification*) notification
{
    NSString *strNuli = notification.object;
    nuliLabel.text = strNuli;
    NSLog(@"NSNotification: %@", strNuli);
    int nuliValueArray[6] = {0, 0, 0, 0, 0, 0};
    if ([strNuli isEqualToString:@"全部为0"]) {
    } else if ([strNuli isEqualToString:@"全满"]) {
        for (int i=0; i<6; i++) {
            nuliValueArray[i] = 252;
        }
    }
    
    if ([strNuli rangeOfString:@"HP"].location != NSNotFound) {
        nuliValueArray[0] = 252;
    }
    if ([strNuli rangeOfString:@"攻击"].location != NSNotFound) {
        nuliValueArray[1] = 252;
    }
    if ([strNuli rangeOfString:@"防御"].location != NSNotFound) {
        nuliValueArray[2] = 252;
    }
    if ([strNuli rangeOfString:@"特攻"].location != NSNotFound) {
        nuliValueArray[3] = 252;
    }
    if ([strNuli rangeOfString:@"特防"].location != NSNotFound) {
        nuliValueArray[4] = 252;
    }
    if ([strNuli rangeOfString:@"速度"].location != NSNotFound) {
        nuliValueArray[5] = 252;
    }
    
    for (int i=0; i<6; i++) {
        UITextField *nuliField = [nulzArray objectAtIndex:i];
        nuliField.text = [NSString stringWithFormat:@"%d", nuliValueArray[i]];
    }
    
    [self reflashAllScope];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)selectPM:(NSNotification*) notification
{
    NSNumber *pmIdNumber = (NSNumber *)notification.object;
    
    NSLog(@"NSNotification: %d", pmIdNumber.intValue);
    
    NSMutableArray *_pmArray = [[SqliteHelper sharedHelper] getPokemon:pmIdNumber.intValue];
    if (_pmArray.count > 0) {
        Pokemon *pokemon = [_pmArray objectAtIndex:0];
        NSString *pmNum = [NSString stringWithFormat:@"%03d", pokemon.id];
        idLabel.text = pmNum;
        nameLabel.text = pokemon.name;
        pmImageView.image = [UIImage imageNamed:pmNum];
        for (int i=0; i<6; i++) {
            UITextField *zhongzuField = [zzzArray objectAtIndex:i];
            int value = 0;
            switch (i) {
                case 0:
                    value = pokemon.baseHP;
                    break;
                case 1:
                    value = pokemon.baseAttack;
                    break;
                case 2:
                    value = pokemon.baseDefense;
                    break;
                case 3:
                    value = pokemon.baseSpAttack;
                    break;
                case 4:
                    value = pokemon.baseSpDefense;
                    break;
                case 5:
                    value = pokemon.baseSpeed;
                    break;
                default:
                    break;
            }
            zhongzuField.text = [NSString stringWithFormat:@"%d", value];
        }
    }
    [self reflashAllScope];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row - 1;
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"table");
    static NSString *simpleTableIdentifier1 = @"EntityPMCell";
    static NSString *simpleTableIdentifier2 = @"EntitySelectCell";
    
    if (indexPath.row == 0) {
        EntityPMCell *cell = (EntityPMCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier1];
        if (cell == nil) {
            cell = (EntityPMCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier1];
        }
        nameLabel = cell.nameLabel;
        idLabel = cell.idLabel;
        pmImageView = cell.pmImageView;
        return cell;
    } else {
        EntitySelectCell *cell = (EntitySelectCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier2];
        if (cell == nil) {
            cell = (EntitySelectCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier2];
        }
        if (indexPath.row == 1) {
            cell.nameLabel.text = @"精灵等级";
            levelLabel = cell.valueLabel;
            levelLabel.text = [NSString stringWithFormat:@"Lv%d", self.level];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"精灵性格";
            cell.valueLabel.text = @"选择";
            xinggeLabel = cell.valueLabel;
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"努力值分配";
            cell.valueLabel.text = @"选择";
            nuliLabel = cell.valueLabel;
        }
        
        return cell;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"selectEntityOther"]) {
        EntitySelectViewController *destViewController = segue.destinationViewController;
        //NSLog(@"selectEntityOther");
        destViewController.index = selectIndex;  
    }
    self.slideMenuController.panGestureEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)reflashAllScope
{
    for (int i=0; i<6; i++) {
        [self reflashScope:i];
    }
}

- (void)reflashScope:(int)index
{
    UITextField *zhongzuField = [zzzArray objectAtIndex:index];
    NSString *zhongzuString = zhongzuField.text;
    int zhz = zhongzuString.intValue;
    UITextField *nenglzField = [nenglzArray objectAtIndex:index];
    NSString *nenglzString = nenglzField.text;
    int nlz = nenglzString.intValue;
    UITextField *nulzField = [nulzArray objectAtIndex:index];
    NSString *nulzString = nulzField.text;
    int nulz = nulzString.intValue / 4;
    
    if (nlz == 0) {
        UITextField *gtField = [gtArray objectAtIndex:index];
        gtField.text = @"    ?";
        return;
    }
    
    double from = nlz - level - 10;
    double to = from + 1;
    //性格修正
    if (index > 0) {
        UIButton *xgBtn = [xgArray objectAtIndex:index - 1];
        if ([@"+" isEqualToString:xgBtn.titleLabel.text]) {
            int temp = nlz / 1.1 - 5.0001;
            if (nlz <= 5) {
                temp -= 1;
            }
            from = temp + 1;
            to = temp + 2;
            //NSLog(@"Double + : %f,%f", from, to);
        } else if ([@"-" isEqualToString:xgBtn.titleLabel.text]) {
            int temp = nlz / 0.9 - 5.0001;
            if (nlz < 5) {
                temp -= 1;
            }
            from = temp + 1;
            to = temp + 2;
            if (nlz % 9 == 0) {
                to += 1;
            }
            //NSLog(@"Double - : %f,%f", from, to);
        } else {
            from = nlz - 5;
            to = from + 1;
            //NSLog(@"Double : %f,%f", from, to);
        }
    }
    
    double fromGT = from * 100 / level - 2 * zhz - nulz - 0.0001;   //解决正好能整除的情况
    double toGT = to * 100 / level - 2 * zhz - nulz - 0.0001;
    
    NSString *zero = @"";
    int itFrom = (int)fromGT + 1;
    int itTo = (int)toGT;
    if (itTo > 31) {
        itTo = 31;
    }
    if (itFrom < 0) {
        itFrom = 0;
    }
    if (itFrom < 10) {
        zero = @"  ";
    }
    UITextField *gtField = [gtArray objectAtIndex:index];
    if (itFrom > itTo) {
        gtField.text = @"    ?";
    } else {
        gtField.text = [NSString stringWithFormat:@"%@%d~%d", zero, itFrom, itTo];
    }
    
    //NSLog(@"%d, %d", itFrom, itTo);
}

@end
