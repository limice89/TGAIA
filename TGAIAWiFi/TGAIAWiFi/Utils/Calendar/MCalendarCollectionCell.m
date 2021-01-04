//
//  MCalendarCollectionCell.m
//  GoldCalendarFramework
//
//  Created by Micker on 16/5/5.
//  Copyright © 2016年 micker.cn. All rights reserved.
//

#import "MCalendarCollectionCell.h"
#import "CalendarConfig.h"

@interface MCalendarCollectionCell()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, assign) UIColor *normalColor;
@property (nonatomic, strong) MCalendarItem *item;
@property (nonatomic, strong) UIView *redPointView;
@end

@implementation MCalendarCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImgView];
        [self addSubview:self.label];
        [self addSubview:self.redPointView];
        self.redPointView.hidden = YES;
    }
    return self;
}
-(void)setDateArray:(NSArray *)dateArray{
    _dateArray = dateArray;
    NSString *dateItem = [self.item.date stringWithFormat:KDateFormatter05];
    for (int i = 0; i<dateArray.count; i++) {
        NSDictionary *dict = [dateArray objectAtIndex:i];
        NSString *playTime = [dict objectForKey:@"playTime"];
        if ([playTime isEqualToString:dateItem]) {
            self.redPointView.hidden = NO;
        }else{
            self.redPointView.hidden = YES;
        }
    }
}
-(void)setIsShowRedPoint:(BOOL)isShowRedPoint{
    _isShowRedPoint = isShowRedPoint;
    self.redPointView.hidden = !isShowRedPoint;
}
- (UILabel *) label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.text = @"";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14.0f];
        _label.numberOfLines = 2;
        _label.backgroundColor = [UIColor clearColor];
    }
    return _label;
}
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_selectdate_icon"]];
        _bgImgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return _bgImgView;
}
- (void) doSetContentData:(id) content {
    self.item = (MCalendarItem *) content;
    self.bgImgView.hidden = !self.isSelected;
    if(_item.inMonth) {
        if (_item.isToday) {
            NSString *day = [NSString stringWithFormat:@"%@",@([_item.date day])];
            NSString *result = [NSString stringWithFormat:@"%@", day];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:result];
            [attributeString addAttribute:NSFontAttributeName
                                    value:[UIFont systemFontOfSize:12.0f]
                                    range:NSMakeRange(day.length, result.length - day.length)];
            
            _label.attributedText = attributeString;
            _label.textColor = self.isSelected ? [CalendarConfig sharedInstance].todaySelectedTextColor : [CalendarConfig sharedInstance].todayTextColor;
//            _label.backgroundColor = [CalendarConfig sharedInstance].todayBackgroundColor;
            
        }
        else {
            _label.text = [NSString stringWithFormat:@"%@", @([_item.date day])];
            _label.textColor = self.isSelected ? [CalendarConfig sharedInstance].selectTextColor : [CalendarConfig sharedInstance].textColor;
//            _label.backgroundColor = [CalendarConfig sharedInstance].backgroundColor;
        }
        
        if (self.isSelected && [_label.text length] > 0) {
            _label.textColor = [UIColor whiteColor];
//            _label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar_selectdate_icon"]];
//            _label.backgroundColor = [CalendarConfig sharedInstance].selectBackgroundColor;
        }
    } else {
        _label.text = [NSString stringWithFormat:@"%@", @([_item.date day])];
        _label.textColor = [UIColor lightGrayColor];
        _label.backgroundColor = [CalendarConfig sharedInstance].outBackgroundColor;
    }
    
}
-(UIView *)redPointView{
    if (!_redPointView) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        _redPointView = [[UIView alloc] initWithFrame:CGRectMake(width/2-2, height-5, 4, 4)];
        _redPointView.backgroundColor = KRedColor;
        ViewRadius(_redPointView, 2);
    }
    return _redPointView;
}

@end
