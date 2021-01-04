//
//  MCalendarCollectionCell.h
//  GoldCalendarFramework
//
//  Created by Micker on 16/5/5.
//  Copyright © 2016年 micker.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCalendarItem.h"

@interface MCalendarCollectionCell : UICollectionViewCell
@property (nonatomic, strong) NSArray *dateArray; //有未上映电影日期list
@property (nonatomic, assign) BOOL isShowRedPoint;
- (void) doSetContentData:(id) content;

@end
