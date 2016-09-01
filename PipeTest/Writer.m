//
//  Writer.m
//  PipeTest
//
//  Created by Lane Roathe on 9/1/16.
//  Copyright © 2016 Ideas From the Deep, llc. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
	@autoreleasepool
	{
		NSUInteger count = 0;

		while( count < 100000 )
		{
			// Write a string
			fprintf( stdout, "STRING %05lu", count++ );
		}
	}
	return 0;
}
