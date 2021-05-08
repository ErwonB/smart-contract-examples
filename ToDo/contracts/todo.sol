pragma solidity >=0.4.22 <0.9.0;

contract ToDo {
    struct Routine {
        string task;
        string time;
    }

    event LogTaskAdded(uint id, string task, string time);

    mapping(uint => Routine) private routines;
    uint[] private ids;

    function getTaskCount() public view returns (uint length) {
        return ids.length;
    }

    function getTaskIdAt(uint index) public view returns (uint id) {
        return ids[index];
    }

    function getTask(uint id) public view returns (string memory task, string memory time) {
        Routine storage routine = routines[id];
        return (routine.task, routine.time);
    }

    function addTask(uint id, string memory task, string memory time) public returns (bool success) {
        routines[id] = Routine({task: task, time: time});
        ids.push(id);

        emit LogTaskAdded(id, task, time);
        return true;
    }
}

