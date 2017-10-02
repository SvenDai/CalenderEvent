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
@end
