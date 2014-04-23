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
#define kLocaleKey @"locale"
#define kMinDateKey @"minDate"
#define kMaxDateKey @"maxDate"

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
    
    // show arguments
    UIView * origin = nil;
    TiViewProxy * originProxy = (TiViewProxy *) [showArgs valueForKey:@"origin"];
    if (originProxy && originProxy.view) {
        origin = originProxy.view;
    }
    else {
        origin = [[TiApp app] topMostView];
    }
    
    self.actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:title ? title : @""
                                                           datePickerMode:mode ? [mode integerValue] : UIDatePickerModeDateAndTime
                                                             selectedDate:dt ? dt : [NSDate date]
                                                                   target:self
                                                                   action:@selector(dateWasSelected:element:)
                                                                   origin:origin];
    
    // cannot provide a cancel button unless we get notified when it is clicked so we
    // can call [self release].
    // self.actionSheetPicker.hideCancel = YES;
    self.actionSheetPicker.hideCancel = [[self valueForKey:kHideCancelKey] boolValue];
    
    // TODO custom buttons?
    /*
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
     */
    
    // set additional properties
    
    // locale
    NSString * localeStr = [self valueForKey:kLocaleKey];
    if (localeStr) {
        NSString *identifier = [NSLocale canonicalLocaleIdentifierFromString:localeStr];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:identifier];
        self.actionSheetPicker.locale = locale;
    }
    else {
        self.actionSheetPicker.locale = nil;
    }
    
    // min and max date
    self.actionSheetPicker.minimumDate = [self valueForKey:kMinDateKey];
    self.actionSheetPicker.maximumDate = [self valueForKey:kMaxDateKey];
    
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

- (void)actionPickerCancelled:(id)sender {
    [self forgetSelf];
    [self release];
}

@end