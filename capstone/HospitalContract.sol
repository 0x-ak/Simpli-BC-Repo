//SPDX-License-Identifier:MIT
pragma solidity ^0.6.12;

contract HospitalContract {
    struct Disease {
        string name;
    }

    struct doctor {
        uint256 id;
        string name;
        string qualification;
        string workPlace;
        address addr;
    }

    struct patient {
        uint256 id;
        string name;
        uint256 age;
        address addr;
        Disease[] diseases;
        string[] prescribedMedicines;
    }


    struct medicine {
        uint256 id;
        string name;
        string expiryDate;
        uint256 dose;
        uint256 price;
    }

    //event
    event newPatientEvent(string indexed _name, uint256 _patientId);
    event newDoctorEvent(string indexed _name, uint256 _doctorId);

    address private Owner;
    uint256  patientId;
    uint256  doctorId;

    modifier onlyOwner() {
        require(msg.sender == Owner);
        _;
    }

    constructor() public {
        Owner = msg.sender;
    }

    address[] doctorList;
    mapping(address => doctor)  registeredDoctors;

    address[] patientList;
    mapping(address => patient) registeredPatients;

    mapping(uint256 => medicine) medicines;

    // Create a pure utility function to serialise diseases in to a string.
    function diseasesToString (Disease[] memory _diseases) private pure returns (string memory diseases) {
        string memory _diseasesStr ;

       
        uint256 len = _diseases.length;

        for (uint256 i=0;i<len;i++){
            if(i==0)
            _diseasesStr = _diseases[i].name ;
            else 
            _diseasesStr =  string(abi.encodePacked(_diseasesStr,", " ,  _diseases[i].name)) ;

        }

        return (_diseasesStr);
    } 

     // Create a pure utility function to serialise prescribedMedicines in to a string.
    function prescriptionsToString (string[] memory _prescriptions) private pure returns (string memory prescriptions) {
       
     
        uint256 len = _prescriptions.length;

        for (uint256 i=0;i<len;i++){
            if(i==0)
            prescriptions = _prescriptions[i] ;
            else 
            prescriptions =  string(abi.encodePacked(prescriptions,", " ,  _prescriptions[i])) ;

        }

        return (prescriptions);
    } 

// Create a pure utility function to convert uint in to a string.
function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
        return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
        len++;
        j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
        bstr[k--] = byte(uint8(48 + _i % 10));
        _i /= 10;
    }
    return string(bstr);
}

    //    This function is used to register a new doctor to the ledger. It takes the below parameters:
    /**  
        @param _name Name of the doctor
        @param _qualification Which degree he/she holds as a doctor
        @param _workPlace Address of his/her hospital/clinic
    */
    

    function registerDoctor(
        string memory _name,
        string memory _qualification,
        string memory _workPlace
    ) public onlyOwner {
        

        doctorList.push(msg.sender);

        registeredDoctors[msg.sender] = doctor(
            doctorId,
            _name,
            _qualification,
            _workPlace,
            msg.sender
        );
        doctorId = doctorId + 1;
        //fire the event
        emit newDoctorEvent(_name, doctorId);
    }

    // This function is used to register a new patient to the ledger. It takes the below parameters:
    /**
        @param _name Name of the user
        @param _age Age of user
    */

    function registerPatient(string memory _name, uint32 _age) public {
        
       
        patientList.push(msg.sender);
        registeredPatients[msg.sender].id =  patientId;
        registeredPatients[msg.sender].name =  _name;
        registeredPatients[msg.sender].age =  _age;
        registeredPatients[msg.sender].addr =  msg.sender;
        
       patientId = patientId + 1;
        //fire the event
        emit newPatientEvent(_name, patientId);
    }

    //This function is used to add a patient's disease. It takes the below parameters:
    /**
         @param _disease Name of the disease
    */

    function addNewDisease(string memory _disease) public {
        registeredPatients[msg.sender].diseases.push(Disease(_disease));
    }

    //This function is used to add medicines. It takes the below parameters:

    /**  
        @param _id Id of the medicine
        @param _name name of the medicine
        @param _expiryDate ExpiryDate of the medicine
       @param _dose Dose prescribed to the patient
        @param _price Price of the medicine 
    */

    function addMedicine(
        uint256 _id,
        string memory _name,
        string memory _expiryDate,
        uint256 _dose,
        uint256 _price
    ) public {
    
        medicines[_id].id =  _id;
        medicines[_id].name =  _name;
        medicines[_id].expiryDate =  _expiryDate;
        medicines[_id].dose =  _dose;
        medicines[_id].price =  _price;
        
    }

    //This function is used by doctors to prescribe medicine to a patient. It takes the below parameters:

    /**
        @param _id Medicine Id
        @param _patient address of the patient
    */

    function prescribeMedicine(uint256 _id, address _patient) public {
       
        registeredPatients[_patient].prescribedMedicines.push(uint2str(_id));
    }

    //This function helps patients to update their age. It takes the below parameters:
    /**
          @param _age New age of the patient
    */

    function updateAge(uint256 _age) public {
         patient storage _patient =  registeredPatients[msg.sender];
         _patient.age = _age;

    }

    //This function helps to view patient data stored in Blockchain. It takes the below parameters:
    /**
         @return id Id of the patient
        @return age Age of the patient
        @return name Name of the patient
        @return disease All the diseases of the patient
    */

    function viewRecord()
        public
        view
        returns (
            uint256 id,
            uint256 age,
            string memory name,
            string memory disease
        )
    {
        patient memory _patient =  registeredPatients[msg.sender];
        string memory _disease = diseasesToString(_patient.diseases);
        
        return (_patient.id, _patient.age, _patient.name,_disease);
    }

    //This function helps to fetch medicine details. This function below input parameters and return the details about the medicine.

    /**
        @param _id Id of the medicine
        @return name Name of the medicine
        @return expiryDate Expiry date of the medicine
        @return dose Dose prescribed for the medicine
        @return price Price of the medicine
    */

    function viewMedicine(uint256 _id)
        public
        view
        returns (
            string memory name,
            string memory expiryDate,
            uint256 dose,
            uint256 price
        )
    {
 
        medicine memory _medicine =  medicines[_id];
        
        return (_medicine.name, _medicine.expiryDate, _medicine.dose,_medicine.price);
    }

    //This function helps a doctor to view patient data. It takes the below parameters:

    /**
        @param _id ID of the patient
        @return id ID of the patient
        @return age Age of the patient
        @return name Name of the patient
        @return disease All the diseases of the patient
    */

    function viewPatientById(uint256 _id)
        public
        view
        returns (
            uint256 id,
            uint256 age,
            string memory name,
            string memory disease
        )
    {
        patient memory _patient =  registeredPatients[patientList[_id]];
        string memory _disease = diseasesToString(_patient.diseases);
        
        return (_patient.id, _patient.age, _patient.name,_disease);
    }

    //This function helps the doctor to view patient data. It takes the below parameters:

    /**
        @dev View prescribed medicines to the patient 
        @param _patient address of the patient
        @return ids list of medicine id's
    */

    function viewPrescribedMedicines(address _patient)
        public
        view
        returns (
            string memory ids
        )
    {
      
        string memory _prescriptions = prescriptionsToString(registeredPatients[_patient].prescribedMedicines);
        
        return (_prescriptions);
    }

    //This function helps to view doctor details. It takes the below parameters:

    /**
        @param _id ID of the doctor
        @return id ID of the doctor
        @return name Name of the doctor
        @return qualification Name of degree he/she holds as a doctor
        @return add Address of his/her hospital/clinic
    */

    function viewDoctorById(uint256 _id)
        public
        view
        returns (
            uint256 id,
            string memory name,
            string memory qualification,
            string memory add
        )
    {
         doctor memory _doctor =  registeredDoctors[doctorList[_id]];
        return (_doctor.id, _doctor.name,_doctor.qualification, _doctor.workPlace);
    }
}
