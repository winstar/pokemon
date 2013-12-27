//
//  EvolutionView.m
//  pokemon
//
//  Created by 王建平 on 13-7-7.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "EvolutionView.h"
#import "SqliteHelper.h"
#import "PMTypeColor.h"
#import "PokemonInfoViewController.h"
#import "Globle.h"

@implementation EvolutionView {
    NSArray *statusArray;
    PMTypeColor *pmTypeColor;
    int currentPM;
    UIScrollView *evoScrollView;
    PokemonInfoViewController *infoController;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        statusArray = [NSArray arrayWithObjects:@"未进化", @"第一阶段", @"第二阶段", nil];
        pmTypeColor = [PMTypeColor shareInstance];
        float height = [[Globle shareInstance] viewHeight];
        evoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
        [self addSubview:evoScrollView];
    }
    return self;
}

- (void)setController:(UIViewController *)controller
{
    infoController = (PokemonInfoViewController *)controller;
}

- (void) loadUI:(int)id
{
    float height = [[Globle shareInstance] viewHeight];
    evoScrollView.contentSize = CGSizeMake(320, height);
    currentPM = id;
    for (UIView *view in evoScrollView.subviews) {
        [view removeFromSuperview];
    }
    SqliteHelper *helper = [SqliteHelper sharedHelper];
    NSMutableArray *evoArray = [helper getEvolution:id];
    
    if (evoArray.count != 0) {
        
        Evolution *firstEvo = [evoArray objectAtIndex:0];
        if (firstEvo.fromId == 265) {
            evoArray = [helper getEvolution:265];
        }
        
        NSMutableSet *PMIdSet = [NSMutableSet setWithCapacity:3];
        for (Evolution *evol in evoArray) {
            NSNumber *fromNum = [NSNumber numberWithInt:evol.fromId];
            NSNumber *toNum = [NSNumber numberWithInt:evol.toId];
            if ([PMIdSet containsObject:fromNum] == NO) {
                [PMIdSet addObject:fromNum];
            }
            if ([PMIdSet containsObject:toNum] == NO) {
                [PMIdSet addObject:toNum];
            }
        }
        
        NSString *ids = [[PMIdSet allObjects] componentsJoinedByString:@","];
        NSMutableArray *pmArray = [helper getPokemons:ids];
        NSMutableDictionary *pmDic = [NSMutableDictionary dictionaryWithCapacity:3];
        for (PMCell *cell in pmArray) {
            [pmDic setObject:cell forKey:[NSNumber numberWithInt:cell.id]];
        }
        
        if (evoArray.count == 1) {
            Evolution *evolution = [evoArray objectAtIndex:0];
            [self buildPM:CGPointMake(50, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:evolution.fromId]] WithStatus:evolution.level - 1];
            [self buildEvolution:evolution Position:CGPointMake(120, 20) Width:80];
            [self buildPM:CGPointMake(200, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:evolution.toId]] WithStatus:evolution.level];
        } else if (evoArray.count == 2) {
            Evolution *firstEvolution = [evoArray objectAtIndex:0];
            Evolution *secondEvolution = [evoArray objectAtIndex:1];
            if (firstEvolution.level == 1 && secondEvolution.level == 2 && firstEvolution.toId == secondEvolution.fromId) {
                [self buildPM:CGPointMake(10, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.fromId]] WithStatus:0];
                [self buildEvolution:firstEvolution Position:CGPointMake(80, 20) Width:45];
                [self buildPM:CGPointMake(125, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.toId]] WithStatus:1];
                [self buildEvolution:secondEvolution Position:CGPointMake(195, 20) Width:45];
                [self buildPM:CGPointMake(240, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:secondEvolution.toId]] WithStatus:2];
            } else if (firstEvolution.level == 1 && secondEvolution.level == 1 && firstEvolution.fromId == secondEvolution.fromId) {
                [self buildPM:CGPointMake(50, 100) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.fromId]] WithStatus:0];
                [self buildEvolution:firstEvolution Position:CGPointMake(120, 20) Width:80];
                [self buildPM:CGPointMake(200, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.toId]] WithStatus:1];
                [self buildEvolution:secondEvolution Position:CGPointMake(120, 180) Width:80];
                [self buildPM:CGPointMake(200, 180) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:secondEvolution.toId]] WithStatus:1];
            }
        } else if (evoArray.count == 3) {
            Evolution *firstEvolution = [evoArray objectAtIndex:0];
            Evolution *secondEvolution = [evoArray objectAtIndex:1];
            Evolution *thirdEvolution = [evoArray objectAtIndex:2];
            if (firstEvolution.fromId == 236) {
                [self buildPM:CGPointMake(50, 130) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.fromId]] WithStatus:0];
                [self buildEvolution:firstEvolution Position:CGPointMake(120, 0) Width:80];
                [self buildPM:CGPointMake(200, 0) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.toId]] WithStatus:1];
                [self buildEvolution:secondEvolution Position:CGPointMake(120, 130) Width:80];
                [self buildPM:CGPointMake(200, 130) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:secondEvolution.toId]] WithStatus:1];
                [self buildEvolution:thirdEvolution Position:CGPointMake(120, 260) Width:80];
                [self buildPM:CGPointMake(200, 260) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:thirdEvolution.toId]] WithStatus:1];
            } else {
                [self buildPM:CGPointMake(10, 100) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.fromId]] WithStatus:0];
                [self buildEvolution:firstEvolution Position:CGPointMake(80, 100) Width:45];
                [self buildPM:CGPointMake(125, 100) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.toId]] WithStatus:1];
                [self buildEvolution:secondEvolution Position:CGPointMake(195, 20) Width:45];
                [self buildPM:CGPointMake(240, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:secondEvolution.toId]] WithStatus:2];
                [self buildEvolution:thirdEvolution Position:CGPointMake(195, 180) Width:45];
                [self buildPM:CGPointMake(240, 180) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:thirdEvolution.toId]] WithStatus:2];
            }
        } else if (evoArray.count == 4) {
            Evolution *firstEvolution = [evoArray objectAtIndex:0];
            Evolution *secondEvolution = [evoArray objectAtIndex:1];
            Evolution *thirdEvolution = [evoArray objectAtIndex:2];
            Evolution *fourthEvolution = [evoArray objectAtIndex:3];
            [self buildPM:CGPointMake(10, 100) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.fromId]] WithStatus:0];
            [self buildEvolution:firstEvolution Position:CGPointMake(80, 20) Width:45];
            [self buildPM:CGPointMake(125, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.toId]] WithStatus:1];
            [self buildEvolution:firstEvolution Position:CGPointMake(80, 180) Width:45];
            [self buildPM:CGPointMake(125, 180) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:secondEvolution.toId]] WithStatus:1];
            if (firstEvolution.toId == thirdEvolution.fromId) {
                [self buildEvolution:thirdEvolution Position:CGPointMake(195, 20) Width:45];
                [self buildPM:CGPointMake(240, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:thirdEvolution.toId]] WithStatus:2];
                [self buildEvolution:fourthEvolution Position:CGPointMake(195, 180) Width:45];
                [self buildPM:CGPointMake(240, 180) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:fourthEvolution.toId]] WithStatus:2];
            } else {
                [self buildEvolution:fourthEvolution Position:CGPointMake(195, 20) Width:45];
                [self buildPM:CGPointMake(240, 20) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:fourthEvolution.toId]] WithStatus:2];
                [self buildEvolution:thirdEvolution Position:CGPointMake(195, 180) Width:45];
                [self buildPM:CGPointMake(240, 180) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:thirdEvolution.toId]] WithStatus:2];
            }
            
        } else {
            evoScrollView.contentSize = CGSizeMake(320, 445);
            Evolution *firstEvolution = [evoArray objectAtIndex:0];
            [self buildYiBuPM:CGPointMake(125, 190) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:firstEvolution.fromId]]];
            for (int i=0; i<evoArray.count; i++) {
                Evolution *evolution = [evoArray objectAtIndex:i];
                if (i < 4) {
                    [self buildPM:CGPointMake(8 + i * 78, 10) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:evolution.toId]] WithStatus:1];
                    [self buildYiBu:evolution Position:CGPointMake(8 + i * 78, 125) Direct:3];
                } else {
                    [self buildPM:CGPointMake(8 + (i - 4) * 78, 326) WithPM:[pmDic objectForKey:[NSNumber numberWithInt:evolution.toId]] WithStatus:1];
                    [self buildYiBu:evolution Position:CGPointMake(8 + (i - 4) * 78, 260) Direct:1];
                }
            }
            
        }
    }
}

