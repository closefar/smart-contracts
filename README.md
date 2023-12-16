```
# create account

flow accounts create
```

```
# deploy to testnet

flow accounts add-contract <PATH_TO_CONTRACT> --signer <ACCOUNT_NAME> --network=testnet
```

```
# update contract

flow accounts update-contract <PATH_TO_CONTRACT> --signer <ACCOUNT_NAME> --network=testnet
```


```
# Scripts:

flow scripts execute ./scripts/get_balance.cdc "<ACCOUNT_ADDRESS>" --network=testnet

flow scripts execute ./scripts/check_setup.cdc "<ACCOUNT_ADDRESS>" --network=testnet

flow scripts execute ./scripts/get_nfts.cdc "<ACCOUNT_ADDRESS>" --network=testnet

flow scripts execute ./scripts/get_sale_ids.cdc "<ACCOUNT_ADDRESS>" --network=testnet
```


```
# Transactions:

flow transactions send ./transactions/setup_account.cdc --signer <ACCOUNT_NAME> --network=testnet

flow transactions send ./transactions/mint_nft.cdc "<IPFS_HASH>" --signer <ACCOUNT_NAME> --network=testnet

flow transactions send ./transactions/create_sale.cdc <NFT_ID> <NFT_PRICE> --signer <ACCOUNT_NAME> --network=testnet

flow transactions send ./transactions/unlist_from_sale.cdc <NFT_ID> --signer <ACCOUNT_NAME> --network=testnet
```


NOTE: flow directory can be removed.