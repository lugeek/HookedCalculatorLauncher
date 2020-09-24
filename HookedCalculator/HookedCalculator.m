//
//  HookedCalculator.m
//  HookedCalculator
//
//  Created by lugeek on 2020/9/24.
//

#import "HookedCalculator.h"
#include <sys/syslog.h>
#include <objc/runtime.h>
#include <AppKit/AppKit.h>

__attribute__((constructor)) void myentry() {
    printf("Hello from dylib1!\n");
    syslog(LOG_ERR, "Dylibx 1 injection successful");
}

__attribute__((constructor)) static void customConstructor(int argc, const char **argv)
{
    printf("Hello from dylib2!\n");
    syslog(LOG_ERR, "Dylibx 2 injection successful in %s\n", argv[0]);
}

@implementation HookedCalculator

+(void)load
{
    Class originalClass = NSClassFromString(@"CalculatorController");
    Method originalMeth = class_getInstanceMethod(originalClass, @selector(showAbout:));
    
    Method replacementMeth = class_getInstanceMethod(NSClassFromString(@"HookedCalculator"), @selector(patchedShowAbout:));
    method_exchangeImplementations(originalMeth, replacementMeth);
}

-(void)patchedShowAbout:(id)sender
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Code has been injected!"];
    [alert setInformativeText:@"The code has been injected using DYLD_INSERT_LIBRARIES into Calculator.app"];
    [alert setAlertStyle:NSAlertStyleCritical];
    [alert runModal];
}

@end
