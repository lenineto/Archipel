/*
 * TNNetworkDataView.j
 *
 * Copyright (C) 2010 Antoine Mercadal <antoine.mercadal@inframonde.eu>
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

@import <Foundation/Foundation.j>

@import <AppKit/CPView.j>
@import <AppKit/CPImageView.j>
@import <AppKit/CPTableView.j>
@import <AppKit/CPTextField.j>

@import <TNKit/TNTableViewDataSource.j>

/*! @ingroup hypervisornetworks
    This class represent a network DataView
*/
@implementation TNNetworkDataView : CPView
{
    @outlet CPImageView         imageStatus;
    @outlet CPTableView         tableDHCPHosts;
    @outlet CPTableView         tableDHCPRanges;
    @outlet CPTextField         fieldBridgeDelay;
    @outlet CPTextField         fieldBridgeForwardDevice;
    @outlet CPTextField         fieldBridgeForwardMode;
    @outlet CPTextField         fieldBridgeIP;
    @outlet CPTextField         fieldBridgeName;
    @outlet CPTextField         fieldBridgeNetmask;
    @outlet CPTextField         fieldBridgeSTP;
    @outlet CPTextField         fieldName;

    TNHypervisorNetwork         _network;
    TNTableViewDataSource       _datasourceHosts;
    TNTableViewDataSource       _datasourceRanges;
}


#pragma mark -
#pragma mark Overrides

/*! Message used by CPOutlineView to set the value of the object
    @param aContact TNStropheContact to represent
*/
- (void)setObjectValue:(id)aNetwork
{
    [tableDHCPRanges setIntercellSpacing:CPSizeMake(2.0, 2.0)];
    [tableDHCPHosts setIntercellSpacing:CPSizeMake(2.0, 2.0)];

    _network                = aNetwork;
    _datasourceRanges       = [[TNTableViewDataSource alloc] init];
    _datasourceHosts        = [[TNTableViewDataSource alloc] init];

    [imageStatus setImage:[aNetwork icon]];
    [fieldName setStringValue:[aNetwork networkName]];
    [fieldBridgeName setStringValue:[aNetwork bridgeName]];
    [fieldBridgeForwardDevice setStringValue:[aNetwork bridgeForwardDevice]];
    [fieldBridgeForwardMode setStringValue:([aNetwork bridgeForwardMode] != @"") ? [aNetwork bridgeForwardMode] : @"Nothing"];
    [fieldBridgeIP setStringValue:[aNetwork bridgeIP]];
    [fieldBridgeNetmask setStringValue:[aNetwork bridgeNetmask]];
    [fieldBridgeSTP setStringValue:[aNetwork isSTPEnabled] ? @"Yes" : @"No"];
    [fieldBridgeDelay setStringValue:[aNetwork bridgeDelay]];

    [tableDHCPRanges setDataSource:_datasourceRanges];
    [_datasourceRanges setTable:tableDHCPRanges];
    [_datasourceRanges setContent:[aNetwork DHCPEntriesRanges]];
    [tableDHCPRanges reloadData];

    [tableDHCPHosts setDataSource:_datasourceHosts];
    [_datasourceHosts setTable:tableDHCPHosts];
    [_datasourceHosts setContent:[aNetwork DHCPEntriesHosts]];
    [tableDHCPHosts reloadData];
}


#pragma mark -
#pragma mark CPCoding compliance

/*! CPCoder compliance
*/
- (id)initWithCoder:(CPCoder)aCoder
{
    self = [super initWithCoder:aCoder];

    if (self)
    {
        imageStatus = [aCoder decodeObjectForKey:@"imageStatus"];
        tableDHCPRanges = [aCoder decodeObjectForKey:@"tableDHCPRanges"];
        tableDHCPHosts = [aCoder decodeObjectForKey:@"tableDHCPHosts"];
        fieldName = [aCoder decodeObjectForKey:@"fieldName"];
        fieldBridgeName = [aCoder decodeObjectForKey:@"fieldBridgeName"];
        fieldBridgeForwardDevice = [aCoder decodeObjectForKey:@"fieldBridgeForwardDevice"];
        fieldBridgeForwardMode = [aCoder decodeObjectForKey:@"fieldBridgeForwardMode"];
        fieldBridgeIP = [aCoder decodeObjectForKey:@"fieldBridgeIP"];
        fieldBridgeNetmask = [aCoder decodeObjectForKey:@"fieldBridgeNetmask"];
        fieldBridgeSTP = [aCoder decodeObjectForKey:@"fieldBridgeSTP"];
        fieldBridgeDelay = [aCoder decodeObjectForKey:@"fieldBridgeDelay"];
    }

    return self;
}

/*! CPCoder compliance
*/
- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:imageStatus forKey:@"imageStatus"];
    [aCoder encodeObject:tableDHCPRanges forKey:@"tableDHCPRanges"];
    [aCoder encodeObject:tableDHCPHosts forKey:@"tableDHCPHosts"];
    [aCoder encodeObject:fieldName forKey:@"fieldName"];
    [aCoder encodeObject:fieldBridgeName forKey:@"fieldBridgeName"];
    [aCoder encodeObject:fieldBridgeForwardDevice forKey:@"fieldBridgeForwardDevice"];
    [aCoder encodeObject:fieldBridgeForwardMode forKey:@"fieldBridgeForwardMode"];
    [aCoder encodeObject:fieldBridgeIP forKey:@"fieldBridgeIP"];
    [aCoder encodeObject:fieldBridgeNetmask forKey:@"fieldBridgeNetmask"];
    [aCoder encodeObject:fieldBridgeSTP forKey:@"fieldBridgeSTP"];
    [aCoder encodeObject:fieldBridgeDelay forKey:@"fieldBridgeDelay"];
}

@end