- (void)buildEvolution:(Evolution *)evolution Position:(CGPoint)position Width:(int)width
{
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + (width - 16) / 2, position.y + 20, 16, 16)];
    NSString *numberStr = [NSString stringWithFormat:@"DJ%d", evolution.iconId];
    iconImageView.image = [UIImage imageNamed:numberStr];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [evoScrollView addSubview:iconImageView];
    
    UILabel *methodLabel = [[UILabel alloc] initWithFrame:CGRectMake(position.x, position.y + 26, width, 50)];
    methodLabel.font = [UIFont systemFontOfSize:9];
    methodLabel.text = evolution.method;
    methodLabel.lineBreakMode = NSLineBreakByCharWrapping;
    methodLabel.numberOfLines = 0;
    methodLabel.backgroundColor = [UIColor clearColor];
    methodLabel.textAlignment = NSTextAlignmentCenter;
    [evoScrollView addSubview:methodLabel];
    
    UIImageView *fxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + (width - 30) / 2, position.y + 65, 30, 30)];
    fxImageView.image = [UIImage imageNamed:@"jiantou"];
    fxImageView.contentMode = UIViewContentModeScaleAspectFit;
    [evoScrollView addSubview:fxImageView];
}

- (void)buildYiBu:(Evolution *)evolution Position:(CGPoint)position Direct:(int)direct
{
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + 27, position.y + 8, 16, 16)];
    NSString *numberStr = [NSString stringWithFormat:@"DJ%d", evolution.iconId];
    iconImageView.image = [UIImage imageNamed:numberStr];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [evoScrollView addSubview:iconImageView];
    
    UILabel *methodLabel = [[UILabel alloc] initWithFrame:CGRectMake(position.x, position.y + 20, 70, 40)];
    methodLabel.font = [UIFont systemFontOfSize:9];
    methodLabel.text = evolution.method;
    methodLabel.backgroundColor = [UIColor clearColor];
    methodLabel.lineBreakMode = NSLineBreakByCharWrapping;
    methodLabel.numberOfLines = 0;
    methodLabel.textAlignment = NSTextAlignmentCenter;
    [evoScrollView addSubview:methodLabel];
    
    UIImageView *fxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + 29, position.y + 55, 12, 12)];
    fxImageView.image = [UIImage imageNamed:@"jiantou"];
        fxImageView.transform = CGAffineTransformMakeRotation(M_PI * 0.5 * direct);
    fxImageView.contentMode = UIViewContentModeScaleAspectFit;
    [evoScrollView addSubview:fxImageView];
}

