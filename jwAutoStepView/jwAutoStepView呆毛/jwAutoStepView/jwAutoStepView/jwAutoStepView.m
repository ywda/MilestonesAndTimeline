//
//  jwAutoStepView.m
//  jwAutoStepView
//
//  Created by JW_N on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "jwAutoStepView.h"
#import "UIColor+asv.h"
#import "jw_ASV_Macro.h"

static CGFloat box_bottom_y = 0.0f;
static CGFloat box_mouth_y = 0.0f;
static CGFloat cap_bottom_y = 0.0f;
static CGFloat tempResultHeight = 0.0f;

static CGFloat b_m = 0.0f;

static  UILabel *tempjs_lab = nil;
static  UILabel *tempadd_lab = nil;
static CGFloat add_labs_h = 0.0f;

static CGFloat capLeft = K_Cap_X;
static CGFloat cap_rr = K_Cap_W;

static CGFloat capr_bScale = K_Cap_B_B_Scale;
static CGFloat box_right_m = BOX_RIGHT_MARGIN;
static CGSize  bl_lr_Size;
static CGFloat ll_m_v = K_BOX_M_LAB_V;

@implementation jwAutoStepView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];//组件颜色
    tempjs_lab =  [[UILabel alloc] init];
}

/*传入页面数据 */
-(void)set_asv_uiData:(NSMutableArray<jwAutoStepModel*>*)data{
    
    if ([data isKindOfClass:[NSMutableArray class]]) {
        
        _modelsAry = data;
        _box_h_Ary = [NSMutableArray array];
        _innerBoxsLabsAry = [NSMutableArray array];
        _innerBoxsLabs_hs_Ary = [NSMutableArray array];
        tempjs_lab = [[UILabel alloc] init];
        
        // 首先计算高度，然后渲染，提高效率
        for (int i = 0; i < [_modelsAry count]; i++) {
            
            // 数据模型
            jwAutoStepModel *model = _modelsAry[i];
            NSNumber *number = @([self get_OneBox_h:model]);
            // 存储高度
            [_box_h_Ary addObject:number];
            
        }
        
        tempjs_lab = nil;
    }
}

/*传入页面数据 （data 为 附加内容条数不固定）*/
-(void)set_asv_addData:(NSMutableArray*)data{
    
    if (_addtions_hs_Ary) {
        _addtions_hs_Ary = nil;
    }
    if (_addtionsAry) {
        _addtionsAry = nil;
    }
   
    _addtionsAry = [NSMutableArray arrayWithArray:data];
    _addtions_hs_Ary = [NSMutableArray array];
    
    // 计算附加组件的高度
    add_labs_h = [self get_wholeAddLabs_h:data];

}

