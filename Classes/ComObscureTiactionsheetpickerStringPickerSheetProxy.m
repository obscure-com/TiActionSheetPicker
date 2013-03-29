/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComObscureTiactionsheetpickerStringPickerSheetProxy.h"
#import "ActionSheetStringPicker.h"
#import "TiApp.h"

#define kTitleKey @"title"
#define kHideCancelKey @"hideCancel"
#define kInitialSelectionKey @"initialSelection"
#define kRowsKey @"rows"


#define kDateSelectedEventName @"change"
#define kStringSelectedEventIndexKey @"selectedIndex"

@interface ComObscureTiactionsheetpickerStringPickerSheetProxy ()
@property (nonatomic, strong) ActionSheetStringPicker * actionSheetPicker;
@end

@implementation ComObscureTiactionsheetpickerStringPickerSheetProxy

- (void)show:(id)args {
    NSDictionary * showArgs;
    ENSURE_ARG_OR_NIL_AT_INDEX(showArgs, args, 0, NSDictionary);
    ENSURE_UI_THREAD_1_ARG(args)
    
    NSString * title = [self valueForKey:kTitleKey];
    NSNumber * initialSelection = [self valueForKey:kInitialSelectionKey];
    NSArray * rows = [self valueForKey:kRowsKey];
    
    self.actionSheetPicker = [[ActionSheetStringPicker alloc] initWithTitle:title ? title : @""
                                                                       rows:rows ? rows : [NSArray array]
                                                           initialSelection:initialSelection ? [initialSelection integerValue] : 0
                                                                     target:self
                                                              successAction:@selector(stringWasSelected:element:)
                                                               cancelAction:nil
                                                                     origin:[[TiApp app] topMostView]];
    [self.actionSheetPicker showActionSheetPicker];
}

- (void)stringWasSelected:(NSNumber *)selectedIndex element:(id)element {
    TiThreadPerformOnMainThread(^{
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               selectedIndex, kStringSelectedEventIndexKey,
                               nil];
        [self fireEvent:kDateSelectedEventName withObject:dict];
    }, NO);
}

@end
