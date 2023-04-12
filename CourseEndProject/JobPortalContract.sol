//SPDX-License-Identifier:MIT
pragma solidity ^0.6.12;

contract JobPortalContract {
 // Yet to Implement

struct applicant {
    uint256 id;
    string name;
    uint256 age;
    string qualification;
    string applicantType;
    uint256 rating;
    uint256 [] appliedJobs;
    address addr;
}

struct job {

    uint256 id;
    string jobName;
    string jobType;  
}

mapping(address => applicant)  applicants;

mapping(uint256 => job)  jobs;

  address private Admin;
    uint256  applicantId;
    

    modifier onlyAdmin() {
        require(msg.sender == Admin);
        _;
    }

    constructor() public {
        Admin = msg.sender;
    }

  

// 1.	Add a new applicant


    function addApplicant(
            string memory _name,
            uint256 _age,
            string memory _qualification,
            string memory _applicantType,
            address addr
    ) public onlyAdmin {
        

        applicants[addr].id =  applicantId;
        applicants[addr].name =  _name;
        applicants[addr].age =  _age;
        applicants[addr].qualification =  _qualification;
        applicants[addr].applicantType =  _applicantType;
        applicants[addr].addr =  addr;

        applicantId = applicantId + 1;
   
    }

// 2.	Get applicant details 

 function viewApplicant(address _addr)
        public
        view
        returns (
            uint256 id,
            uint256 age,
            string memory name,
            string memory qualification,
            string memory applicantType,
            uint256 rating,
            uint256[] memory appliedJobs
        )
    {
        applicant memory _applicant =  applicants[_addr];
        
        return (_applicant.id, _applicant.age, _applicant.name,_applicant.qualification,_applicant.applicantType,_applicant.rating,_applicant.appliedJobs);
    }

// 3.	Get applicant type 

function viewApplicantType(address _addr)
        public
        view
        returns (
            
            string memory applicantType
            
        )
    {
        applicant memory _applicant =  applicants[_addr];
        
        return (_applicant.applicantType);
    }

// 4.	Add a new Job to the portal 

function addJob(
           uint256 _id,
    string memory _jobName,
    string memory _jobType  
    ) public onlyAdmin {
        

        jobs[_id].id =  _id;
        jobs[_id].jobName =  _jobName;
        jobs[_id].jobType =  _jobType;
       
   
    }

// 5.	Get job details 

function viewJob(uint256 _id)
        public
        view
        returns (
            
               string memory jobName,
                string memory jobType  
            
        )
    {
        job memory _job =  jobs[_id];
        
        return (_job.jobName, _job.jobType);
    }

// 6.	Applicants apply for a job 
function applyForJob(
           address _applicant,
           uint256 _jobId
    
    ) public {

        //Check if job id is valid
       
        if (jobs[_jobId].id > 0) {
                // Invalid jobId
        } else {
           applicants[_applicant].appliedJobs.push(_jobId);
        }
        
   
    }


// 7.	Provide a rating to an applicant 

function provideRating(
           address _applicant,
           uint256 _rating  
    ) public onlyAdmin {
        

        applicants[_applicant].rating = _rating;
   
    }

// 8.	Fetch applicant rating 

function viewApplicantRating(address _addr)
        public
        view
        returns (
            
            uint256 rating
            
        )
    {
        
        return (applicants[_addr].rating);
    }





}