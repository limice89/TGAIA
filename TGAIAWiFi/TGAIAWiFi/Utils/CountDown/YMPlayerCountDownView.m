//
//  YMPlayerCountDownView.m
//  yunMovie
//
//  Created by admin on 2020/9/27.
//  Copyright © 2020 limice. All rights reserved.
//

#import "YMPlayerCountDownView.h"

@interface YMPlayerCountDownView()
@property (weak, nonatomic) IBOutlet UIImageView *posterImgView;

@end
@implementation YMPlayerCountDownView
- (IBAction)backButtonTapped:(id)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}
-(void)setPosterUrl:(NSString *)posterUrl{
    _posterUrl = posterUrl;
    [self.posterImgView sd_setImageWithURL:[NSURL URLWithString:posterUrl]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