// 返回一个 box 渲染组件的高度（就是一个box的高度）
- (CGFloat)get_OneBox_h:(jwAutoStepModel*)model{
    
    CGFloat one_b_h = 0.0f;
    
    /*
     约定规则：
     1、动态缺失校验（数据模型）
     2、根据校验计算位置
     3、开始渲染
     
     校验规则
     a:只有如下若干数据字段
     起息日        (interestDate)
     赎回开始时间   (redeemBigin)
     赎回结束时间   (redeemEnd)
     最近浮动收益分配日 (floatIncome)
     本期到期日        (termEnd)
     产品终止日        (prdEndDate)
     */
    
    // 这里设置自动加载的文字属性字段
    NSString *interestDate = model.interestDate;
    NSString *redeemBigin = model.redeemBigin;
    NSString *redeemEnd = model.redeemEnd;
    NSString *floatIncome = model.floatIncome;
    NSString *termEnd = model.termEnd;
    NSString *prdEndDate = model.prdEndDate;
    
    NSMutableArray *tempAry = [NSMutableArray array];
    
    BOOL is_ok = NO;
    
    is_ok = [self is_NoNuLL_really:interestDate];
    
    if (is_ok) {
        
        [tempAry addObject:interestDate];
    }
    
    
    is_ok = [self is_NoNuLL_really:redeemBigin];
    
    
    if (is_ok) {
        
        [tempAry addObject:redeemBigin];
    }
    
    
    is_ok = [self is_NoNuLL_really:redeemEnd];
    
    
    if (is_ok) {
        
        [tempAry addObject:redeemEnd];
    }
    
    
    is_ok = [self is_NoNuLL_really:floatIncome];
    
    
    if (is_ok) {
        
        [tempAry addObject:floatIncome];
    }
    
    
    is_ok = [self is_NoNuLL_really:termEnd];
    
    
    if (is_ok) {
        
        [tempAry addObject:termEnd];
    }
    
    
    is_ok = [self is_NoNuLL_really:prdEndDate];
    
    
    if (is_ok) {
        
        [tempAry addObject:prdEndDate];
    }
    
    // 存 box 要渲染的 labs 数据
    [_innerBoxsLabsAry addObject:tempAry];
    
    CGFloat add_h = 0.0f;
    
    NSMutableArray *tempLabs_hs_Ary = [NSMutableArray array];
    
    CGFloat temp_oneGroup_labs_hs = 0.0f;
    
    for (int i = 0; i < [tempAry count]; i++) {
        
        CGFloat now_lab_h = 0.0f;
        
        CGFloat la_lab_x = 0.0f;
        CGFloat la_lab_y = 0.0f;
        CGFloat la_lab_w = (BOX_WIDTH - 20);//20与下文一致，不是随意给的
        CGFloat la_lab_h = 0.0f;
        
        CGRect frame = CGRectMake(la_lab_x,
                                  la_lab_y,
                                  la_lab_w,
                                  la_lab_h);

        tempjs_lab.frame = frame;
        [self set_Lab_Constraint_Attribute:tempjs_lab text:tempAry[i] :YES];
        now_lab_h = tempjs_lab.frame.size.height;
        temp_oneGroup_labs_hs += now_lab_h;
        
        // 存储（一个lab高度）内存中
        NSNumber *number = @(now_lab_h);
        [tempLabs_hs_Ary addObject:number];
        
        // 如果是最后一个lab,计算所有空隙距离
        if ((i+1)==[tempAry count]) {
            
            add_h += (ll_m_v *([tempAry count] + 1));
        }
        
    }
    
    // 存储（一组labs高度）内存中
    [_innerBoxsLabs_hs_Ary addObject:tempLabs_hs_Ary];
    
    one_b_h = (temp_oneGroup_labs_hs + add_h);
    //NSLog(@"取得的数据是：(one_b_h = )_____%.2f",one_b_h);
    return one_b_h;
}


// 返回所有 addLab 渲染组件的高度（就是一个 addLab 的高度）
- (CGFloat)get_wholeAddLabs_h:(NSMutableArray*)addtitles{
    
    CGFloat result_h = 0.0f;
    
    tempadd_lab = [[UILabel alloc] init];
    
    for (int i = 0; i < [addtitles count]; i++) {
        
        CGFloat now_lab_h = 0.0f;
        
        CGFloat add_lab_x = 0.0f;
        CGFloat add_lab_y = 0.0f;
        CGFloat add_lab_w = (JW_A_S_MAINS_WIDTH - K_ADDLAB_M_CONTAIN_L - K_ADDLAB_M_CONTAIN_R);
        CGFloat add_lab_h = 0.0f;
        
        CGRect frame = CGRectMake(add_lab_x,
                                  add_lab_y,
                                  add_lab_w,
                                  add_lab_h);
        
        tempadd_lab.frame = frame;
        [self set_Lab_Constraint_Attribute:tempadd_lab text:addtitles[i] :YES];
         now_lab_h = tempadd_lab.frame.size.height;
        
        NSNumber *one_addLas_h = @(now_lab_h);
        [_addtions_hs_Ary addObject:one_addLas_h];
        
        result_h += now_lab_h;
        
        if ((i+1) == [addtitles count]) {
            
            result_h += (K_LASTBOX_M_ADDLAB_V + ((K_ADDLAB_M_ADDLAB_V)*i));
        }
    }
    
    tempadd_lab = nil;
    return result_h;
}


