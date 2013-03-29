/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComObscureTiactionsheetpickerDatePickerSheetProxy.h"
#import "ActionSheetDatePicker.h"
#import "TiApp.h"

#define kTitleKey @"title"
#define kPickerModeKey @"mode"
#define kHideCancelKey @"hideCancel"

#define kDateSelectedEventName @"change"
#define kDateSelectedEventDateKey @"selectedDate"

@interface ComObscureTiactionsheetpickerDatePickerSheetProxy ()
@property (nonatomic, strong) ActionSheetDatePicker * actionSheetPicker;
@property (nonatomic, strong) NSDate * selectedDate;
@end

@implementation ComObscureTiactionsheetpickerDatePickerSheetProxy

- (void)show:(id)args {
    NSDictionary * showArgs;
    ENSURE_ARG_OR_NIL_AT_INDEX(showArgs, args, 0, NSDictionary);
    ENSURE_UI_THREAD_1_ARG(args)
    
    NSString * title = [self valueForKey:kTitleKey];
    NSNumber * mode = [self valueForKey:kPickerModeKey];
    
    NSDate * dt = self.selectedDate != nil ? self.selectedDate : [NSDate date];
    
    self.actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:title ? title : @""
                                                           datePickerMode:mode ? [mode integerValue] : UIDatePickerModeDateAndTime
                                                             selectedDate:dt
                                                                   target:self
                                                                   action:@selector(dateWasSelected:element:)
                                                                   origin:[[TiApp app] topMostView]];
    
    self.actionSheetPicker.hideCancel = [[self valueForKey:kHideCancelKey] boolValue];
    
    // TODO custom buttons?
    /*
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
     */
    
    [self.actionSheetPicker showActionSheetPicker];
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    TiThreadPerformOnMainThread(^{
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               selectedDate, kDateSelectedEventDateKey,
                               nil];
        [self fireEvent:kDateSelectedEventName withObject:dict];
    }, NO);
}

@end
