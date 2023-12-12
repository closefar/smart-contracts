import "FlowToken"
import "CloseFarNFT"
import "CloseFarMarketplace"

transaction(tokenID: UInt64, price: UFix64) {

  prepare(acct: AuthAccount) {

    let saleCollection = acct.borrow<&CloseFarMarketplace.SaleCollection>(from: CloseFarMarketplace.marketplaceCollectionStoragePath)
                          ?? panic("This SaleCollection does not exist")

    saleCollection.listForSale(tokenID: tokenID, price: price)
  }

  execute {
    log("A user listed an NFT for Sale")
  }
}

