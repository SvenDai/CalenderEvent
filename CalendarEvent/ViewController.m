//
//  ViewController.m
//  CalendarEvent
//
//  Created by fdai on 2017/9/19.
//  Copyright © 2017年 fdai. All rights reserved.
//

#define DF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DF_SCREEN_HIGHT [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"
#import "CalendarReminderEvent.h"

@interface ViewController ()

@property(nonatomic,strong) UIButton *addEventBtn;

@property(nonatomic,strong) UIButton *checkoutCalenderBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.addEventBtn];
    [self.view addSubview:self.checkoutCalenderBtn];
    [self setupSubviewAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(void) setupSubviewAction{
    [self.addEventBtn addTarget:self action:@selector(addEventBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.checkoutCalenderBtn addTarget:self action:@selector(checkoutCalenderBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void) addEventBtnClickAction:(UIButton*)sender{
    [[CalendarReminderEvent shareInstance]
                createCalendarEventWithTitle:@"添加日历事件测试"
                                    location:@"上海"
                                   startDate:[NSDate dateWithTimeInterval:3600 sinceDate:[NSDate date]]
                                     EndDate:[NSDate dateWithTimeInterval:7200 sinceDate:[NSDate date]]
                                      allDay:NO
                                 remindAlarm:@[@"-3480"]];
}

-(void) checkoutCalenderBtnClickAction{
    NSArray* calenderArray = [[CalendarReminderEvent shareInstance] checkEvent];
    NSLog(@"all calender %@",calenderArray);
}

#pragma mark - getter
-(UIButton*) addEventBtn{
    if (!_addEventBtn) {
        _addEventBtn        = [UIButton buttonWithType:UIButtonTypeCustom];
        _addEventBtn.frame  = CGRectMake(0, 0, 150, 30);
        
        [_addEventBtn setBackgroundColor:[UIColor redColor]];
        [_addEventBtn setTitle:@"Add Calendar Event" forState:UIControlStateNormal];
        [_addEventBtn setCenter:CGPointMake(DF_SCREEN_WIDTH / 2, DF_SCREEN_HIGHT / 2)];
        
    }
    return _addEventBtn;
}

-(UIButton*) checkoutCalenderBtn{
    if (!_checkoutCalenderBtn) {
        _checkoutCalenderBtn        = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkoutCalenderBtn.frame  = CGRectMake(0, 0, 150, 30);
        
        [_checkoutCalenderBtn setBackgroundColor:[UIColor redColor]];
        [_checkoutCalenderBtn setTitle:@"Checkout Calendar Event" forState:UIControlStateNormal];
        [_checkoutCalenderBtn setCenter:CGPointMake(DF_SCREEN_WIDTH / 2, DF_SCREEN_HIGHT / 2 -50)];
        
    }
    return _checkoutCalenderBtn;
}



@end