// 设置 Lab 的约束
-(void)set_Lab_Constraint_Attribute:(UILabel*)lab text:(NSString*)labText :(BOOL)isSizeToFit{
    
    lab.numberOfLines = 0;

    lab.font = [UIFont systemFontOfSize:13];
    // 设置 Lab 行距使用
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = K_LAB_LINE_DESTENCE;
    NSDictionary *attributes = @{ NSFontAttributeName:lab.font, NSParagraphStyleAttributeName:paragraphStyle};
    lab.attributedText = [[NSAttributedString alloc]initWithString:labText attributes:attributes];
    if (isSizeToFit) {
        
        [lab sizeToFit];
    }
    
}

// 存在、非nil 判定（对字符串对象判定）
- (BOOL)is_NoNuLL_really:(NSString*)tempStr{
    
    return ((nil != tempStr)&&
            (![tempStr isEqualToString:@""]))?YES:NO;
    
}

/*返回组件 高度 */
- (CGFloat)get_asv_ControlHeight{
    
    int boxNum = 0;
    if (_modelsAry&&(0 != [_modelsAry count])) {
        
        boxNum = (int)[_modelsAry count];
    }
    CGFloat temp_box_h = 0.0f;// 临时变量(高度)
    for (int i = 0; i < boxNum; i++) {
        NSNumber *tempBox_h = (NSNumber*)_box_h_Ary[i];
        temp_box_h += [tempBox_h floatValue];
    }
    
    return  K_CONAIN_TOP + temp_box_h + ((boxNum +1)*K_BOX_M_BOX_V) + add_labs_h + K_CONAIN_BOTTOM;
   
}

