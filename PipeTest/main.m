//
//  main.m
//  PipeTest
//
//  Created by Lane Roathe on 9/1/16.
//  Copyright © 2016 Ideas From the Deep, llc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SHOW_PIPE_FULL_FAILURE 0
#define SHOW_AVAILABLEDATA_FAILURE 0
#define SHOW_ISRUNNING_LOOP 0

int main(int argc, const char * argv[])
{
	@autoreleasepool
	{
		NSTask *task = [[NSTask alloc] init];

		task.launchPath = @"./Writer";

		NSPipe* outputPipe = [NSPipe pipe];
		task.standardOutput = outputPipe;

		[task launch];

#if SHOW_PIPE_FULL_FAILURE

		// the program will output too much data, and the output pipe will be filled, causing the process to block
		// as a result, waitUntilExit will not exit, and the program hangs.
		[task waitUntilExit];

		NSData *currentOutput = [outputPipe.fileHandleForReading readDataToEndOfFile];
		NSLog( @"%@", currentOutput );

#elif SHOW_AVAILABLEDATA_FAILURE

		// Using availableData reads data that exists, then returns. This causes waitUntilExit to fail
		NSData *currentOutput = [outputPipe.fileHandleForReading availableData];
		NSLog( @"%@", currentOutput );

		[task waitUntilExit];

#elif SHOW_ISRUNNING_LOOP

		// NOTE: while this appears to run faster, it does not, it is slower.
		//       it appears faster due to smaller NSLog calls!
		while( [task isRunning] )
		{
			// Using availableData reads data that exists, then returns
			NSData *currentOutput = [outputPipe.fileHandleForReading availableData];
			NSLog( @"%@", currentOutput );
		}

#else

		// Using readDataToEndOfFile causes data to be read until the file is closed!
		NSData *currentOutput = [outputPipe.fileHandleForReading readDataToEndOfFile];
		NSLog( @"%@", currentOutput );

		[task waitUntilExit];

#endif

	}
    return 0;
}
