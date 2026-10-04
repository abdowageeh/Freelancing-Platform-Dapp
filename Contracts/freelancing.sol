// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract FreelancingPlatform {
    ////////// Enums /////////////

    enum JobStatus {Open , Taken, Completed, Canceled}

    ////////// Structs /////////////
    struct Job {
        string title;
        string description;
        uint256 bounty;
        address client;
        address freelancer;
        JobStatus status;
    }


    ////////// Constants & State Vars /////////////
    uint256 public constant reputationReward = 1;
    uint256 public listingFee = 0.001 ether;
    address public owner;
    uint256 public totalJobs;


    ////////// Mappings  /////////////
    mapping(uint256 => Job) public jobs;
    mapping (address => uint256) public freelancerReputation;

    ////////// Events /////////////
    event JobCreated(uint indexed jobId,address indexed client, uint bounty);
    event JobCompleted(uint indexed jobId,address indexed freelancer);
    event JobTaken(uint indexed jobId,address indexed freelancer);

    ////////// Errors /////////////
    error insuficientFunds();

    ////////// Modifiers /////////////
    modifier onlyOwner (){
        require(msg.sender == owner, "Not Owner");
        _;
    }  

    //////////Functions /////////////
  constructor(){
    owner = msg.sender;
  }

  function postJob(string calldata _title, string calldata _description) external payable   {
    if (msg.value < listingFee) {
      revert insuficientFunds();
    }

    jobs[totalJobs] = Job({
      title : _title,
      description: _description ,
      bounty: msg.value - listingFee,
      client: msg.sender,
      freelancer:address(0),
      status:JobStatus.Open
    });

    emit JobCreated(totalJobs, msg.sender, msg.value - listingFee);
    
    totalJobs++; //job id
  
  }

  function getAllJobs() external view returns(Job[] memory) {
    Job[] memory allJobs = new Job[](totalJobs);

    for (uint i =1; i<= totalJobs; i++){
      allJobs[i-1] = jobs[i];

    }
    return allJobs;
  }

  function acceptJob(uint _jobId) external {
    Job storage job = jobs[_jobId];
    require(job.status == JobStatus.Open, "Not Available");
    require(msg.sender != job.client , "Client Can not be freelancer.");

    job.freelancer = msg.sender;
    job.status = JobStatus.Taken;

  emit JobTaken(_jobId , msg.sender);
  }

  function completeJob(uint _jobId) external  {
    Job storage job = jobs[_jobId];
    require(msg.sender == job.client, "only client can confirm");
    require(job.status == JobStatus.Taken, "job not in progress");

    job.status = JobStatus.Completed;
    freelancerReputation[job.freelancer] += reputationReward;
    emit JobCompleted(_jobId, job.freelancer);
    
  }

  function setListingFee(uint _listingFee) external onlyOwner  {

    listingFee =_listingFee;
  }

  function getPlatformBalance() external view returns (uint256) {

    return address(this).balance;
      
  }

}