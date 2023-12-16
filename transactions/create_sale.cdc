// CreateSale.cdc

import "FungibleToken"
import "CloseFarNFT"
import "CloseFarMarketplace"

// This transaction creates a new Sale Collection object,
// lists an NFT for sale, puts it in account storage,
// and creates a public capability to the sale so that others can buy the token.
transaction(tokenID: UInt64, price: UFix64) {

    prepare(acct: AuthAccount) {

        // Borrow a reference to the stored Vault
        let receiver = acct.getCapability<&{FungibleToken.Receiver}>(/public/flowTokenReceiver)

        // borrow a reference to the nftTutorialCollection in storage
        let collectionCapability = acct.link<&CloseFarNFT.Collection>(/private/nftTutorialCollection, target: CloseFarNFT.CollectionStoragePath)
          ?? panic("Unable to create private link to NFT Collection")

        // Create a new Sale object,
        // initializing it with the reference to the owner's vault
        let sale <- CloseFarMarketplace.createSaleCollection(ownerCollection: collectionCapability, ownerVault: receiver)

        // List the token for sale by moving it into the sale object
        sale.listForSale(tokenID: tokenID, price: price)

        // Store the sale object in the account storage
        acct.save(<-sale, to: /storage/NFTSale)

        // Create a public capability to the sale so that others can call its methods
        acct.link<&CloseFarMarketplace.SaleCollection{CloseFarMarketplace.SalePublic}>(/public/NFTSale, target: /storage/NFTSale)

        log("Sale Created for account.")
    }
}

