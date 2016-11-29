//
//  jwAutoStepView.h
//  jwAutoStepView
//
//  Created by JW_N on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jwAutoStepModel.h"


// 默认枚举
typedef NS_ENUM(NSUInteger, CONFIG_TYPE) {
    CONFIG_TYPE_UNDEF = 0,// 非默认
    CONFIG_TYPE_DEF = 1,  // 默认的
};

@interface jwAutoStepView : UIView


#pragma mark———————— 重要方法


/*传入页面数据  （data 为 内容条数不固定）<🐂>*/
- (void)set_asv_uiData:(NSMutableArray<jwAutoStepModel*>*)data;


/*传入页面数据 （data 为 附加内容条数不固定）<🐂>*/
- (void)set_asv_addData:(NSMutableArray*)data;


/*返回组件 高度 <🐂>*/
- (CGFloat)get_asv_ControlHeight;


/*默认设置 <🏃你可以省去“次要方法”配置，直接在该方法内去配置😊>*/
-(void)set_asv_default;

#pragma mark———————— 次要方法


/*正在进行step的 帽子 颜色,反之颜色 <☕️>*/
- (void)set_asv_capColor_steping:(UIColor*)c1 oppose:(UIColor*)c2 cap:(UIColor*)c3;


/*正在进行step的 帽杆 颜色,反之颜色 <☕️>*/
- (void)set_asv_capBarColor_setping:(UIColor*)c1 oppose:(UIColor*)c2 cap:(UIColor*)c3;


/*box 内文字的颜色 <☕️>*/
- (void)set_asv_boxTextColor_steping:(UIColor*)c1 oppose:(UIColor*)c2;


/*box 边框的颜色 <☕️>*/
- (void)set_asv_boxBorderColor_stepingColor:(UIColor*)c1 oppose:(UIColor*)c2;


/* cap 内文字的颜色 <☕️>*/
- (void)set_asv_capTextColor_steping:(UIColor*)c1 oppose:(UIColor*)c2;


/*帽子文字（默认为 [1期...]有缺失校验）<☕️> */
- (void)set_asv_CapTitles:(NSArray*)tAry;


/*帽子距离最左边距离（def=25） <☕️>*/
- (void)set_asv_CapLeft:(CGFloat)l_m;


/*帽子的直径（def=25） <☕️>*/
- (void)set_asv_CapDiameter:(CGFloat)d;


/*帽杆与帽子的比例（0.01f ~ 1.0f ; def=0.1）<☕️> */
- (void)set_asv_CapRodScale:(CGFloat)crScale;


/*box距离页面最右边的距离（def = 25）<☕️>*/
- (void)set_asv_BoxRight:(CGFloat)r_m;


/* box 与 Lab 水平左右 间距（def = CGSize(10,10)）<☕️>*/
- (void)set_asv_BoxMarginLab_L_R:(CGSize)bllrSize;


#pragma mark-———————— <⚠️>如要实现，必须在 添加数据之前调用，不然不能实现<⚠️>
/* box 内 Lab 与 Lab 竖直 间距（def = 10）<☕️>*/
/* ⚠️ box 内 首个 Lab 与 box 顶部间距由 宏定义，这里不再提供方法修改*/
- (void)set_asv_inBox_LabMarginLab_V:(CGFloat)llmv;


@end


@interface jwAutoStepView ()
{
    NSInteger _count;// 要画图的个数
    BOOL _isAddNper; // 是否添加期数
    CONFIG_TYPE _mouthType; // 嘴尖设置
    NSMutableArray *_lines_y_Ary;
    NSMutableArray *_box_mouths_y_Ary;//嘴角高度数组
    NSMutableArray *_box_h_Ary;//box框高度的数组
    CGRect _capFirstFrame;//未来可能外部设定的参数（原意：insetedg,暂无用）
    NSMutableArray<jwAutoStepModel*> *_modelsAry;//外部数据模型数组
    UIColor *_capColor_1,*_capColor_2;//颜色设置
    UIColor *_capBarColor_1,*_capBarColor_2;
    UIColor *_boxLabsColor_1,*_boxLabsColor_2;
    UIColor *_boxBoardColor_1,*_boxBoardColor_2;
    UIColor *_capTextColor_1,*_capTextColor_2;
    NSArray *_coverTextsAry;// 左边的覆盖标题
    NSMutableArray *_innerBoxsLabsAry;//包裹数组的数组（box内数组(主打titles)）
    NSMutableArray *_innerBoxsLabs_hs_Ary;//包裹数组的数组（box内数组(主打heights)）
    NSMutableArray *_addtionsAry;// 就是一个box的附加 infos
    NSMutableArray *_addtions_hs_Ary;// 就是附加boxs的高度数组
    NSMutableArray *_wholeLabs_Ary,*_capsLabs_Ary,*_addLabs_Ary;//所有labs(刷新用于删除旧数据)
}
@end



/*
 *********************************************************************
 *
 *
 * 博客地址:http://www.jianshu.com/p/80ef2d47729d
 * GitHub:https://github.com/NIUXINGJIAN/MilestonesAndTimeline.git
 * ** 请摁一下，😋 **
 *  做简单的封装，麻烦自己，方便别人
 *********************************************************************
 */
