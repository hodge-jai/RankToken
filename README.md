# RankToken
A ranking system built on Ethereum

The contract contains nested mappings of user addresses to structs that contain an integer score field and a description field.

Users can raise or lower other users scores by burning some of the contracts tokens. The cost to raise or lower someones score by one unit is dependent on the amount of tokens currently in existence and the total amount of tokens that have ever been minted
