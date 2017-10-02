//
//  CalendarReminderEvent.h
//  CalendarEvent
//
//  Created by fdai on 2017/10/2.
//  Copyright © 2017年 fdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarReminderEvent : NSObject

/**
 single instance

 @return instance
 */
+(instancetype) shareInstance;

/**
 create calender envent

 @param title       event title
 @param location    event location
 @param sDate       event start date
 @param eDate       event end date
 @param isAllDay    if event all day
 @param alarmArray  remind alarm array
 */
-(void) createCalendarEventWithTitle:(NSString*) title location:(NSString*)location startDate:(NSDate*)sDate EndDate:(NSDate*)eDate allDay:(BOOL) isAllDay remindAlarm:(NSArray*) alarmArray;

@end