- (void)drawRect:(CGRect)rect {
    
    box_bottom_y = K_CONAIN_TOP;
    box_mouth_y = 0.0f;
    cap_bottom_y = 0.0f;
    tempResultHeight = 0.0f;
    b_m = 0.0f;
    
    // Lab 与 box 的左右距离设置
    CGFloat x = K_inBOX_M_LAB_H;
    CGFloat y = K_inBOX_M_LAB_H;
    if (bl_lr_Size.width < K_inBOX_M_LAB_H) {
        x = K_inBOX_M_LAB_H;
    }else{
        x = bl_lr_Size.width;
    }
    if (bl_lr_Size.height < K_inBOX_M_LAB_H) {
        y = K_inBOX_M_LAB_H;
    }else{
        y = bl_lr_Size.height;
    }
    bl_lr_Size = CGSizeMake(x, y);
    
    // Drawing code
    _lines_y_Ary = [NSMutableArray array];
    _box_mouths_y_Ary = [NSMutableArray array];
    
    // 从内存删除box内的labs
    UILabel *temp_lab = nil;
    if (_wholeLabs_Ary) {
        
        for (int i = 0; i < [_wholeLabs_Ary count]; i++) {
            temp_lab = _wholeLabs_Ary[i];
            [temp_lab removeFromSuperview];
            temp_lab = nil;
        }
        _wholeLabs_Ary = nil;
    }
    _wholeLabs_Ary = [NSMutableArray array];
    
    if (_addLabs_Ary) {
        
        for (int i = 0; i < [_addLabs_Ary count]; i++) {
            temp_lab = _addLabs_Ary[i];
            [temp_lab removeFromSuperview];
            temp_lab = nil;
        }
        _addLabs_Ary = nil;
    }
    _addLabs_Ary = [NSMutableArray array];
    
    // 从内存删除帽子上的labs
    if (_capsLabs_Ary) {
        
        UILabel *temp_lab = nil;
        for (int i = 0; i < [_capsLabs_Ary count]; i++) {
            temp_lab = _capsLabs_Ary[i];
            [temp_lab removeFromSuperview];
            temp_lab = nil;
        }
        _capsLabs_Ary = nil;
    }
    _capsLabs_Ary = [NSMutableArray array];
    
    // 临时变量(高度)
    CGFloat now_box_h = 0.0f;
    
    for (int i = 0; i < [_box_h_Ary count]; i++) {
        
        NSNumber *tempBox_h = (NSNumber*)_box_h_Ary[i];
        now_box_h = [tempBox_h floatValue];
    }
    
    b_m = K_BOX_M_BOX_V;
    
    if (!CGRectEqualToRect(CGRectZero, _capFirstFrame)) {
        
    }else{
        
        cap_bottom_y = (K_Cap_Y + K_Cap_H);//初始化值
    }
    
#pragma mark————————> 开始创建 组件
    
    for (int i = 0; i < [_box_h_Ary count]; i++) {
        
#pragma mark ————————> 画一下右边的边框
        
        // 产品的数据模型
        jwAutoStepModel *model = _modelsAry[i];
        
        // 统一颜色设置
        
        UIColor *capColor = nil;
        UIColor *boxBoardColor = nil;
        UIColor *inboxLabsColor = nil;
        UIColor *capTextColor = nil;
        UIColor *capBarColor = nil;
        
        
        if (model.isPassDate) {
            
            capColor = _capColor_1;
            if (!capColor) {
                
                capColor =  K_SET_COLOR_VALUE(@"#45C697");
            }
            
            boxBoardColor = _boxBoardColor_1;
            if (!boxBoardColor) {
                
                boxBoardColor = K_SET_COLOR_VALUE(@"#1d9cbb");
            }
            
            inboxLabsColor = _boxLabsColor_1;
            if (!inboxLabsColor) {
                
               inboxLabsColor =  K_SET_COLOR_VALUE(@"#999999");
            }
            
            capTextColor = _capTextColor_1;
            if (!capTextColor) {
                capTextColor = [UIColor whiteColor];
            }
            
            capBarColor = _capBarColor_1;
            if (!capBarColor) {
                
              capBarColor =  K_SET_COLOR_VALUE(@"#1d9cbb");
                
            }
            
        }else{
            
            capColor = _capColor_2;
            if (!capColor) {
                
                capColor =  K_SET_COLOR_VALUE(@"#999999");
            }
            
            boxBoardColor = _boxBoardColor_2;
            if (!boxBoardColor) {
                
                boxBoardColor = K_SET_COLOR_VALUE(@"#999999");
            }
            
            inboxLabsColor = _boxLabsColor_2;
            if (!inboxLabsColor) {
                
                inboxLabsColor = K_SET_COLOR_VALUE(@"#999999");
            }
            
            capTextColor = _capTextColor_2;
            if (!capTextColor) {
                
                capTextColor = [UIColor whiteColor];
            }
            
            capBarColor = _capBarColor_2;
            if (!capBarColor) {
                
                capBarColor =  K_SET_COLOR_VALUE(@"#1d9cbb");
            }
            
        }
    
        
        // 是否有box
        BOOL is_Box = YES;
        
        if (is_Box) {
            
            // 第n个box的位置
            
            //第n个虚线框的高度
            CGFloat box_h = [((NSNumber*)_box_h_Ary[i]) floatValue];
            
            CGFloat p_1_x = FIRST_P_X - K_Cap_X - K_Cap_W + capLeft + cap_rr;//可以通过修改这里 实现 帽子在 box 内部 效果
            CGFloat p_1_y = box_h/6.0f + K_BOX_M_BOX_V + box_bottom_y;//(box_h/6.0f 这部分原来是 box_h*0.5f ,就是嘴角落的位置)
            if (box_h <= (bl_lr_Size.width +K_L_H+bl_lr_Size.height)) {//bl_lr_Size.width 左边 bl_lr_Size.height 右边距
                p_1_y = box_h*0.5f + K_BOX_M_BOX_V + box_bottom_y;
            }
            CGPoint p_1 = CGPointMake(p_1_x, p_1_y);
            
            box_mouth_y = p_1_y;
            [_lines_y_Ary addObject:@(box_mouth_y)];
            
            CGFloat p_2_x = p_1_x + K_MOUTH_W_MARGIN;//仅仅 FIRST_P_X + K_MOUTH_W_MARGIN 可以实现嘴角在内部
            CGFloat p_2_y = p_1_y - K_MOUTH_H_MARGIN;
            CGPoint p_2 = CGPointMake(p_2_x, p_2_y);
            
            CGFloat p_3_x = p_2_x;
            CGFloat p_3_y = K_BOX_M_BOX_V + box_bottom_y;
            CGPoint p_3 = CGPointMake(p_3_x, p_3_y);
            
            CGFloat p_4_x = p_2_x + (JW_A_S_MAINS_WIDTH-capLeft-cap_rr-K_Cap_Box_Margin-box_right_m) ;
            CGFloat p_4_y = p_3_y;
            CGPoint p_4 = CGPointMake(p_4_x, p_4_y);
            
            CGFloat p_5_x = p_4_x;
            CGFloat p_5_y = p_4_y + box_h;
            CGPoint p_5 = CGPointMake(p_5_x, p_5_y);
            
            CGFloat p_6_x = p_3_x;
            CGFloat p_6_y = p_3_y + box_h;
            CGPoint p_6 = CGPointMake(p_6_x, p_6_y);
            
            CGFloat p_7_x = p_6_x;
            CGFloat p_7_y = p_1_y + K_MOUTH_H_MARGIN;
            CGPoint p_7 = CGPointMake(p_7_x, p_7_y);
            
            // 制作 box
            [boxBoardColor set];
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = 1.0f;
            path.lineCapStyle = kCGLineCapRound;
            path.lineJoinStyle = kCGLineJoinRound;
            
            [path moveToPoint:p_1];
            [path addLineToPoint:p_2];
            [path addLineToPoint:p_3];
            [path addLineToPoint:p_4];
            [path addLineToPoint:p_5];
            [path addLineToPoint:p_6];
            [path addLineToPoint:p_7];
            [path closePath];
            [path stroke];
            
            // 更新
            box_bottom_y = p_6_y;
            tempResultHeight = box_bottom_y;
            //NSLog(@"box_bottom_y = %.2f",box_bottom_y);
            
            // 边框里写上 Lab (个数由外部灵活设定)
            CGFloat l_h_m = bl_lr_Size.width;// 水平左边间距
            CGFloat l_h_m_r = bl_lr_Size.height;// 水平右边间距
            CGFloat l_v_m = ll_m_v;// 竖直间距
            CGFloat l_x = l_h_m + p_3.x;
            CGFloat l_y = l_v_m + p_3.y;
            CGFloat l_w = (JW_A_S_MAINS_WIDTH-capLeft-cap_rr-K_Cap_Box_Margin-box_right_m) - (l_h_m + l_h_m_r);
            CGFloat l_h = 0.0f;
            
            // 取出一组 labs 高度
            NSArray *oneGroup_hs_Ary = _innerBoxsLabs_hs_Ary[i];
            // 取出一组 labs 内容
            NSArray *oneGroup_titles_Ary = _innerBoxsLabsAry[i];
            
            CGFloat fold_h = l_y;//迭加高度初始化
            
            for (int j = 0; j < [oneGroup_titles_Ary count]; j++) {
                
                UILabel *lab = [[UILabel alloc] init];
                lab.textColor = inboxLabsColor;
                
                // 设置 第j个 frame
                CGFloat temp_hh = 0.0f;
                NSNumber *number = (NSNumber *)oneGroup_hs_Ary[j];
                temp_hh = [number floatValue];
                l_y = fold_h;
                fold_h += (temp_hh + l_v_m);//更新新的叠加高度
                l_h = temp_hh;
                
                CGRect frame = CGRectMake(l_x, l_y , l_w, l_h);
                
                [self set_Lab_Constraint_Attribute:lab text:oneGroup_titles_Ary[j] :NO];
                
                lab.backgroundColor = [UIColor clearColor];
                lab.frame = frame;
                [self addSubview:lab];
                [_wholeLabs_Ary addObject:lab];
            }
            
        }else if (/* 没有box*/!is_Box){
            
            // 不要处理，下面处理了...
        }
        
#pragma mark ————————> 画一下左边的控件
        
        CGFloat cap_x = capLeft;// 帽子的x
        CGFloat cap_y = 0;// 帽子的y
        CGFloat cap_w = cap_rr;// 帽子宽
        CGFloat cap_h = cap_w;// 帽子高
        CGFloat cap_r = cap_w*0.5f;// 帽子半径
        CGFloat cap_rr = cap_w;// 帽子直径
        CGFloat cap_lw = 1;//帽子的边框宽
        
        // 设置帽子y
        if (is_Box) {
            
            [_box_mouths_y_Ary addObject:@(box_mouth_y)];
            cap_y = box_mouth_y - cap_r;
            
        }else if( /* 没box */!is_Box){
            
            cap_bottom_y += (cap_rr + K_Line_H);
            cap_y = cap_bottom_y;
            [_lines_y_Ary addObject:@(cap_y)];
        }else{
            
        }
        
        // 画圆帽子
        
        CGRect capFrame = CGRectMake(cap_x,
                                     cap_y,
                                     cap_w,
                                     cap_h);
   
        [capColor set];
        UIBezierPath *capPath = [UIBezierPath bezierPathWithRoundedRect:capFrame cornerRadius:cap_r];
        capPath.lineWidth = cap_lw;
        capPath.lineCapStyle = kCGLineCapRound;
        capPath.lineJoinStyle = kCGLineJoinRound;
        [capPath fill];
        
        // 为帽子添加文字
        
        BOOL is_ok = ((( nil != _coverTextsAry)||
                       ( 0 != [_coverTextsAry count])))?YES:NO;
        
        _isAddNper = YES;
        CGRect cover_Lab_frame = capFrame;
        
        if ( is_ok && _isAddNper) {
            
            // 设置 帽子 Lab
            [self set_Rund_CapText:CONFIG_TYPE_UNDEF frame:cover_Lab_frame index:i labTextColor:capTextColor];
            
        }else if(!is_ok && _isAddNper){
            
            // 设置 帽子 Lab
            [self set_Rund_CapText:CONFIG_TYPE_DEF frame:cover_Lab_frame index:i labTextColor:capTextColor];
            
        }else if(!_isAddNper){
            
            //...不处理
        }
        
        
        // 是否有 竖杠
        BOOL is_Line = YES;
        
        if (is_Line) {
            
            CGFloat l_x = cap_r + cap_x;
            CGFloat l_y = 0.0f;
            CGFloat l_w = cap_rr * capr_bScale;// 宽度
            CGFloat l_h = 0.0f;
            CGFloat l_yy = 0.0f;
            
            // 有 box
            if ((i >= 1)&& is_Box) {
                
                l_y = [((NSNumber*)_box_mouths_y_Ary[i-1]) floatValue] + cap_r;
                CGFloat first_y = [((NSNumber*)_lines_y_Ary[(i-1)]) floatValue] + cap_r;
                CGFloat second_y = [((NSNumber*)_lines_y_Ary[i]) floatValue] - cap_r;
                
                l_h = second_y - first_y;
                l_yy = l_h + l_y;
                
            }
            
            // 无 box
            if ((i >= 1)&&!is_Box) {
                
                l_y = [((NSNumber*)_lines_y_Ary[i-1]) floatValue] + cap_rr;
                l_h = K_Line_H;
                l_yy = l_y + l_h;
            }
            
            // 画圆竖杠
            [capBarColor set];
            UIBezierPath *lpath = [UIBezierPath bezierPath];
            [lpath moveToPoint:CGPointMake(l_x,l_y)];
            [lpath addLineToPoint:CGPointMake(l_x,l_yy)];
            lpath.lineWidth = l_w;
            lpath.lineCapStyle = kCGLineCapButt;
            lpath.lineJoinStyle = kCGLineJoinMiter;
            [lpath stroke];
        }
        
        // 最后添加附加信息
        if ((i+1) == [_box_h_Ary count]) {
            
            CGFloat before_lab_max_y = (box_bottom_y + K_LASTBOX_M_ADDLAB_V);
            
            CGFloat ad_lab_x = K_ADDLAB_M_CONTAIN_L;
            CGFloat ad_lab_y = 0.0f;
            
            for (int k = 0; k < [_addtionsAry count]; k++) {
                
                UILabel *add_lab = [[UILabel alloc] init];
                add_lab.textColor = K_SET_COLOR_VALUE(@"#999999");
            
                ad_lab_y = (before_lab_max_y + K_ADDLAB_M_ADDLAB_V*k);
                
                CGFloat ad_lab_w = (JW_A_S_MAINS_WIDTH - K_ADDLAB_M_CONTAIN_L - K_ADDLAB_M_CONTAIN_R);
                CGFloat ad_lab_h = [((NSNumber*)_addtions_hs_Ary[k]) floatValue];
                
                CGRect frame = CGRectMake(ad_lab_x,
                                          ad_lab_y,
                                          ad_lab_w,
                                          ad_lab_h);
                
                [self set_Lab_Constraint_Attribute:add_lab text:_addtionsAry[k] :NO];
                add_lab.backgroundColor = [UIColor clearColor];
                add_lab.frame = frame;
                
                before_lab_max_y += ad_lab_h;
                
                [self addSubview:add_lab];
                [_addLabs_Ary addObject:add_lab];
            }
        }
    }
}


