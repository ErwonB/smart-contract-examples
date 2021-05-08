pragma solidity >=0.4.22 <0.9.0;

contract DIR_contract {
    
    address reporter;
    string name;
    string reportType;
    string desc;
    uint reportStatus;

    event createReportEvent(address indexed _reporter, string _name, string _reportType, string _desc);

    function createReport(string memory _name, string memory _reportType, string memory _desc) public {
        reporter = msg.sender;
        name = _name;
        reportType = _reportType;
        desc = _desc;
        reportStatus = 1;
        emit createReportEvent(reporter, name, reportType, desc);
    }

    function getReport() public view returns (
        address _reporter, string memory _name, string memory _reportType, string memory _desc, uint _reportStatus) {
        return(reporter,name,reportType,desc,reportStatus);
    }

    function setStatus(uint _reportStatus) public {
        reportStatus = _reportStatus;
    }
}

