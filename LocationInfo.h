//
//  LocationInfo.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//


@interface LocationInfo : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) PFFile *imageFile; // image of recipe
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSInteger rank;


- (id)initLocationWithInfo:(NSString*)name
                      city:(NSString*)city
                   country:(NSString*)country
                 imageFile:(PFFile*)imageFile
                      desc:(NSString*)desc
                      rank:(NSInteger)rank;
@end
