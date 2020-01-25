//
//  TWCObservation.m
//  Daemon
//
//  Created by Matt Clarke on 04/01/2020.
//

#import "XTWCObservation.h"
#import "NSDictionary+XENSafeObjectForKey.h"

@implementation XTWCObservation

- (instancetype)initWithData:(NSDictionary*)data units:(struct XTWCUnits)units {
    self = [super init];
    
    if (self) {
        [self _parseData:data units:units];
    }
    
    return self;
}

- (instancetype)initWithFakeData:(struct XTWCUnits)units {
    self = [super init];
    
    if (self) {
        self.cloudCoverDescription  = @"SKC";
        self.conditionIcon          = (id)[NSNull null];
        self.conditionDescription   = @"";
        self.dayIndicator           = @"X";
        self.validFromUNIXTime      = 0;
        self.pressureDescription    = @"";
        self.pressureTendency       = (id)[NSNull null];
        self.relativeHumidity       = (id)[NSNull null];
        self.uvDescription          = @"";
        self.uvIndex                = (id)[NSNull null];
        self.windDirection          = (id)[NSNull null];
        self.windDirectionCardinal  = @"N";
        self.dewpoint               = (id)[NSNull null];
        self.feelsLike              = (id)[NSNull null];
        self.gust                   = (id)[NSNull null];
        self.heatIndex              = (id)[NSNull null];
        self.maxTemp                = (id)[NSNull null];
        self.minTemp                = (id)[NSNull null];
        self.precipHourly           = (id)[NSNull null];
        self.precipTotal            = (id)[NSNull null];
        self.pressure               = (id)[NSNull null];
        self.temperature            = (id)[NSNull null];
        self.windChill              = (id)[NSNull null];
        self.windSpeed              = (id)[NSNull null];
        self.visibility             = (id)[NSNull null];
        self.waterTemperature       = (id)[NSNull null];
    }
    
    return self;
}

- (void)_parseData:(NSDictionary*)data units:(struct XTWCUnits)units {
    
    // Handle all non-metricy stuff first
    self.cloudCoverDescription  = [data objectForKey:@"clds" defaultValue:[NSNull null]];
    self.conditionIcon          = [data objectForKey:@"wx_icon" defaultValue:[NSNull null]];
    self.conditionDescription   = [data objectForKey:@"wx_phrase" defaultValue:[NSNull null]];
    self.dayIndicator           = [data objectForKey:@"day_ind" defaultValue:[NSNull null]];
    self.validFromUNIXTime      = [[data objectForKey:@"valid_time_gmt"] intValue];
    self.pressureDescription    = [data objectForKey:@"pressure_desc" defaultValue:[NSNull null]];
    self.pressureTendency       = [data objectForKey:@"pressure_tend" defaultValue:[NSNull null]];
    self.relativeHumidity       = [data objectForKey:@"rh" defaultValue:[NSNull null]];
    self.uvDescription          = [data objectForKey:@"uv_desc" defaultValue:[NSNull null]];
    self.uvIndex                = [data objectForKey:@"uv_index" defaultValue:[NSNull null]];
    self.windDirection          = [data objectForKey:@"wdir" defaultValue:[NSNull null]];
    self.windDirectionCardinal  = [data objectForKey:@"wdir_cardinal" defaultValue:[NSNull null]];
    
    NSDictionary *metricValues = [data objectForKey:@"metric"];
    NSDictionary *imperialValues = [data objectForKey:@"imperial"];
    
    if (!metricValues || !imperialValues) {
        self.dewpoint           = (id)[NSNull null];
        self.feelsLike          = (id)[NSNull null];
        self.gust               = (id)[NSNull null];
        self.heatIndex          = (id)[NSNull null];
        self.maxTemp            = (id)[NSNull null];
        self.minTemp            = (id)[NSNull null];
        self.precipHourly       = (id)[NSNull null];
        self.precipTotal        = (id)[NSNull null];
        self.pressure           = (id)[NSNull null];
        self.temperature        = (id)[NSNull null];
        self.windChill          = (id)[NSNull null];
        self.windSpeed          = (id)[NSNull null];
        self.visibility         = (id)[NSNull null];
        self.waterTemperature   = (id)[NSNull null];
    } else {
        NSDictionary *temperatureValues = units.temperature == METRIC ? metricValues : imperialValues;
        NSDictionary *speedValues = units.temperature == METRIC ? metricValues : imperialValues;
        NSDictionary *distanceValues = units.temperature == METRIC ? metricValues : imperialValues;
        NSDictionary *pressureValues = units.pressure == METRIC ? metricValues : imperialValues;
        NSDictionary *amountValues = units.amount == METRIC ? metricValues : imperialValues;
        
        self.dewpoint           = [temperatureValues objectForKey:@"dewpt" defaultValue:[NSNull null]];
        self.feelsLike          = [temperatureValues objectForKey:@"feels_like" defaultValue:[temperatureValues objectForKey:@"temp" defaultValue:[NSNull null]]];
        self.gust               = [speedValues objectForKey:@"gust" defaultValue:[NSNull null]];
        self.heatIndex          = [temperatureValues objectForKey:@"heat_index" defaultValue:[NSNull null]];
        self.maxTemp            = [temperatureValues objectForKey:@"max_temp" defaultValue:[NSNull null]];
        self.minTemp            = [temperatureValues objectForKey:@"min_temp" defaultValue:[NSNull null]];
        self.precipHourly       = [amountValues objectForKey:@"precip_hrly" defaultValue:[NSNull null]];
        self.precipTotal        = [amountValues objectForKey:@"precip_total" defaultValue:[NSNull null]];
        self.pressure           = [pressureValues objectForKey:@"pressure" defaultValue:[NSNull null]];
        self.temperature        = [temperatureValues objectForKey:@"temp" defaultValue:[NSNull null]];
        self.windChill          = [temperatureValues objectForKey:@"wc" defaultValue:[NSNull null]];
        self.windSpeed          = [speedValues objectForKey:@"wspd" defaultValue:[NSNull null]];
        self.visibility         = [distanceValues objectForKey:@"vis" defaultValue:[NSNull null]];
        self.waterTemperature   = [temperatureValues objectForKey:@"water_temp" defaultValue:[NSNull null]];
    }
}

@end