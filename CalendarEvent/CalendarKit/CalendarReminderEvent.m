//
//  CalendarReminderEvent.m
//  CalendarEvent
//
//  Created by fdai on 2017/10/2.
//  Copyright © 2017年 fdai. All rights reserved.
//

#import "CalendarReminderEvent.h"
#import <EventKit/EventKit.h>

@implementation CalendarReminderEvent

+(instancetype) shareInstance {

    static CalendarReminderEvent *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CalendarReminderEvent alloc]init];
    });
    
    return instance;
}

-(void) createCalendarEventWithTitle:(NSString *)title location:(NSString *)location startDate:(NSDate *)sDate EndDate:(NSDate *)eDate allDay:(BOOL)isAllDay remindAlarm:(NSArray *)alarmArray{

    EKEventStore *store = [[EKEventStore alloc]init];
    
    if ([store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"add calendar error");
            }else if(!granted){
                NSLog(@"can't access calandar");
            }else{
                EKEvent *event  = [EKEvent eventWithEventStore:store];
                event.title     = title;
                event.location  = location;
                event.startDate = sDate;
                event.endDate   = eDate;
                event.allDay    = isAllDay;
                
                if (alarmArray && alarmArray.count > 0) {
                    for (NSString *timeString in alarmArray) {
                        [event addAlarm:[EKAlarm alarmWithRelativeOffset:[timeString integerValue]]];
                    }
                }
                
                [event setCalendar:[store defaultCalendarForNewEvents]];
                NSError *err;
                [store saveEvent:event span:EKSpanThisEvent error:&err];
                NSLog(@"added the event to calendar");
            }
        }];
    }
    
}


- (NSArray*)checkEvent{
    EKEventStore *store = [[EKEventStore alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    // 创建起始日期组件
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    // 创建结束日期组件
    NSDateComponents *oneMonthFromNowComponents = [[NSDateComponents alloc] init];
    oneMonthFromNowComponents.month = 1;
    NSDate *oneMonthFromNow = [calendar dateByAddingComponents:oneMonthFromNowComponents
                                                        toDate:[NSDate date]
                                                       options:0];
    
    NSArray *tempA = [store calendarsForEntityType:EKEntityTypeEvent];
    NSMutableArray *calenderArr = [NSMutableArray array];
    for (EKCalendar *calendar in tempA) {
        EKCalendarType type = calendar.type;
        if (type == EKCalendarTypeLocal || type == EKCalendarTypeCalDAV) {
            [calenderArr addObject:calendar];
        }
    }
    // 用事件库的实例方法创建谓词。表示 找出从当前时间前一天到当前时间的一个月后的时间范围的所有typesArray里类型的日历事件
    NSPredicate*predicate = [store predicateForEventsWithStartDate:oneDayAgo endDate:oneMonthFromNow calendars:calenderArr];
    NSArray *eventArray = [store eventsMatchingPredicate:predicate];
    return eventArray;
}












@end
