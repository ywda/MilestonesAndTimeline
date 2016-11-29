//
//  jw_ASV_Macro.h
//  jwAutoStepView
//
//  Created by JW_N on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef jw_ASV_Macro_h
#define jw_ASV_Macro_h

#pragma mark————————> (jwAutoStepView)方法宏定义

#define K_Cap_X  25 // 帽子x
#define K_Cap_Y  30 // 帽子y (默认)
#define K_Cap_W  25 // 帽子宽度
#define K_Cap_H  K_Cap_W // 帽子高度

#define K_Cap_B_B_Scale 0.1 // 帽子与帽杆的比例
#define K_LAB_LINE_DESTENCE  3 // 如果Lab大于1行的行间距

#define K_MOUTH_W_MARGIN 10 // 嘴角的宽度
#define K_MOUTH_H_MARGIN K_MOUTH_W_MARGIN *0.6 // 嘴角的高度
#define K_P_2_X  (FIRST_P_X + K_MOUTH_W_MARGIN)// 绘制第二个点的X值
#define BOX_RIGHT_MARGIN  25//边框距离最右边的距离

#define K_Line_H ((K_Cap_W)*1.40f) // 默认的帽子下面杆子高度

#define K_Cap_Box_Margin 8 // 帽子与Box间距

#define JW_A_S_MAINS_WIDTH [[UIScreen mainScreen] bounds].size.width//屏幕宽

// 第一个点的起始位置
#define FIRST_P_X  ((K_Cap_X)+(K_Cap_W)+(K_Cap_Box_Margin))
#define BOX_WIDTH  (JW_A_S_MAINS_WIDTH-K_Cap_X-K_Cap_W-K_Cap_Box_Margin-BOX_RIGHT_MARGIN) // 虚线框的宽度

// box 与 lab 与 lab 间距
#define K_inBOX_M_LAB_H  10.0f  // box 与 Lab 水平 左右 间距
#define K_BOX_M_LAB_V  10.0f  // box 内 Lab 与 Lab 竖直 间距
#define K_BOX_LR_LAB_SIZE  CGSizeMake(inK_BOX_M_LAB_H, inK_BOX_M_LAB_H)// box 与 Lab 水平 左右 间距

#define K_L_H   21 // 一个Lab 的默认高度

#define K_CONAIN_TOP  100  // 组件页眉距离
#define K_CONAIN_BOTTOM  100  // 组件页脚距离

#define K_BOX_M_BOX_V  20 // 线框间距离 （默认）


#define K_LASTBOX_M_ADDLAB_V  50 // 最后一个box 与首个附加Lab 的竖直距离
#define K_ADDLAB_M_ADDLAB_V  15 // 附加Lab与附加Lab之间的竖直距离

#define K_ADDLAB_M_CONTAIN_L  20 // 附加Lab与组件左边的水平距离
#define K_ADDLAB_M_CONTAIN_R  20 // 附加Lab与组件右边的水平距离


#endif /* jw_ASV_Macro_h */