// 为帽子添加文字

-(void)set_Rund_CapText:(CONFIG_TYPE)type frame:(CGRect)frame index:(int)index labTextColor:(UIColor*)textColor{
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
    textLabel.backgroundColor = [UIColor clearColor];// 颜色处理不好，先放一放
    textLabel.font = [UIFont systemFontOfSize:10];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = textColor;
    textLabel.layer.cornerRadius = frame.size.width*0.5f;
    textLabel.layer.masksToBounds = YES;
    textLabel.layer.shouldRasterize = YES;
    
    [self addSubview:textLabel];
    [_capsLabs_Ary addObject:textLabel];
    
    switch (type) {
        case CONFIG_TYPE_DEF:
        {
            NSString *temp = [NSString stringWithFormat:@"%d期",(index+1)];
            textLabel.text = temp;
            
        }
            break;
            
        case CONFIG_TYPE_UNDEF:
        {
            
            NSString *temp = @"";
            if (index <= ([_coverTextsAry count]-1)) {
                
                temp = _coverTextsAry[index];
            }
            
            BOOL is_Nol = (([temp isEqualToString:@""])||
                           (index > [_coverTextsAry count]))?YES:NO;
            
            if (is_Nol) {
                temp = [NSString stringWithFormat:@"%d期",(index+1)];
                textLabel.text = temp;
            }else{
                textLabel.text = _coverTextsAry[index];
            }
        }
            break;
            
        default:
            break;
    }
}


