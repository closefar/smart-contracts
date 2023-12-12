import "CloseFarNFT"
import "CloseFarMarketplace"
import "FlowToken"
import "FungibleToken"
import "NonFungibleToken"

transaction {

  prepare(acct: AuthAccount) {
  
    if acct.borrow<&CloseFarNFT.Collection>(from: CloseFarNFT.nftCollectionStoragePath) == nil {

      acct.save(<- CloseFarNFT.createEmptyCollection(), to: CloseFarNFT.nftCollectionStoragePath)
      acct.link<&CloseFarNFT.Collection{CloseFarNFT.CollectionPublic, NonFungibleToken.CollectionPublic}>(CloseFarNFT.nftCollectionPublicPath, target: CloseFarNFT.nftCollectionStoragePath)
      acct.link<&CloseFarNFT.Collection>(CloseFarNFT.nftCollectionPrivatePath, target: CloseFarNFT.nftCollectionStoragePath)
    }

    acct.link<&FlowToken.Vault{FungibleToken.Receiver, FungibleToken.Balance}>
             (/public/flowTokenReceiver, target: /storage/flowTokenVault)

    if acct.borrow<&CloseFarMarketplace.SaleCollection>(from: CloseFarMarketplace.marketplaceCollectionStoragePath) == nil {
      let closeFarNFTCollection = acct.getCapability<&CloseFarNFT.Collection>(CloseFarNFT.nftCollectionPrivatePath)
      let flowTokenVault = acct.getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)

      acct.save(<- CloseFarMarketplace.createSaleCollection(ownerCollection: closeFarNFTCollection, ownerVault: flowTokenVault), to: CloseFarMarketplace.marketplaceCollectionStoragePath)
      acct.link<&CloseFarMarketplace.SaleCollection{CloseFarMarketplace.SaleCollectionPublic}>(CloseFarMarketplace.marketplaceCollectionPublicPath, target: CloseFarMarketplace.marketplaceCollectionStoragePath)
    }
    
  }

  execute {
    log("setup user done!")
  }
}

