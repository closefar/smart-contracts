import CloseFar from 0x06
import NonFungibleToken from 0x5

pub fun main(account: Address): [&CloseFar.NFT] {
  let collection = getAccount(account).getCapability(/public/NFTCollection)
                    .borrow<&CloseFar.Collection{NonFungibleToken.CollectionPublic, CloseFar.CollectionPublic}>()
                    ?? panic("Can't get the User's collection.")

  let returnVals: [&CloseFar.NFT] = []

  let ids = collection.getIDs()
  for id in ids {
    returnVals.append(collection.borrowEntireNFT(id: id))
  }

  return returnVals
}
