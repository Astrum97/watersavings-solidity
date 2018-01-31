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
  
      return App.bindEvents();
    },
  
    bindEvents: function() {
      $(document).on('click', '#transferButton', App.handleTransfer);
    },
  
    handleTransfer: function(event) {
      event.preventDefault();
  
      var amount = parseInt($('#TTTransferAmount').val());
      var toAddress = $('#TTTransferAddress').val();
  
      console.log('Transfer ' + amount + ' TT to ' + toAddress);
  
      var HouseholdContractInstance;
  
      web3.eth.getAccounts(function(error, accounts) {
        if (error) {
          console.log(error);
        }
  
        var account = accounts[0];
  
        App.contracts.HouseholdContract.deployed().then(function(instance) {
          HouseholdContractInstance = instance;
  
          return HouseholdContractInstance.transfer(toAddress, amount, {from: account});
        }).then(function(result) {
          alert('Transfer Successful!');
          return App.getBalances();
        }).catch(function(err) {
          console.log(err.message);
        });
      });
    },
  
    getBalances: function(adopters, account) {
      console.log('Getting balances...');
  
      var HouseholdContractInstance;
      console.log(1);
      web3.eth.getAccounts(function(error, accounts) {
        console.log(2);
        if (error) {
          console.log(3);
          console.log(error);
        }
  
        var account = accounts[0];
        console.log(4);
        App.contracts.HouseholdContract.deployed().then(function(instance) {
          HouseholdContractInstance = instance;
          console.log(5);
          return HouseholdContractInstance.balanceOf(account);
        }).then(function(result) {
          balance = result.c[0];
          console.log(6);
          $('#balance').text(balance);
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
  