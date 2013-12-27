//
//  BasicInfoView.m
//  pokemon
//
//  Created by 王建平 on 13-6-25.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "BasicInfoView.h"
#import "SqliteHelper.h"
#import "PMTypeColor.h"
#import "TopScrollView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BasicInfoView {
    UIImageView *pmImageView;
    NSArray *pokemonList;
    PMTypeColor *pmTypeColor;
    UILabel *type1Label;
    UILabel *shapeLabel;
    UILabel *type2Label;
    UILabel *feature1Label;
    UILabel *feature2Label;
    UILabel *featureHLabel;
    UILabel *heightLabel;
    UILabel *weightLabel;
    UILabel *stepLabel;
    UILabel *genderLabel;
    UILabel *catchLabel;
    UILabel *expLabel;
    UILabel *unitLabel;
    UILabel *eggLabel;
    NSMutableArray *abilityLabelList;
    NSMutableArray *numLabelList;
    CAGradientLayer *gradient;
    UIScrollView *topScrollView;
    UIScrollView *dataTopView;
    UIPageControl *topPageControl;
    UIView *infoTopFirstView;
}

- (void)pmImageAnimation:(UITapGestureRecognizer *)recognizer
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
    shake.toValue = [NSNumber numberWithFloat:+M_PI/32];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 3;
    [pmImageView.layer addAnimation:shake forKey:@"shakeAnimation"];
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{} completion:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        pmTypeColor = [PMTypeColor shareInstance];
        UIView *infoTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        dataTopView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, 320, frame.size.height - 120)];
        dataTopView.contentSize = CGSizeMake(320, 300);
        dataTopView.userInteractionEnabled = YES;
        dataTopView.showsHorizontalScrollIndicator = NO;
        dataTopView.showsVerticalScrollIndicator = NO;
        [self addSubview:dataTopView];
        
        // PM图片
        pmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 15, 90, 90)];
        pmImageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *reg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pmImageAnimation:)];
        pmImageView.userInteractionEnabled = YES;
        [pmImageView addGestureRecognizer:reg];
        [infoTopView addSubview:pmImageView];
        
        // 特性
        NSArray *proNameArray = [NSArray arrayWithObjects:@"属性", @"特性", @"隐藏特性", nil];
        for (int i = 0; i < 3; i++) {
            int weight = 30;
            if (i == 2) {
                weight = 60;
            }
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(150, 20 + 25 * i, weight, 20)];
            [itemName setFont:[UIFont systemFontOfSize:13]];
            [itemName setTextAlignment:NSTextAlignmentLeft];
            itemName.textColor = [UIColor grayColor];
            itemName.text = [proNameArray objectAtIndex:i];
            itemName.backgroundColor = [UIColor clearColor];
            [infoTopView addSubview:itemName];
        }
        
        type1Label = [[UILabel alloc] initWithFrame:CGRectMake(185, 20, 20, 20)];
        [type1Label setTextColor:[UIColor whiteColor]];
        type1Label.font = [UIFont systemFontOfSize:13];
        [type1Label setTextAlignment:NSTextAlignmentCenter];
        [infoTopView addSubview:type1Label];
        
        type2Label = [[UILabel alloc] initWithFrame:CGRectMake(210, 20, 20, 20)];
        [type2Label setTextColor:[UIColor whiteColor]];
        type2Label.font = [UIFont systemFontOfSize:13];
        [type2Label setTextAlignment:NSTextAlignmentCenter];
        [infoTopView addSubview:type2Label];
        [self addSubview:infoTopView];
        
        feature1Label = [[UILabel alloc] initWithFrame:CGRectMake(185, 45, 70, 20)];
        feature1Label.textColor = [PMTypeColor linkColor];
        feature1Label.backgroundColor = [UIColor clearColor];
        feature1Label.font = [UIFont systemFontOfSize:14];
        [feature1Label setTextAlignment:NSTextAlignmentLeft];
        [infoTopView addSubview:feature1Label];
        
        feature2Label = [[UILabel alloc] initWithFrame:CGRectMake(245, 45, 60, 20)];
        feature2Label.textColor = [PMTypeColor linkColor];
        feature2Label.backgroundColor = [UIColor clearColor];
        feature2Label.font = [UIFont systemFontOfSize:14];
        [feature2Label setTextAlignment:NSTextAlignmentLeft];
        [infoTopView addSubview:feature2Label];
        [self addSubview:infoTopView];
        
        featureHLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 70, 60, 20)];
        featureHLabel.textColor = [PMTypeColor linkColor];
        featureHLabel.backgroundColor = [UIColor clearColor];
        featureHLabel.font = [UIFont systemFontOfSize:14];
        [featureHLabel setTextAlignment:NSTextAlignmentLeft];
        [infoTopView addSubview:featureHLabel];
        infoTopFirstView = infoTopView;
        topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        
        [topScrollView addSubview:infoTopView];
        [topScrollView addSubview:infoTopView];
        topScrollView.contentSize = CGSizeMake(320, 120);
        topScrollView.scrollEnabled = YES;
        topScrollView.pagingEnabled = YES;
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.showsVerticalScrollIndicator = NO;
        topScrollView.bounces = NO;
        topScrollView.delegate = self;
        [self addSubview:topScrollView];
        
        topPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 100, 320, 20)];
        topPageControl.numberOfPages = 1; //
        topPageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        topPageControl.currentPage = 0;
        
        [topPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:topScrollView];
        [self addSubview:topPageControl];
        
        shapeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 100, 80, 20)];
        shapeLabel.textColor = [UIColor whiteColor];
        shapeLabel.backgroundColor = [UIColor clearColor];
        shapeLabel.font = [UIFont systemFontOfSize:13];
        shapeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:shapeLabel];
        
        gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 60, 320, 60);

        [self.layer insertSublayer:gradient atIndex:0];
        
        NSArray *itemNameArray = [NSArray arrayWithObjects:@"H P", @"攻击", @"防御", @"特攻", @"特防", @"速度", @"总和", nil];
        // 种族值
        UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 48, 20)];
        itemName.text = @"种族值";
        [itemName setFont:[UIFont systemFontOfSize:13]];
        itemName.textColor = [UIColor grayColor];
        itemName.backgroundColor = [UIColor clearColor];
        [itemName setTextAlignment:NSTextAlignmentLeft];
        [dataTopView addSubview:itemName];
        
        abilityLabelList = [NSMutableArray arrayWithCapacity:7];
        for (int j = 0; j<7; j++) {
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(20 + 42 * j, 36, 28, 20)];
            itemName.text = [itemNameArray objectAtIndex:j];
            [itemName setFont:[UIFont systemFontOfSize:14]];
            [itemName setTextAlignment:NSTextAlignmentCenter];
            itemName.backgroundColor = [UIColor clearColor];
            [dataTopView addSubview:itemName];
            
            UILabel *abilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + 42 * j, 58, 32, 20)];
            [abilityLabel setFont:[UIFont systemFontOfSize:14]];
            abilityLabel.backgroundColor = [UIColor clearColor];
            [abilityLabel setTextAlignment:NSTextAlignmentCenter];
            [dataTopView addSubview:abilityLabel];
            [abilityLabelList addObject:abilityLabel];
        }
        
        UIImageView *lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 320, 0.4)];
        lineView1.image = [UIImage imageNamed:@"line"];
        [dataTopView addSubview:lineView1];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 48, 20)];
        numLabel.text = @"编号";
        [numLabel setFont:[UIFont systemFontOfSize:13]];
        numLabel.textColor = [UIColor grayColor];
        numLabel.backgroundColor = [UIColor clearColor];
        [numLabel setTextAlignment:NSTextAlignmentLeft];
        [dataTopView addSubview:numLabel];
        
        NSArray *noNameArray = [NSArray arrayWithObjects:@"全国", @"关东", @"城都", @"丰缘", @"神奥", @"合众", nil];
        numLabelList = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0; i < 6; i++) {
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(20 + 42 * i, 114, 32, 20)];
            [itemName setFont:[UIFont systemFontOfSize:14]];
            [itemName setTextAlignment:NSTextAlignmentCenter];
            itemName.text = [noNameArray objectAtIndex:i];
            itemName.backgroundColor = [UIColor clearColor];
            [dataTopView addSubview:itemName];
            
            UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + 42 * i, 136, 32, 20)];
            [numLabel setFont:[UIFont systemFontOfSize:14]];
            [numLabel setTextAlignment:NSTextAlignmentCenter];
            numLabel.backgroundColor = [UIColor clearColor];
            [dataTopView addSubview:numLabel];
            [numLabelList addObject:numLabel];
        }
        UIImageView *lineView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 158, 320, 0.4)];
        lineView2.image = [UIImage imageNamed:@"line"];
        [dataTopView addSubview:lineView2];
        
        // 基本信息
        UILabel *basicInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 168, 60, 20)];
        basicInfoLabel.text = @"基本信息";
        basicInfoLabel.font = [UIFont systemFontOfSize:13];
        basicInfoLabel.textColor = [UIColor grayColor];
        basicInfoLabel.backgroundColor = [UIColor clearColor];
        [basicInfoLabel setTextAlignment:NSTextAlignmentLeft];
        [dataTopView addSubview:basicInfoLabel];
        
        NSArray *dataArray = [NSArray arrayWithObjects:@"身高", @"体重", @"捕获度", @"经验值", @"孵化步数", @"性别比率", @"个体值", @"生蛋组", nil];
        
        for (int i = 0; i < 2; i++) {
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(20, 192 + 22 * i, 30, 20)];
            [itemName setFont:[UIFont systemFontOfSize:13]];
            [itemName setTextColor:[UIColor grayColor]];
            itemName.backgroundColor = [UIColor clearColor];
            [itemName setTextAlignment:NSTextAlignmentLeft];
            itemName.text = [dataArray objectAtIndex:i];
            [dataTopView addSubview:itemName];
        }
        heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 192, 40, 20)];
        [heightLabel setFont:[UIFont systemFontOfSize:13]];
        heightLabel.backgroundColor = [UIColor clearColor];
        weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 192 + 22, 40, 20)];
        [weightLabel setFont:[UIFont systemFontOfSize:13]];
        weightLabel.backgroundColor = [UIColor clearColor];
        [dataTopView addSubview:heightLabel];
        [dataTopView addSubview:weightLabel];
        
        for (int i = 0; i < 2; i++) {
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(90, 192 + 22 * i, 45, 20)];
            [itemName setFont:[UIFont systemFontOfSize:13]];
            [itemName setTextColor:[UIColor grayColor]];
            itemName.backgroundColor = [UIColor clearColor];
            [itemName setTextAlignment:NSTextAlignmentLeft];
            itemName.text = [dataArray objectAtIndex:2 + i];
            [dataTopView addSubview:itemName];
        }
        catchLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 192, 50, 20)];
        expLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 192 + 22, 50, 20)];
        [catchLabel setFont:[UIFont systemFontOfSize:13]];
        [expLabel setFont:[UIFont systemFontOfSize:13]];
        catchLabel.backgroundColor = [UIColor clearColor];
        expLabel.backgroundColor = [UIColor clearColor];
        [dataTopView addSubview:catchLabel];
        [dataTopView addSubview:expLabel];
        
        for (int i = 0; i < 2; i++) {
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(175, 192 + 22 * i, 60, 20)];
            [itemName setFont:[UIFont systemFontOfSize:13]];
            [itemName setTextColor:[UIColor grayColor]];
            itemName.backgroundColor = [UIColor clearColor];
            [itemName setTextAlignment:NSTextAlignmentLeft];
            itemName.text = [dataArray objectAtIndex:4 + i];
            [dataTopView addSubview:itemName];
        }
        stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(233, 192, 80, 20)];
        genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(233, 192 + 22, 80, 20)];
        [stepLabel setFont:[UIFont systemFontOfSize:13]];
        [genderLabel setFont:[UIFont systemFontOfSize:13]];
        stepLabel.backgroundColor = [UIColor clearColor];
        genderLabel.backgroundColor = [UIColor clearColor];
        [dataTopView addSubview:stepLabel];
        [dataTopView addSubview:genderLabel];
        
        UIImageView *lineView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, 320, 0.4)];
        lineView3.image = [UIImage imageNamed:@"line"];
        [dataTopView addSubview:lineView3];
        
        for (int i = 0; i < 2; i++) {
            UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(20, 250 + 22 * i, 50, 20)];
            [itemName setFont:[UIFont systemFontOfSize:13]];
            [itemName setTextColor:[UIColor grayColor]];
            itemName.backgroundColor = [UIColor clearColor];
            [itemName setTextAlignment:NSTextAlignmentLeft];
            itemName.text = [dataArray objectAtIndex:6 + i];
            [dataTopView addSubview:itemName];
        }
        unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 250, 225, 20)];
        eggLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 272, 225, 20)];
        [unitLabel setFont:[UIFont systemFontOfSize:13]];
        [eggLabel setFont:[UIFont systemFontOfSize:13]];
        unitLabel.backgroundColor = [UIColor clearColor];
        eggLabel.backgroundColor = [UIColor clearColor];
        [dataTopView addSubview:unitLabel];
        [dataTopView addSubview:eggLabel];

    }
    return self;
}

