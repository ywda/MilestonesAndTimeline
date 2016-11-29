//
//  jwAutoStepModel.h
//  jwAutoStepView
//
//  Created by JW_N on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jwAutoStepModel : NSObject

/* 产品编号 */
@property(nonatomic,copy)NSString *productId;

/* 周期数 */
@property(nonatomic,copy)NSString *termNum;

/* 起息日 */
@property(nonatomic,copy)NSString *interestDate;

/* 赎回开始时间 */
@property(nonatomic,copy)NSString *redeemBigin;

/* 赎回结束时间 */
@property(nonatomic,copy)NSString *redeemEnd;

/* 最近浮动收益分配日 */
@property(nonatomic,copy)NSString *floatIncome;

/* 本期到期日 */
@property(nonatomic,copy)NSString *termEnd;

/* 产品终止日 */
@property(nonatomic,copy)NSString *prdEndDate;

/* 程序员写测试数据：是否是过期*/
@property(nonatomic,assign)BOOL isPassDate;

@end
