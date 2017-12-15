# ATM mod for Minetest

This mod adds a faimly of ATM machines designed to work with the currency mod and its
minegeld banknotes. ATMs allow you to transfer money to your bank account and withdraw
various sums as needed.

There are 3 types of ATMs with different capabilities. The most basic version is grey and
only allows single banknote transactions.

```
[ steel ingot, mese wire, steel ingot ]
[ glass,       1 MG note, steel ingot ]
[ steel ingot, mese wire, steel ingot ]
```

The more advanced, green ATM, allows transactions in bundles of 10 notes.

```
[ steel ingot, mese wire,    steel ingot ]
[ glass,       5 MG note,    steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

The most advanced ATM, the yellow one, allows to add and withdraw banknotes by hundreds.

```
[ steel ingot, mese crystal, steel ingot ]
[ glass,       10 MG note,   steel ingot ]
[ steel ingot, mese crystal, steel ingot ]
```

Goes without saying, all lower tier options are also available in a higher tier ATM.

If mesecons mod is not installed, then the mese wire in recipes is replaced by a copper ingot.

## Founder

This is a fork of gpcf's ATM mod: git://gpcf.eu/atm.git