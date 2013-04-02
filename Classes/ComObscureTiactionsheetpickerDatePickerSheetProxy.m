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
#define kInitialDateKey @"initialDate"

#define kDateSelectedEventName @"change"
#define kDateSelectedEventDateKey @"selectedDate"

@interface ComObscureTiactionsheetpickerDatePickerSheetProxy ()
@property (nonatomic, strong) ActionSheetDatePicker * actionSheetPicker;
@end

@implementation ComObscureTiactionsheetpickerDatePickerSheetProxy

- (void)show:(id)args {
    NSDictionary * showArgs;
    ENSURE_ARG_OR_NIL_AT_INDEX(showArgs, args, 0, NSDictionary);
    [self rememberSelf];
    ENSURE_UI_THREAD_1_ARG(args)
    
    NSString * title = [self valueForKey:kTitleKey];
    NSNumber * mode = [self valueForKey:kPickerModeKey];
    NSDate * dt = [self valueForKey:kInitialDateKey];
    
    self.actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:title ? title : @""
                                                           datePickerMode:mode ? [mode integerValue] : UIDatePickerModeDateAndTime
                                                             selectedDate:dt ? dt : [NSDate date]
                                                                   target:self
                                                                   action:@selector(dateWasSelected:element:)
                                                                   origin:[[TiApp app] topMostView]];
    
    // cannot provide a cancel button unless we get notified when it is clicked so we
    // can call [self release].
    self.actionSheetPicker.hideCancel = YES;
    // self.actionSheetPicker.hideCancel = [[self valueForKey:kHideCancelKey] boolValue];
    
    // TODO custom buttons?
    /*
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
     */
    
    [self retain];
    [self.actionSheetPicker showActionSheetPicker];
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           selectedDate ? selectedDate : [NSNull null], kDateSelectedEventDateKey,
                           nil];
    TiThreadPerformOnMainThread(^{
        [self fireEvent:kDateSelectedEventName withObject:dict];
    }, YES);
    
    [self forgetSelf];
    [self release];
}

@end