/*默认设置 */
-(void)set_asv_default{
    
    // 这里是所有默认设置...
}

#pragma mark———————— 次要接口


/*正在进行step的颜色,反之颜色,帽杆颜色 */
- (void)set_asv_capColor_steping:(UIColor*)c1 oppose:(UIColor*)c2 cap:(UIColor*)c3{
    
    if (c1) {
        
        _capColor_1 = c1;
        
    }
    
    if (c2) {
        
        _capColor_2 = c2;
        
    }
    
    [self setNeedsDisplay];
    
}

/*正在进行step的 帽杆 颜色,反之颜色 */
- (void)set_asv_capBarColor_setping:(UIColor*)c1 oppose:(UIColor*)c2 cap:(UIColor*)c3{
    if (c1) {
        
        _capBarColor_1 = c1;
        
    }
    
    if (c2) {
        
        _capBarColor_2 = c2;
        
    }
    
}

/*box 内文字的颜色 */
- (void)set_asv_boxTextColor_steping:(UIColor*)c1 oppose:(UIColor*)c2{
    
    if (c1) {
        
        _boxLabsColor_1 =c1;
    }

    if (c2) {
        
        _boxLabsColor_2 =c2;
    }
    
}

/*box 边框的颜色 */
- (void)set_asv_boxBorderColor_stepingColor:(UIColor*)c1 oppose:(UIColor*)c2{
    
    if (c1) {
        
        _boxBoardColor_1 = c1;
    }
    
    if (c2) {
        
        _boxBoardColor_2 = c2;
    }
    
}

