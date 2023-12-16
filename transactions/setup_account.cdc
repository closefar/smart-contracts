// SetupAccount1Transaction.cdc

import "FlowToken"
import "FungibleToken"
import "NonFungibleToken"
import "CloseFarNFT"

// Sign this with the `close-far-contracts`
// This transaction sets up account 0x01 for the marketplace tutorial
// by publishing a Vault reference and creating an empty NFT Collection.
transaction {
  prepare(acct: AuthAccount) {
    // store an empty NFT Collection in account storage
    acct.save<@NonFungibleToken.Collection>(<- CloseFarNFT.createEmptyCollection(), to: CloseFarNFT.CollectionStoragePath)

    // publish a capability to the Collection in storage
    acct.link<&{CloseFarNFT.CollectionPublic}>(CloseFarNFT.CollectionPublicPath, target: CloseFarNFT.CollectionStoragePath)

    log("Created a new empty collection and published a reference")
  }
}
