//
//  AppDelegate.m
//  HookedCalculatorLauncher
//
//  Created by lugeek on 2020/9/24.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *calculatorPath = @"/System/Applications/Calculator.app/Contents/MacOS/Calculator";
    if([[NSFileManager defaultManager] fileExistsAtPath:calculatorPath]) {
        NSString *dyldLibrary = [[NSBundle bundleForClass:[self class]] pathForResource:@"libHookedCalculator" ofType:@"dylib"];
        NSString *launcherString = [NSString stringWithFormat:@"DYLD_INSERT_LIBRARIES=\"%@\" \"%@\" &", dyldLibrary, calculatorPath];
        system([launcherString UTF8String]);// run shell
        
        [self performSelector:@selector(bringToFrontApplicationWithBundleIdentifier:) withObject:@"com.apple.calculator" afterDelay:1.0];
    }
}

-(void)bringToFrontApplicationWithBundleIdentifier:(NSString*)inBundleIdentifier
{
    // Try to bring the application to front
    NSArray* appsArray = [NSRunningApplication runningApplicationsWithBundleIdentifier:inBundleIdentifier];
    if([appsArray count] > 0)
    {
        [[appsArray objectAtIndex:0] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
    
    // Quit ourself
    [[NSApplication sharedApplication] terminate:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