/* cap 内文字的颜色 */
- (void)set_asv_capTextColor_steping:(UIColor*)c1 oppose:(UIColor*)c2{
    
    if (c1) {
        
        _capTextColor_1 = c1;
    }
    
    if (c2) {
        
        _capTextColor_2 = c2;
    }
    
}

/*帽子文字（默认为 [1期...]有缺失校验） */
- (void)set_asv_CapTitles:(NSArray*)tAry{
    
    if (tAry) {
        
        _coverTextsAry = tAry;
    }
}

/*帽子距离最左边距离（def=25） */
- (void)set_asv_CapLeft:(CGFloat)l_m{

    capLeft = l_m;
}

/*帽子的直径（def=25） */
- (void)set_asv_CapDiameter:(CGFloat)d{
    
    if (d<K_Cap_W) {
        
        d = K_Cap_W;
    }
    cap_rr = d;
}

/*帽杆与帽子的比例（def=0.1） */
- (void)set_asv_CapRodScale:(CGFloat)crScale{
    
    if (crScale) {
        
        capr_bScale = crScale;
    }
}


/*box距离页眉最右边的距离（def = 25）*/
- (void)set_asv_BoxRight:(CGFloat)r_m{
    
    if (r_m < BOX_RIGHT_MARGIN) {
        
        r_m = BOX_RIGHT_MARGIN;
    }
    box_right_m = r_m;
    
}


/* box 与 Lab 水平左右 间距（def = CGSize(10,10)）*/
- (void)set_asv_BoxMarginLab_L_R:(CGSize)bllrSize{
    
    CGFloat x = 0.0f,y = 0.0f;
    if (bllrSize.width < K_inBOX_M_LAB_H) {
        x = K_inBOX_M_LAB_H;
    }else{
        x = bllrSize.width;
    }
    if (bllrSize.height < K_inBOX_M_LAB_H) {
        y = K_inBOX_M_LAB_H;
    }else{
        y = bllrSize.height;
    }
    bl_lr_Size = CGSizeMake(x, y);
}


/* box 内 Lab 与 Lab 竖直 间距（def = 10）*/
- (void)set_asv_inBox_LabMarginLab_V:(CGFloat)llmv{
    
    if (llmv < K_BOX_M_LAB_V) {
        
        ll_m_v = K_BOX_M_LAB_V;
        
    }else{
        ll_m_v = llmv;
    }
    [self setNeedsDisplay];
}


@end

