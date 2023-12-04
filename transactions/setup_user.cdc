import CloseFar from 0x6
import NonFungibleToken from 0x5

transaction {

  prepare(acct: AuthAccount) {
  
    if acct.borrow<&CloseFar.Collection>(from: /storage/NFTCollection) != nil {
      return;
    }

    acct.save(<- CloseFar.createEmptyCollection(), to: /storage/NFTCollection)
    acct.link<&CloseFar.Collection{CloseFar.CollectionPublic, NonFungibleToken.CollectionPublic}>(/public/NFTCollection, target: /storage/NFTCollection)
    acct.link<&CloseFar.Collection>(/private/NFTCollection, target: /storage/NFTCollection)
  }

  execute {
    log("setup user done!")
  }
}
