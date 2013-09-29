//
//  LocationInfo.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "LocationInfo.h"

@implementation LocationInfo

- (id)initLocationWithInfo:(NSString*)name
                      city:(NSString*)city
                   country:(NSString*)country
                 imageFile:(PFFile*)imageFile
                      desc:(NSString*)desc
                      rank:(NSInteger)rank
{
    if ((self = [super init]))
    {
        self.name = name;
        self.city = city;
        self.country = country;
        self.imageFile = imageFile;
        self.desc = desc;
        self.rank = rank;
    }
    return self;
}


- (void)dealloc
{
    self.name = nil;
    self.city = nil;
    self.country = nil;
    self.imageFile = nil;
    self.desc = nil;
}

@end