- (void)pmImageDidTap:(UITapGestureRecognizer *)recognizer
{
    UIImageView *pokemonImageView = (UIImageView *)recognizer.view;
    int pokemonId = pokemonImageView.tag - 1000;
    [infoController changePokemon:pokemonId];
}

- (void)buildYiBuPM:(CGPoint)position WithPM:(PMCell *)pmCell
{
    UIImageView *pmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + 5, position.y + 5, 60, 60)];
    NSString *numberStr = [NSString stringWithFormat:@"%03d", pmCell.id];
    pmImageView.image = [UIImage imageNamed:numberStr];
    pmImageView.contentMode = UIViewContentModeScaleAspectFit;
    [evoScrollView addSubview:pmImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(position.x - 40, position.y + 25, 35, 20)];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = pmCell.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    if (currentPM == pmCell.id) {
        nameLabel.backgroundColor = [pmTypeColor getTypeColor:pmCell.type1];
        nameLabel.textColor = [UIColor whiteColor];
    } else {
        pmImageView.userInteractionEnabled = YES;
        pmImageView.tag = 1000 + pmCell.id;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pmImageDidTap:)];
        [pmImageView addGestureRecognizer:recognizer];
    }
    [evoScrollView addSubview:nameLabel];
    
    UILabel *type1Label = [[UILabel alloc] initWithFrame:CGRectMake(position.x + 70, position.y + 25, 20, 20)];
    type1Label.font = [UIFont systemFontOfSize:13];
    type1Label.backgroundColor = [pmTypeColor getTypeColor:pmCell.type1];
    type1Label.text = [pmTypeColor getTypeName:pmCell.type1];
    type1Label.textColor = [UIColor whiteColor];
    type1Label.textAlignment = NSTextAlignmentCenter;
    [evoScrollView addSubview:type1Label];
}

- (void)buildPM:(CGPoint)position WithPM:(PMCell *)pmCell WithStatus:(int)status
{
    UIImageView *pmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + 5, position.y + 5, 60, 60)];
    NSString *numberStr = [NSString stringWithFormat:@"%03d", pmCell.id];
    pmImageView.image = [UIImage imageNamed:numberStr];
    pmImageView.contentMode = UIViewContentModeScaleAspectFit;
    [evoScrollView addSubview:pmImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(position.x, position.y + 70, 70, 20)];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.text = pmCell.name;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    if (currentPM == pmCell.id) {
        nameLabel.backgroundColor = [pmTypeColor getTypeColor:pmCell.type1];
        nameLabel.textColor = [UIColor whiteColor];
    } else {
        pmImageView.userInteractionEnabled = YES;
        pmImageView.tag = 1000 + pmCell.id;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pmImageDidTap:)];
        [pmImageView addGestureRecognizer:recognizer];
    }
    [evoScrollView addSubview:nameLabel];
    
    int offset = 25;
    if (pmCell.type2 != 0) {
        offset = 13;
    }
    UILabel *type1Label = [[UILabel alloc] initWithFrame:CGRectMake(position.x + offset, position.y + 95, 20, 20)];
    type1Label.font = [UIFont systemFontOfSize:13];
    type1Label.backgroundColor = [pmTypeColor getTypeColor:pmCell.type1];
    type1Label.text = [pmTypeColor getTypeName:pmCell.type1];
    type1Label.textColor = [UIColor whiteColor];
    type1Label.textAlignment = NSTextAlignmentCenter;
    [evoScrollView addSubview:type1Label];
    
    if (pmCell.type2 != 0) {
        UILabel *type2Label = [[UILabel alloc] initWithFrame:CGRectMake(position.x + 37, position.y + 95, 20, 20)];
        type2Label.font = [UIFont systemFontOfSize:13];
        type2Label.backgroundColor = [pmTypeColor getTypeColor:pmCell.type2];
        type2Label.text = [pmTypeColor getTypeName:pmCell.type2];
        type2Label.textColor = [UIColor whiteColor];
        type2Label.textAlignment = NSTextAlignmentCenter;
        [evoScrollView addSubview:type2Label];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
