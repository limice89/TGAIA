//
//  TGResetAlertView.m
//  TGAIAWiFi
//
//  Created by admin on 2021/1/4.
//

#import "TGResetAlertView.h"

@interface TGResetAlertView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//温馨提示
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;//内容
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;//确认按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮

@end

@implementation TGResetAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    ViewBorderRadius(self.doneBtn, 22, 1, kColorFromRGB(0xdddddd));
    ViewRadius(self.cancelBtn, 22);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