- (UIView *)buildTopView:(int)PMIndex
{
    Pokemon *pokemon = [pokemonList objectAtIndex:PMIndex];
    UIView *infoTopView = [[UIView alloc] initWithFrame:CGRectMake(320 * PMIndex, 0, 320, 120)];
    // PM图片
    UIImageView *_pmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 15, 90, 90)];
    _pmImageView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *imageName;
    if (pokemon.natural == 479 || pokemon.natural == 555 || pokemon.natural == 386) {
        imageName = [NSString stringWithFormat:@"%03d", pokemon.natural];
    } else {
        imageName = [NSString stringWithFormat:@"%03d%c", pokemon.natural,'a'+pokemon.shapeID-1];
    }
    _pmImageView.image = [UIImage imageNamed:imageName];
    [infoTopView addSubview:_pmImageView];
    // 特性
    NSArray *proNameArray = [NSArray arrayWithObjects:@"属性", @"特性", @"隐藏特性", nil];
    for (int i = 0; i < 3; i++) {
        int weight = 30;
        if (i == 2) {
            weight = 60;
        }
        UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(150, 20 + 25 * i, weight, 20)];
        [itemName setFont:[UIFont systemFontOfSize:13]];
        [itemName setTextAlignment:NSTextAlignmentLeft];
        itemName.textColor = [UIColor grayColor];
        itemName.backgroundColor = [UIColor clearColor];
        itemName.text = [proNameArray objectAtIndex:i];
        [infoTopView addSubview:itemName];
    }
    
    UILabel *_type1Label = [[UILabel alloc] initWithFrame:CGRectMake(185, 20, 20, 20)];
    [_type1Label setTextColor:[UIColor whiteColor]];
    _type1Label.font = [UIFont systemFontOfSize:13];
    [_type1Label setTextAlignment:NSTextAlignmentCenter];
    _type1Label.backgroundColor = [[PMTypeColor shareInstance] getTypeColor:pokemon.type1];
    _type1Label.text = [[PMTypeColor shareInstance] getTypeName:pokemon.type1];
    [infoTopView addSubview:_type1Label];
    
    UILabel *_type2Label = [[UILabel alloc] initWithFrame:CGRectMake(210, 20, 20, 20)];
    [_type2Label setTextColor:[UIColor whiteColor]];
    _type2Label.font = [UIFont systemFontOfSize:13];
    [_type2Label setTextAlignment:NSTextAlignmentCenter];
    _type2Label.backgroundColor = [[PMTypeColor shareInstance] getTypeColor:pokemon.type2];
    _type2Label.text = [[PMTypeColor shareInstance] getTypeName:pokemon.type2];
    [infoTopView addSubview:_type2Label];
    [self addSubview:infoTopView];
    
    UILabel *_feature1Label = [[UILabel alloc] initWithFrame:CGRectMake(185, 45, 60, 20)];
    _feature1Label.textColor = [PMTypeColor linkColor];
    _feature1Label.backgroundColor = [UIColor clearColor];
    _feature1Label.font = [UIFont systemFontOfSize:14];
    [_feature1Label setTextAlignment:NSTextAlignmentLeft];
    [infoTopView addSubview:_feature1Label];
    
    UILabel *_feature2Label = [[UILabel alloc] initWithFrame:CGRectMake(245, 45, 60, 20)];
    _feature2Label.textColor = [PMTypeColor linkColor];
    _feature2Label.backgroundColor = [UIColor clearColor];
    _feature2Label.font = [UIFont systemFontOfSize:14];
    [_feature2Label setTextAlignment:NSTextAlignmentLeft];
    [infoTopView addSubview:_feature2Label];
    [self addSubview:infoTopView];
    
    UILabel *_featureHLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 70, 60, 20)];
    _featureHLabel.textColor = [PMTypeColor linkColor];
    _featureHLabel.backgroundColor = [UIColor clearColor];
    _featureHLabel.font = [UIFont systemFontOfSize:14];
    [_featureHLabel setTextAlignment:NSTextAlignmentLeft];
    
    _feature1Label.text = pokemon.ability1Name;
    [_feature2Label setFrame:CGRectMake(185 + pokemon.ability1Name.length * 17, 45, 60, 20)];
    _feature2Label.text = pokemon.ability2Name;
    _featureHLabel.text = pokemon.abilityHName;
    
    [infoTopView addSubview:_featureHLabel];
    
    return infoTopView;
}

