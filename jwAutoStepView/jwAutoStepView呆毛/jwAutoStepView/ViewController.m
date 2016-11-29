//
//  ViewController.m
//  jwAutoStepView
//
//  Created by JW_N on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

// 倭人为寇
#define K_TEXT_0  @"K_TEXT_1 是赞无数据😯!"
#define K_TEXT_1  @"*、倭人为寇,是为倭寇。但恶劣的品行并不能否定他们的战斗力,且不说这帮人的武艺和战术水平,单说人家冒着掉进海里喂鱼的危险,跑上千里路来抢劫,就能充分说明.本期起息日倭人为寇,是为倭寇。但恶劣的品行并不能否定他们的战斗力,且不说这帮人的武艺和战术水平,单说人家冒着掉进海里喂鱼的危险,跑上千里路来抢劫,就能充分说明.本期起息日倭人为寇,是为倭寇。但恶劣的品行并不能否定他们的战斗力,且不说这帮人的武艺和战术水平,单说人家冒着掉进海里喂鱼的危险,跑上千里路来抢劫,就能充分说明."
#define K_TEXT_2  @"*、倭人为寇,是为倭寇。但恶劣的品行并不能否定他们的战斗力,且不说这帮人的武艺和战术水平,单说人家冒着掉进海里喂鱼的危险,跑上千里路来抢劫,就能充分说明.本期起息日倭人为寇,是为倭寇。"
#define K_TEXT_3  @"*、倭人为寇,是为倭寇。"

// 李光耀 先生
#define K_LI_1  @"1、李光耀（Lee Kuan Yew，1923年09月16日~ 2015年03月23日），又名GCMG、CH，新加坡华人，祖籍广东省梅州市大埔县高陂镇党溪乡，毕业于新加坡莱佛士学院，新加坡人民行动党创始人之一。"

#define K_LI_2  @"2、曾任新加坡总理（开国元首）、新加坡最高领导人、国务资政以及内阁资政、新加坡人民行动党秘书长、立法议会（1965年12月改称国会）议员、新加坡自治政府首任总理、总理公署高级部长、国际儒学联合会名誉理事长、内阁资政（总理公署），被誉为“新加坡国父”。"

#define K_LI_3  @"3、2015年03月23日凌晨3时18分，因病医治无效去世，享年91岁。2015年03月29日下午14时，在新加坡国立大学文化中心举行国葬。[1] "


#import "ViewController.h"
#import "jwAutoStepView.h"

@interface ViewController ()

{
    NSMutableArray<jwAutoStepModel*> *_modelAry;
}
@property (weak, nonatomic) IBOutlet jwAutoStepView *stepView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrol_view_h;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self isOpenSimulatedData:YES];
    
}

// 轻拍页面，更新数据源
- (IBAction)refresh_tap_act:(id)sender {
    
    [self isOpenSimulatedData:YES];
   
}

// 是否开启模拟数据
- (void)isOpenSimulatedData:(BOOL)isYes{
    
    if (_modelAry) {
        
        [_modelAry removeAllObjects];
        _modelAry = nil;
    }
    
    _modelAry = [NSMutableArray array];

    // 模拟随机数据（1-3个）
    int simulated_num = (1 + (arc4random() % (3 - 1 + 1)));
    
    for (int i = 0; i < simulated_num; i++) {
        
        jwAutoStepModel *model = [[jwAutoStepModel alloc] init];
        
        int sim_num =  (1 + (arc4random() % (3 - 1 + 1)));
        
        if (i%sim_num == 0) {
        
             model.interestDate = K_TEXT_0;
            
        }else if (i%sim_num == 1){
            
            model.interestDate = K_TEXT_1;
           
          
        }
        else if (i%sim_num == 2){
            
            model.interestDate = K_TEXT_2;
            model.redeemBigin = K_TEXT_3;
            
        }
        
        int si_num =  (0 + (arc4random() % (i - 0 + 1)));
        if (i <= si_num) {
            
            model.isPassDate = YES;
        }else{
            
            model.isPassDate = NO;
        }
        
        [_modelAry addObject:model];
        
    }
    [self loadNetData_AndRefreshUi:_modelAry];
    
}

// 加载数据，并更新 ui
-(void)loadNetData_AndRefreshUi:(NSMutableArray<jwAutoStepModel *>*)data{
    
    if ([data isKindOfClass:[NSMutableArray<jwAutoStepModel *> class]]) {
        
        [_stepView set_asv_uiData:data];
        [_stepView set_asv_addData:[NSMutableArray arrayWithObjects:K_LI_1,K_LI_2,K_LI_3, nil]];
        
        // 设置颜色
        [_stepView set_asv_boxTextColor_steping:[UIColor redColor] oppose:[UIColor blackColor]];
        
        // 设置帽子文字
        NSArray *capTitlesAry = @[@"1",
                                  @"2",
                                  @"3"];
       
        [_stepView set_asv_CapTitles:capTitlesAry];
        
        // 设置帽子距离左边距离
        [_stepView set_asv_CapLeft:10];

        // 设置帽子的直径
        [_stepView set_asv_CapDiameter:20];
        
        // 设置帽子与帽杆的比例
        [_stepView set_asv_CapRodScale:0.01f];
        
        // 设置 box 距离页面边框最右边的距离
        [_stepView set_asv_BoxRight:30];
        
        // 设置 box 与 Lab 水平左右 间距
        [_stepView set_asv_BoxMarginLab_L_R:CGSizeMake(20, 10)];
        
        
        // 得到高度，开始绘制
        CGFloat _calendView_h = [_stepView get_asv_ControlHeight];
        CGFloat page_y = _calendView_h;
        _scrol_view_h.constant = page_y;
        [_stepView setNeedsDisplay];
        
        //NSLog(@"page_Height = %.2f",page_y);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

