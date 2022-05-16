pragma solidity ^0.8.11;

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
    require(studentExists(_address) == false , "Student already exists");
    students[_address].name = _name;
  }

  function addGrade(address _address, uint _points, string memory _field) public {
    require(msg.sender == owner, "You need to be the contract owner to add a grade");
    require(studentExists(_address) == true, "Student doesn't exist");
    require(_points >= 0, "A grade must be higher than 0");
    require(_points <= 20, "A grade must at most equal to 20");
    require(isValidField(_field) == true, "Not a valid field for mark");

    Grade memory g = Grade(_points, _field);
    students[_address].grades.push(g);
  }

  function getStudentGrades(address _address) view public returns(Grade[] memory) {
    require(msg.sender == owner, "You need to be the contract owner to view a student grade");
    return students[_address].grades;
  }

  function getGrades() view public returns(Grade[] memory) {
    return students[msg.sender].grades;
  }

  function studentExists(address _address) view private returns(bool) {
    bytes memory nameOfStudent = bytes(students[_address].name);
    return nameOfStudent.length > 0;
  }

  function isValidField(string memory _field) pure private returns(bool) {

    string[3] memory validFields = ["Math","Info","Bio"];

    uint i;
    for(i = 0; i < validFields.length; i += 1){
      // keccak256 is cheaper than "StringUtils.equal("","")"
      if(keccak256(bytes(validFields[i])) == keccak256(bytes(_field))){
        return true;
      }
    }
    
    return false;
  }

}
