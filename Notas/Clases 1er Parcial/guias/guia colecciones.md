ej 1 isw guia 1 parte 2
"1a"
a := Array with: 1 with:2 with:3 with:2


"1b"
b := OrderedCollection with: 4 with:3 with:2 with:1.
b add: 42.
b add: 2.
"cant elementos"
b size.
"cant apariciones"
b occurrencesOf: 2.

"1c"

c := Set with: 4 with:3 with:2 with:1.
"..."

"1d"
d := Dictionary new.
"los ; son para que se le pueda mandar varios mensajes add a x"
d add: #a->4; add: #b->3; add:#c->1; add: #d->2; yourself.
d keys.
d values.
d at: #z ifAbsent: 24.

"1.2"
a asOrderedCollection.
a asSet.

"dictionary to araray returns values! not keys"
d asArray #(3 4 2 1) .