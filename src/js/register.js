/* Toggle between adding and removing the "responsive" class to topnav when the user clicks on the icon */
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
      x.className += " responsive";
  } else {
      x.className = "topnav";
  }
} 

App = {
    web3Provider: null,
    contracts: {},
  
    init: function() {
      return App.initWeb3();
    },
  
    initWeb3: function() {
      if (typeof web3 !== 'undefined') {
        App.web3Provider = web3.currentProvider;
        web3 = new Web3(web3.currentProvider);
      } else {
        App.web3Provider = new Web3.providers.HttpProvider('http://127.0.0.1:7545');
        web3 = new Web3(App.web3Provider);
      }
  
      return App.initContract();
    },
  
    initContract: function() {
      $.getJSON('../HouseholdContract.json', function(data) {
        var HouseholdContractArtifact = data;
        App.contracts.HouseholdContract = TruffleContract(HouseholdContractArtifact);
        App.contracts.HouseholdContract.setProvider(App.web3Provider);
        return App.getWaterUsage();
      });
  
      return App.bindEvents();
    },
  
    bindEvents: function() {
      $(document).on('click', '#Submit', App.saveUserDetails);
    },

    saveUserDetails: function() {
        var id = $('#idNumber').val();
        App.contracts.HouseholdContract.deployed().then(function(instance) {
            HouseholdContractInstance = instance;
            return HouseholdContractInstance.setId(id);
          }).then(function(result) {
            App.contracts.HouseholdContract.deployed().then(function(instance) {
                HouseholdContractInstance = instance;
                return HouseholdContractInstance.setPenaltyFactor(1);
              }).then(function(result) {
                App.contracts.HouseholdContract.deployed().then(function(instance) {
                    HouseholdContractInstance = instance;
                    return HouseholdContractInstance.setTime();
                  }).then(function(result) {
                    App.contracts.HouseholdContract.deployed().then(function(instance) {
                        var dependents = $('#dependents').val();
                        HouseholdContractInstance = instance;
                        return HouseholdContractInstance.setNumberOfDependants(dependents);
                      }).then(function(result) {
                        window.location = '../views/dashboard.html';
                      }).catch(function(err) {
                        console.log(err.message);
                    });
                  }).catch(function(err) {
                    console.log(err.message);
                });
              }).catch(function(err) {
                console.log(err.message);
            });
          }).catch(function(err) {
            console.log(err.message);
        });
    }
  };
  
  $(function() {
    $(window).load(function() {
      App.init();
    });
});