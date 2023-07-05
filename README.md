# ATM mod for Minetest

This mod adds a faimly of ATMs (Automated Teller Machines) designed to work with the currency
mod and its Minegeld banknotes. ATMs allow you to transfer money to your bank account and withdraw
various sums as needed.

## ATMs

There are 3 types of ATMs with different capabilities.

### ATM
The most basic version is grey and blue and only allows single banknote transactions
with Minegeld notes of value 1, 5 and 10.

```
[ steel ingot, mese wire, steel ingot ]
[ glass,       1 Mg note, steel ingot ]
[ steel ingot, mese wire, steel ingot ]
```

### ATM Model 2
The more advanced, brownish and purple ATM, allows transactions in bundles of 10 notes
with Minegeld notes of value 1, 5, 10 and 50.

```
[ steel ingot, mese wire,    steel ingot ]
[ glass,       5 Mg note,    steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

### ATM Model 3
The most advanced ATM, the yellow and red one, allows to add and withdraw banknotes by hundreds
with Minegeld notes of value 1, 5, 10, 50 and 100.

```
[ steel ingot, mese crystal, steel ingot ]
[ glass,       10 Mg note,   steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

### Crafting note

If the Mesecons mod is not installed, then the mese wire in recipes is replaced by a copper ingot.

## Wire Transfer

An alternative system for transfering money from one player's account to another. The terminals
provide an interface for sending a specified amount (integer number) to a player (who must
have an existing banking account) and for checking the transfers to the account of the user of
the terminal. The history of transactions can be erased completely, and it is recommended to
clean it once the stored data are no longer of any relevance. Otherwise, the transaction history
is preserved indefinitely.

```
[ steel ingot, mese crystal, steel ingot ]
[ glass,       mese wire,    steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

To complete a wire transfer a player must provide the name of the recipient with an
existing banking account, the desired amount to be transfered, and a description of the 
payment (optional, but strongly recommended).
After entering those parameters the terminal checks their validity and if there is no problem,
the player is shown the final confirmation window. If the player confirms the payment, the specified
amount will be transfered immediately. At this point the transaction is final.
If there are errors, a corresponding message is shown in the chat, and the transaction is aborted.

## Founder

This is a fork of gpcf's ATM mod: git://gpcf.eu/atm.git
