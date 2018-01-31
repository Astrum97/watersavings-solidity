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
        return App.getBalances();
      });
    },
    getBalances: function(account) {
      console.log('Getting balances...');
  
      var HouseholdContractInstance;
      web3.eth.getAccounts(function(error, accounts) {
        if (error) {
          console.log(error);
        }
  
        var account = accounts[0];
        App.contracts.HouseholdContract.deployed().then(function(instance) {
          HouseholdContractInstance = instance;
          return HouseholdContractInstance.getOutstandingBalance(50);
        }).then(function(result) {
          balance = result.c[0];
          $('#balance').text(balance);
        }).catch(function(err) {
          console.log(err.message);
        });

        App.contracts.HouseholdContract.deployed().then(function(instance) {
          HouseholdContractInstance = instance;
          return HouseholdContractInstance.getWaterUsage();
        }).then(function(result) {
          balance = result.c[0];
          $('#waterusage').text(balance);
        }).catch(function(err) {
          console.log(err.message);
        });

        App.contracts.HouseholdContract.deployed().then(function(instance) {
          HouseholdContractInstance = instance;
          return HouseholdContractInstance.getBounty();
        }).then(function(result) {
          balance = result.c[0];
          $('#bounty').text(balance);
        }).catch(function(err) {
          console.log(err.message);
        });
      });
    }
  
  };
  
  $(function() {
    $(window).load(function() {
      App.init();
    });
  });
  