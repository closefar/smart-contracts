// GetSaleIDs.cdc

import "CloseFarMarketplace"

// This script prints the NFTs that account 0x01 has for sale.
pub fun main(address: Address) {
    // Get the public account object for account 0x01
    let account = getAccount(address)

    // Find the public Sale reference to their Collection
    let acct = account.getCapability(/public/NFTSale)
                       .borrow<&AnyResource{CloseFarMarketplace.SalePublic}>()
                       ?? panic("Could not borrow acct nft sale reference")

    // Los the NFTs that are for sale
    log("Account NFTs for sale")
    log(acct.getIDs())
    // log("Price")
    // log(acct.idPrice(tokenID: 0))
}
