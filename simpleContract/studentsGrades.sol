pragma solidity^0.8.11;

// SPDX-License-Identifier: MIT

contract School {

  address owner;

  struct Grade {
    uint points;
    string field;
  }

  struct Student {
    string name;
    Grade[] grades;
  }

  mapping (address => Student) students;

  constructor(){
    owner = msg.sender;
  }

  function addStudent(address _address, string memory _name) public {
    require(msg.sender == owner, "You need to be the contract owner to add a student");
    students[_address].name = _name;
  }

  function addGrade(address _address, uint _points, string memory _field) public {
    require(msg.sender == owner, "You need to be the contract owner to add a grade");
    Grade memory g = Grade(_points, _field);
    students[_address].grades.push(g);
  }

  function getGrades(address _address) view public returns(Grade[] memory) {
    return students[_address].grades;
  }

}

