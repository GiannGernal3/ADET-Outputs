// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ParcelTracker {
    address public owner;
    uint256 public constant MAX_ENTRIES = 1000;

    struct ParcelData {
        uint256 date_departed;
        uint256 date_arrived;
        string parcel_id;
        string origin;
        string destination;
    }

    ParcelData[] public dataRecords;

    event DataStored(
        uint256 date_departed,
        uint256 date_arrived,
        string parcel_id,
        string origin,
        string destination
    );

    constructor() {
        owner = msg.sender;
    }

    function storeData(
        string memory _parcelId,
        string memory _origin,
        string memory _destination,
        uint256 _dateDeparted,
        uint256 _dateArrived
    ) public {
        require(dataRecords.length < MAX_ENTRIES, "Max entries reached");

        ParcelData memory newData = ParcelData({
            date_departed: _dateDeparted,
            date_arrived: _dateArrived,
            parcel_id: _parcelId,
            origin: _origin,
            destination: _destination
        });

        dataRecords.push(newData);
        emit DataStored(_dateDeparted, _dateArrived, _parcelId, _origin, _destination);
    }

    function getRecord(uint256 index) public view returns (
        string memory parcel_id,
        string memory origin,
        string memory destination,
        uint256 date_departed,
        uint256 date_arrived
    ) {
        require(index < dataRecords.length, "Invalid index");
        ParcelData storage record = dataRecords[index];
        return (
            record.parcel_id,
            record.origin,
            record.destination,
            record.date_departed,
            record.date_arrived
        );
    }

    function getTotalRecords() public view returns (uint256) {
        return dataRecords.length;
    }
}