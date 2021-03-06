const fs = require('fs');

const { readSmartContractsFile, getSmartContractAddress } = require ("./utils.js");
const { smartContractsPath } = require ('../truffle.js');
const migrations_dir = './migrations/';

const NETWORKS = {
  "1" : "mainnet",
  "3" : "ropsten",
  "4" : "rinkeby"
};

const Migrations = artifacts.require("Migrations");

var smartContracts = readSmartContractsFile(smartContractsPath);
const migrationsAddress = getSmartContractAddress(smartContracts, ":migrations");

/**
 * env DISTRICT_REGISTRY_ENV=dev truffle exec ./migrations/check_ran_migrations.js --network ganache
 */
module.exports = function(callback) {
  web3.version.getNetwork( (error, id) => {

    console.log ("@@@ using Web3 version:", web3.version.api);
    console.log("@@@ using smart_contracts file ", smartContractsPath);

    const network = NETWORKS [id] || "ganache";
    const migrations = Migrations.at (migrationsAddress);

    migrations.last_completed_migration ()
      .then ((response) => {

        const number = response.c [0];
        console.log ("last completed migration on the network", network, "has number", number);

        fs.readdirSync(migrations_dir).forEach(file => {
          var migrationNumber = file.match(/^\d+|\d+\b|\d+(?=\w)/g) || false;
          if (migrationNumber && migrationNumber [0] > number) {
            console.error ("ERROR: migration", migrationNumber [0], "has not been ran on the network", network);
            process.exit(1);
          }
        });

        console.log ("Done.");
      })
      .then (callback);
  });

}