- (void) loadUI:(int)pmId {
    
}

- (void) loadData:(int)pmId {
    
    NSString *strNumber = [NSString stringWithFormat:@"%03d", pmId];
    pmImageView.image = [UIImage imageNamed:strNumber];
    pokemonList = [[SqliteHelper sharedHelper] getPokemon:pmId];
    
    topScrollView.contentSize = CGSizeMake(320, 120);
    dataTopView.contentOffset = CGPointMake(0, 0);
    
    if (topScrollView.subviews.count > 1) {
        for (UIView *view in topScrollView.subviews) {
            if (![infoTopFirstView isEqual:view]) {
                [view removeFromSuperview];
            }
        }
    }
    
    if (pokemonList.count > 1) {
        
        for (int i=1; i<pokemonList.count; i++) {
            UIView *topView = [self buildTopView:i];
            [topScrollView addSubview:topView];
        }
        [topPageControl setNumberOfPages:pokemonList.count];
        [topPageControl setCurrentPage:0];
        topScrollView.contentSize = CGSizeMake(320 * pokemonList.count, 120);
        topPageControl.hidden = NO;
    } else {
        topPageControl.hidden = YES;
    }
    [self loadInfo:0];
}

- (void) loadInfo:(int)shapeId
{
    Pokemon *pokemon = [pokemonList objectAtIndex:shapeId];
    [TopScrollView shareInstance].currPokemon = pokemon;
    shapeLabel.text = pokemon.shape;
    type1Label.text = [pmTypeColor getTypeName:pokemon.type1];
    type1Label.backgroundColor = [pmTypeColor getTypeColor:pokemon.type1];
    type2Label.text = [pmTypeColor getTypeName:pokemon.type2];
    type2Label.backgroundColor = [pmTypeColor getTypeColor:pokemon.type2];
    
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor, (id)[pmTypeColor getTypeColor:pokemon.type1].CGColor, nil];
    
    ((UILabel *)[abilityLabelList objectAtIndex:0]).text = [NSString stringWithFormat:@"%d", pokemon.baseHP];
    ((UILabel *)[abilityLabelList objectAtIndex:1]).text = [NSString stringWithFormat:@"%d", pokemon.baseAttack];
    ((UILabel *)[abilityLabelList objectAtIndex:2]).text = [NSString stringWithFormat:@"%d", pokemon.baseDefense];
    ((UILabel *)[abilityLabelList objectAtIndex:3]).text = [NSString stringWithFormat:@"%d", pokemon.baseSpAttack];
    ((UILabel *)[abilityLabelList objectAtIndex:4]).text = [NSString stringWithFormat:@"%d", pokemon.baseSpDefense];
    ((UILabel *)[abilityLabelList objectAtIndex:5]).text = [NSString stringWithFormat:@"%d", pokemon.baseSpeed];
    int baseTotal = pokemon.baseHP + pokemon.baseAttack + pokemon.baseDefense + pokemon.baseSpAttack + pokemon.baseSpDefense + pokemon.baseSpeed;
    ((UILabel *)[abilityLabelList objectAtIndex:6]).text = [NSString stringWithFormat:@"%d", baseTotal];

    ((UILabel *)[numLabelList objectAtIndex:0]).text = [NSString stringWithFormat:@"%d", pokemon.natural];
    ((UILabel *)[numLabelList objectAtIndex:1]).text = [NSString stringWithFormat:@"%d", pokemon.kanto];
    ((UILabel *)[numLabelList objectAtIndex:2]).text = [NSString stringWithFormat:@"%d", pokemon.johto];
    ((UILabel *)[numLabelList objectAtIndex:3]).text = [NSString stringWithFormat:@"%d", pokemon.hoenn];
    ((UILabel *)[numLabelList objectAtIndex:4]).text = [NSString stringWithFormat:@"%d", pokemon.sinnoh];
    ((UILabel *)[numLabelList objectAtIndex:5]).text = [NSString stringWithFormat:@"%d", pokemon.unova];
    
    for (int i = 0; i < 6; i++) {
        UILabel *numLabel = [numLabelList objectAtIndex:i];
        int index = -1;
        switch (i) {
            case 0:
                index = pokemon.natural;
                break;
            case 1:
                index = pokemon.kanto;
                break;
            case 2:
                index = pokemon.johto;
                break;
            case 3:
                index = pokemon.hoenn;
                break;
            case 4:
                index = pokemon.sinnoh;
                break;
            case 5:
                index = pokemon.unova;
                break;
            default:
                break;
        }
        NSString *numString = @"-";
        if (index >= 0) {
            numString = [NSString stringWithFormat:@"%d", index];
        }
        numLabel.text = numString;
    }
    
    feature1Label.text = pokemon.ability1Name;
    [feature2Label setFrame:CGRectMake(185 + pokemon.ability1Name.length * 17, 45, 60, 20)];
    feature2Label.text = pokemon.ability2Name;
    featureHLabel.text = pokemon.abilityHName;
    heightLabel.text = pokemon.height;
    weightLabel.text = pokemon.weight;
    catchLabel.text = [NSString stringWithFormat:@"%d", pokemon.catchRate];
    expLabel.text = [NSString stringWithFormat:@"%d", pokemon.exp];
    stepLabel.text = [NSString stringWithFormat:@"%d", pokemon.hatchStep];
    genderLabel.text = [pokemon getGenderStr];
    unitLabel.text = [pokemon getEvStr];
    eggLabel.text = [pokemon getEggType];
}

- (IBAction)changePage:(id)sender {
    
    int page = topPageControl.currentPage;
    [topScrollView setContentOffset:CGPointMake(320 * page, 0)];
    Pokemon *pokemon = [pokemonList objectAtIndex:page];
    [TopScrollView shareInstance].currPokemon = pokemon;
    shapeLabel.text = pokemon.shape;
    [self loadInfo:pokemon.shapeID];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = (topScrollView.contentOffset.x +160) / 320;
    
    if (page != topPageControl.currentPage) {
        topPageControl.currentPage = page;
        Pokemon *pokemon = [pokemonList objectAtIndex:page];
        shapeLabel.text = pokemon.shape;
        [self loadInfo:pokemon.shapeID];
    }
    
    
}

@end
