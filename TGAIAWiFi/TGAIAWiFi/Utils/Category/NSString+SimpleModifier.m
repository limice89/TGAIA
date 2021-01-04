//
//  NSString+SimpleModifier.m
//  DailyDemo
//
//  Created by 俊欧巴 on 17/7/14.
//  Copyright © 2017年 俊欧巴. All rights reserved.
//

#import "NSString+SimpleModifier.h"

@implementation NSString (SimpleModifier)

+ (NSMutableDictionary *)retunRichTextDic{
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@"[/闭嘴]"] = [UIImage imageNamed:@"im_ee_000"];
    mapper[@"[/大笑]"] = [UIImage imageNamed:@"im_ee_001"];
    mapper[@"[/吐舌]"] = [UIImage imageNamed:@"im_ee_002"];
    mapper[@"[/汗]"] = [UIImage imageNamed:@"im_ee_003"];
    mapper[@"[/偷笑]"] = [UIImage imageNamed:@"im_ee_004"];
    mapper[@"[/再见]"] = [UIImage imageNamed:@"im_ee_005"];
    mapper[@"[/打头]"] = [UIImage imageNamed:@"im_ee_006"];
    mapper[@"[/无语]"] = [UIImage imageNamed:@"im_ee_007"];
    mapper[@"[/猪头]"] = [UIImage imageNamed:@"im_ee_008"];
    mapper[@"[/鲜花]"] = [UIImage imageNamed:@"im_ee_009"];
    mapper[@"[/流泪]"] = [UIImage imageNamed:@"im_ee_010"];
    mapper[@"[/哭]"] = [UIImage imageNamed:@"im_ee_011"];
    mapper[@"[/安静]"] = [UIImage imageNamed:@"im_ee_012"];
    mapper[@"[/酷]"] = [UIImage imageNamed:@"im_ee_013"];
    mapper[@"[/狂躁]"] = [UIImage imageNamed:@"im_ee_014"];
    mapper[@"[/委屈]"] = [UIImage imageNamed:@"im_ee_015"];
    mapper[@"[/大便]"] = [UIImage imageNamed:@"im_ee_016"];
    mapper[@"[/地雷]"] = [UIImage imageNamed:@"im_ee_017"];
    mapper[@"[/菜刀]"] = [UIImage imageNamed:@"im_ee_018"];
    mapper[@"[/可爱]"] = [UIImage imageNamed:@"im_ee_019"];
    mapper[@"[/色]"] = [UIImage imageNamed:@"im_ee_020"];
    mapper[@"[/害羞]"] = [UIImage imageNamed:@"im_ee_021"];
    mapper[@"[/得意]"] = [UIImage imageNamed:@"im_ee_022"];
    mapper[@"[/吐]"] = [UIImage imageNamed:@"im_ee_023"];
    mapper[@"[/微笑]"] = [UIImage imageNamed:@"im_ee_024"];
    mapper[@"[/愤怒]"] = [UIImage imageNamed:@"im_ee_025"];
    mapper[@"[/糗]"] = [UIImage imageNamed:@"im_ee_026"];
    mapper[@"[/惊恐]"] = [UIImage imageNamed:@"im_ee_027"];
    mapper[@"[/糗了]"] = [UIImage imageNamed:@"im_ee_028"];
    mapper[@"[/心]"] = [UIImage imageNamed:@"im_ee_029"];
    mapper[@"[/吻]"] = [UIImage imageNamed:@"im_ee_030"];
    mapper[@"[/白眼]"] = [UIImage imageNamed:@"im_ee_031"];
    mapper[@"[/撅嘴]"] = [UIImage imageNamed:@"im_ee_032"];
    mapper[@"[/悲伤]"] = [UIImage imageNamed:@"im_ee_033"];
    mapper[@"[/惊讶]"] = [UIImage imageNamed:@"im_ee_034"];
    mapper[@"[/问号]"] = [UIImage imageNamed:@"im_ee_035"];
    mapper[@"[/睡觉]"] = [UIImage imageNamed:@"im_ee_036"];
    mapper[@"[/亲亲]"] = [UIImage imageNamed:@"im_ee_037"];
    mapper[@"[/笑]"] = [UIImage imageNamed:@"im_ee_038"];
    mapper[@"[/亲爱]"] = [UIImage imageNamed:@"im_ee_039"];
    mapper[@"[/衰]"] = [UIImage imageNamed:@"im_ee_040"];
    mapper[@"[/发抖]"] = [UIImage imageNamed:@"im_ee_041"];
    mapper[@"[/窃喜]"] = [UIImage imageNamed:@"im_ee_042"];
    mapper[@"[/奋斗]"] = [UIImage imageNamed:@"im_ee_043"];
    mapper[@"[/鼻血]"] = [UIImage imageNamed:@"im_ee_044"];
    mapper[@"[/右哼哼]"] = [UIImage imageNamed:@"im_ee_045"];
    mapper[@"[/拥抱]"] = [UIImage imageNamed:@"im_ee_046"];
    mapper[@"[/狂喜]"] = [UIImage imageNamed:@"im_ee_047"];
    mapper[@"[/爱心]"] = [UIImage imageNamed:@"im_ee_048"];
    mapper[@"[/鄙视]"] = [UIImage imageNamed:@"im_ee_049"];
    mapper[@"[/晕]"] = [UIImage imageNamed:@"im_ee_050"];
    mapper[@"[/抽烟]"] = [UIImage imageNamed:@"im_ee_051"];
    mapper[@"[/可怜]"] = [UIImage imageNamed:@"im_ee_052"];
    mapper[@"[/真棒]"] = [UIImage imageNamed:@"im_ee_053"];
    mapper[@"[/差劲]"] = [UIImage imageNamed:@"im_ee_054"];
    mapper[@"[/握手]"] = [UIImage imageNamed:@"im_ee_055"];
    mapper[@"[/幸运]"] = [UIImage imageNamed:@"im_ee_056"];
    mapper[@"[/抱拳]"] = [UIImage imageNamed:@"im_ee_057"];
    mapper[@"[/枯萎]"] = [UIImage imageNamed:@"im_ee_058"];
    mapper[@"[/吃饭]"] = [UIImage imageNamed:@"im_ee_059"];
    mapper[@"[/生日]"] = [UIImage imageNamed:@"im_ee_060"];
    mapper[@"[/西瓜]"] = [UIImage imageNamed:@"im_ee_061"];
    mapper[@"[/喝茶]"] = [UIImage imageNamed:@"im_ee_062"];
    mapper[@"[/虫]"] = [UIImage imageNamed:@"im_ee_063"];
    mapper[@"[/勾引]"] = [UIImage imageNamed:@"im_ee_064"];
    mapper[@"[/OK]"] = [UIImage imageNamed:@"im_ee_065"];
    mapper[@"[/我爱你]"] = [UIImage imageNamed:@"im_ee_066"];
    mapper[@"[/咖啡]"] = [UIImage imageNamed:@"im_ee_067"];
    mapper[@"[/晚安]"] = [UIImage imageNamed:@"im_ee_068"];
    mapper[@"[/刀]"] = [UIImage imageNamed:@"im_ee_069"];
    mapper[@"[/滑到]"] = [UIImage imageNamed:@"im_ee_070"];
    mapper[@"[/小拇指]"] = [UIImage imageNamed:@"im_ee_071"];
    mapper[@"[/拳头]"] = [UIImage imageNamed:@"im_ee_072"];
    mapper[@"[/心碎]"] = [UIImage imageNamed:@"im_ee_073"];
    mapper[@"[/太阳]"] = [UIImage imageNamed:@"im_ee_074"];
    mapper[@"[/礼物]"] = [UIImage imageNamed:@"im_ee_075"];
    mapper[@"[/足球]"] = [UIImage imageNamed:@"im_ee_076"];
    mapper[@"[/骷髅]"] = [UIImage imageNamed:@"im_ee_077"];
    mapper[@"[/投降]"] = [UIImage imageNamed:@"im_ee_078"];
    mapper[@"[/闪电]"] = [UIImage imageNamed:@"im_ee_079"];
    mapper[@"[/撇嘴]"] = [UIImage imageNamed:@"im_ee_080"];
    mapper[@"[/困]"] = [UIImage imageNamed:@"im_ee_081"];
    mapper[@"[/大骂]"] = [UIImage imageNamed:@"im_ee_082"];
    mapper[@"[/烦躁]"] = [UIImage imageNamed:@"im_ee_083"];
    mapper[@"[/抠鼻]"] = [UIImage imageNamed:@"im_ee_084"];
    mapper[@"[/鼓掌]"] = [UIImage imageNamed:@"im_ee_085"];
    mapper[@"[/糗大了]"] = [UIImage imageNamed:@"im_ee_086"];
    mapper[@"[/左哼哼]"] = [UIImage imageNamed:@"im_ee_087"];
    mapper[@"[/哈切]"] = [UIImage imageNamed:@"im_ee_088"];
    mapper[@"[/悲伤]"] = [UIImage imageNamed:@"im_ee_089"];
    mapper[@"[/瞪眼]"] = [UIImage imageNamed:@"im_ee_090"];
    mapper[@"[/篮球]"] = [UIImage imageNamed:@"im_ee_091"];
    mapper[@"[/乒乓球]"] = [UIImage imageNamed:@"im_ee_092"];
    mapper[@"[/食指]"] = [UIImage imageNamed:@"im_ee_093"];
    mapper[@"[/跳]"] = [UIImage imageNamed:@"im_ee_094"];
    mapper[@"[/吼叫]"] = [UIImage imageNamed:@"im_ee_095"];
    mapper[@"[/飞]"] = [UIImage imageNamed:@"im_ee_096"];
    mapper[@"[/站立]"] = [UIImage imageNamed:@"im_ee_097"];
    mapper[@"[/背对]"] = [UIImage imageNamed:@"im_ee_098"];
    mapper[@"[/跳绳]"] = [UIImage imageNamed:@"im_ee_099"];
    mapper[@"[/着急]"] = [UIImage imageNamed:@"im_ee_100"];
    mapper[@"[/跳起]"] = [UIImage imageNamed:@"im_ee_101"];
    mapper[@"[/望风]"] = [UIImage imageNamed:@"im_ee_102"];
    mapper[@"[/左太极]"] = [UIImage imageNamed:@"im_ee_103"];
    mapper[@"[/右太极]"] = [UIImage imageNamed:@"im_ee_104"];
    return mapper;
}



@end
