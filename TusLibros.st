!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'support' stamp: 'pfu 11/8/2024 19:53:04'!
setUp
	super initialize.
	factory := SetupTestObjectsFactory new.! !


!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 19:53:16'!
test01CartIsEmptyWhenCreated
	|cart |
	cart := Cart acceptingItemsFrom: factory priceList.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 19:53:20'!
test02AddingABookToCartMakesItNotEmpty
	"esta demas"
	| cart |
	cart := Cart acceptingItemsFrom: factory priceList.

	
	cart addBook: '1' amount: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 19:53:24'!
test03AddingMultipleBooksAffectPurchaseListSize
	|cart |
	"esta demas"
	cart := Cart acceptingItemsFrom: factory priceList.

	
	cart addBook: '1' amount: 1.
	cart addBook: '2' amount: 5.
	
	self assert: cart purchaseListSize equals: 6.! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 19:53:27'!
test04InvalidAmountOfBooks
	|cart |
	cart := Cart acceptingItemsFrom: factory priceList.

	
	self should: [cart addBook: '3' amount: 0]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: Cart invalidAmountOfBooksError.
		self assert: cart isEmpty.]
	! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 19:53:30'!
test05InvalidISBNFails
	|cart |
	cart := Cart acceptingItemsFrom: factory priceList.

	
	self should: [cart addBook: 'test' amount: 4]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: Cart invalidISBNError.
		self assert: cart isEmpty.]
	! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:41:53'!
test06CartCanListBooksWhenEmpty
	|cart |
	cart := Cart acceptingItemsFrom: factory priceList.

	
	self assert: cart listYourself equals: ''! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:43:15'!
test07CartCanListBooksWhenItHasMultipleBooks
	|cart |
	cart := Cart acceptingItemsFrom: factory priceList.

	cart addBook: '1' amount: 1.
	cart addBook: '3' amount: 5.

	self assert: cart listYourself equals: '|1|1|3|5'! !

!CartTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:43:18'!
test08CartCanListPurchases
	|cart |
	cart := Cart acceptingItemsFrom: factory priceList.

	cart addBook: '2' amount: 1.
	cart addBook: '3' amount: 5.

	self assert: cart purchaseList equals: '|2|1|3|5|6'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 18:22:31'!
test01CannotCheckoutEmptyCart
	|cart cashier|
	cart := Cart acceptingItemsFrom: factory priceList.
	cashier := Cashier new.
	
	self should: [cashier checkout: cart]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'Empty cart'].
	
	! !

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 18:23:34'!
test02CashierCheckoutsCorrectPriceForCart
	|cart cashier total |
	cart := Cart acceptingItemsFrom: factory priceList.
	cart addBook: '1' amount: 2.
	
	cashier := Cashier with: factory stubMerchantProcessor.
	
	total := cashier checkout: cart.
	
	self assert: total equals: 50.
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 18:23:41'!
test03CashierCheckoutsCorrectPriceForCartWithDifferentItems
	|cart cashier total |
	cart := Cart acceptingItemsFrom: factory priceList.
	cart addBook: '1' amount: 2.
	cart addBook: '3' amount: 5.
	
	cashier := Cashier with: factory stubMerchantProcessor.
	
	total := cashier checkout: cart.
	
	self assert: total equals: 425.
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 18:29:54'!
test04CashierCantCheckoutWithExpiredCard
	|cart cashier today |
	cart := Cart acceptingItemsFrom: factory priceList.
	cart addBook: '1' amount: 2.
	cashier := Cashier with: factory stubMerchantProcessor.
	today := factory today.
	
	self should: [cashier checkout: cart with: factory expiredCreditCard onDate: today]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error |
		self assert: error messageText equals: 'Expired credit card'.
		self assert: cart purchaseListSize equals: 2.
		self assert: factory stubMerchantProcessor requestsReceived equals: 0.
		]
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 19:57:22'!
test05CashierCantCheckoutWithStolenCard
	|cart cashier  |
	cart := Cart acceptingItemsFrom: factory priceList.
	cart addBook: '1' amount: 2.
	cashier := Cashier with: factory stubMerchantProcessor.

	
	self should: [cashier checkout: cart with: factory robbedCreditCard onDate: factory today]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'Robbed credit card'.
		self assert: cart purchaseListSize equals: 2.
		self assert: factory stubMerchantProcessor requestsReceived equals: 1.
		]
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 18:30:19'!
test06CashierCantCheckoutWithEmptyCard
	|cart cashier |
	cart := Cart acceptingItemsFrom: factory priceList.
	cart addBook: '1' amount: 2.
	cashier := Cashier with: factory stubMerchantProcessor.
	
	self should: [cashier checkout: cart with: factory emptyCreditCard onDate: factory today]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error |
		self assert: error messageText equals: 'Empty credit card'.
		self assert: cart purchaseListSize equals: 2.
		self assert: factory stubMerchantProcessor requestsReceived equals: 1.

		]
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'pfu 11/8/2024 18:30:26'!
test07CashierCheckoutsWithValidCard
	|cart cashier total |
	cart := Cart acceptingItemsFrom: factory priceList.
	cart addBook: '1' amount: 2.
	cashier := Cashier with: factory stubMerchantProcessor.
	
	total := cashier checkout: cart with: factory validCreditCard onDate: factory today.
	
	self assert: total equals: 50.
	self assert: factory stubMerchantProcessor requestsReceived equals: 1.
	! !


!CashierTest methodsFor: 'support' stamp: 'pfu 11/8/2024 18:22:11'!
setUp
	super setUp.
	factory := SetupTestObjectsFactory new.! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 17:54:42'!
test01CannotCreateInvalidCreditCard
	self should: [CreditCard for: 'me' with: 0 expiringOn: GregorianMonthOfYear current]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error |
		self assert: error messageText equals: 'Credit card number should have 16 digits']! !

!CreditCardTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 17:55:36'!
test02CardKnowsHowToCompareExpirationDate
	|card|
	card := CreditCard for: 'me' with: 9999999999999999 expiringOn: GregorianMonthOfYear current.
	
	self assert: (card expiresBefore: GregorianMonthOfYear current next).! !

!CreditCardTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 17:54:55'!
test03CardKnowsItsNumber
	|card|
	card := CreditCard for: 'me' with: 9999999999999999 expiringOn: GregorianMonthOfYear current.
	
	self assert: (card hasNumber: 9999999999999999).! !

!CreditCardTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 17:55:29'!
test04CardKnowsHowToCompareExpirationDate
	|card|
	card := CreditCard for: 'me' with: 9999999999999999 expiringOn: GregorianMonthOfYear current.
	
	self deny: (card expiresBefore: GregorianMonthOfYear current previous).! !

!CreditCardTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 17:55:07'!
test05CardKnowsHowToCompareNumber

	| card |
	card := CreditCard for: 'me' with: 9999999999999999 expiringOn: GregorianMonthOfYear current.
	
	self deny: (card hasNumber: 9999999999999998).! !


!classDefinition: #RESTAdapterTest category: #TusLibros!
TestCase subclass: #RESTAdapterTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTAdapterTest methodsFor: 'support' stamp: 'pfu 11/8/2024 20:59:30'!
assertRest: aRESTHandler emptyCart: aCartId
	
	self assert: (aRESTHandler listCart: aCartId) equals: ''.! !


!RESTAdapterTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:54:14'!
test01CreateCartWithInvalidCredentials
	|rest  | 
	rest := RESTAdapter validatingWith: factory credentialValidator priceList: factory priceList.
	
	self should: [rest createCartForUser: 'pedro' withPassword: 'WRONGPASSWORD']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: StubCredentialValidator invalidCredentials.
		
]! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:59:51'!
test02CartCreatedWithValidCredentialsIsEmpty
	|rest  cartId | 
	rest := RESTAdapter validatingWith: factory credentialValidator priceList: factory priceList.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	
	self assertRest: rest emptyCart: cartId.
! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:46:55'!
test03AddingToCart
	|rest  cartId book1 book2 | 
	rest := RESTAdapter validatingWith: factory credentialValidator priceList: factory priceList.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	book1 := factory book1.
	book2 := factory book2.

	rest addToCart: cartId amount: 3 of: book1.
	rest addToCart: cartId amount: 3 of: book2.
	
	self assert: (rest listCart: cartId) equals: '|',book1,'|3|',book2, '|3'.! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'pfu 11/8/2024 20:58:24'!
test04AddingInvalidAmountToCart
	|rest  cartId book1 | 
	rest := RESTAdapter validatingWith: factory credentialValidator priceList: factory priceList.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	book1 := factory book1.
	
	self should: [rest addToCart: cartId amount:(-1) of: book1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assertRest: rest emptyCart: cartId.
		]! !


!RESTAdapterTest methodsFor: 'setup' stamp: 'pfu 11/8/2024 19:58:31'!
setUp
	super initialize.
	factory := SetupTestObjectsFactory new! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialize' stamp: 'pfu 11/5/2024 20:25:55'!
initializeAcceptingFrom: aPriceList
	catalog := aPriceList.
	books := Bag new.! !


!Cart methodsFor: 'testing' stamp: 'pfu 11/2/2024 09:04:13'!
isEmpty
	^books size = 0.! !

!Cart methodsFor: 'testing' stamp: 'pfu 11/5/2024 20:27:12'!
purchaseListSize
	^books size! !


!Cart methodsFor: 'books' stamp: 'pfu 11/5/2024 20:28:18'!
addBook: anISBN amount: anAmount 
	self assertValidAmountOfBooksToAdd: anAmount.
	self assertValidISBN: anISBN.
	
	"chequear si existe antes!! si no la estoy pisando"
	books add: anISBN withOccurrences: anAmount.! !

!Cart methodsFor: 'books' stamp: 'pfu 11/5/2024 20:32:07'!
getAmountOf: aBook
	^books occurrencesOf: aBook! !

!Cart methodsFor: 'books' stamp: 'pfu 11/8/2024 20:43:10'!
listYourself
	| response |
	response := String new	.
	books asSet do: 
		[ :book | response := response, '|', book, '|', (books occurrencesOf: book) asString. ].
	
	^response
! !


!Cart methodsFor: 'SUM PRICE' stamp: 'pfu 11/5/2024 21:12:26'!
priceOf: aBook
	^catalog at: aBook ifAbsent: [self error: 'You asked for the price of the object I dont know the price of'].! !

!Cart methodsFor: 'SUM PRICE' stamp: 'pfu 11/8/2024 17:37:11'!
total
	^books sum: [:book | self priceOf: book] ifEmpty:[0].! !


!Cart methodsFor: 'asserts' stamp: 'pfu 11/2/2024 09:15:30'!
assertValidAmountOfBooksToAdd: anAmount
	(anAmount isInteger and: [anAmount >= 1]) ifFalse: [self error: self class invalidAmountOfBooksError]! !

!Cart methodsFor: 'asserts' stamp: 'pfu 11/5/2024 19:54:23'!
assertValidISBN: anISBN
	(catalog includesKey: anISBN) 
	ifFalse: [self error: self class invalidISBNError]! !

!Cart methodsFor: 'asserts' stamp: 'pfu 11/2/2024 09:41:19'!
purchaseList
	^ self listYourself, '|', (self purchaseListSize asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!


!Cart class methodsFor: 'errors' stamp: 'pfu 11/2/2024 09:15:24'!
invalidAmountOfBooksError
	^ 'Amount of books should be an integer greater or equal to 1'! !

!Cart class methodsFor: 'errors' stamp: 'pfu 11/2/2024 09:29:40'!
invalidISBNError
	^ 'Invalid ISBN'! !


!Cart class methodsFor: 'instance creation' stamp: 'pfu 11/5/2024 19:52:58'!
acceptingItemsFrom: aPriceList
	^ self new initializeAcceptingFrom: aPriceList.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'merchant'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'asserts' stamp: 'pfu 11/5/2024 19:27:29'!
assertCartNotEmpty: aCart
	aCart isEmpty ifTrue:[self error: 'Empty cart'].! !

!Cashier methodsFor: 'asserts' stamp: 'pfu 11/8/2024 17:57:03'!
assertValidExpirationDate: aCreditCard withCurrent: aCurrentDate
	(aCreditCard expiresBefore: aCurrentDate) ifTrue: [self error: 'Expired credit card']
! !


!Cashier methodsFor: 'checkout' stamp: 'pfu 11/8/2024 17:37:12'!
checkout: aCart
	| total |
	self assertCartNotEmpty: aCart.
	
	"ex implementacion.."
	"priceList keysAndValuesDo: [:book :price | total := total + (price * (aCart getAmountOf: book))]."
	total := aCart total.
	
	^total
	
	! !

!Cashier methodsFor: 'checkout' stamp: 'pfu 11/8/2024 17:58:02'!
checkout: aCart with: aCreditCard onDate: currentDate
	| total |
	self assertCartNotEmpty: aCart.
	total := aCart total.

	
	self assertValidExpirationDate: aCreditCard withCurrent: currentDate.
	merchant debit: total from: aCreditCard.
	
	^total
	
	! !



!Cashier methodsFor: 'initialize' stamp: 'pfu 11/8/2024 17:38:00'!
initializeWith: aMerchant 
	merchant := aMerchant! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'pfu 11/8/2024 17:38:16'!
with: aMerchant
	^self new initializeWith: aMerchant! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'date' stamp: 'pfu 11/5/2024 21:08:06'!
expiresBefore: anExpirationDate
	^expiration < anExpirationDate ! !


!CreditCard methodsFor: 'number' stamp: 'pfu 11/5/2024 21:00:47'!
hasNumber: aCreditCardNumber
	^number = aCreditCardNumber ! !


!CreditCard methodsFor: 'initialization' stamp: 'pfu 11/8/2024 17:54:26'!
initializeFor: aPerson with: aNumber expiringOn: anExpirationMonthOfYear
	name := aPerson.
	number := aNumber.
	expiration := anExpirationMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'pfu 11/5/2024 20:11:42'!
for: aPerson with: aNumber expiringOn: anExpirationDate
	self assertNumberHas16Digits: aNumber.
	^ self new initializeFor: aPerson with: aNumber expiringOn: anExpirationDate.! !


!CreditCard class methodsFor: 'asserts' stamp: 'pfu 11/5/2024 20:19:32'!
assertNumberHas16Digits: aNumber
	(aNumber asString size = 16) ifFalse: [self error: 'Credit card number should have 16 digits'].! !


!classDefinition: #RESTAdapter category: #TusLibros!
Object subclass: #RESTAdapter
	instanceVariableNames: 'validator idToCart priceList currentId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTAdapter methodsFor: 'ids' stamp: 'pfu 11/8/2024 20:26:39'!
createNewId
	currentId := currentId + 1.
	^currentId! !


!RESTAdapter methodsFor: 'initialization' stamp: 'pfu 11/8/2024 20:28:38'!
validatingWith: aCredentialValidator priceList: aPriceList 
	validator := aCredentialValidator.
	priceList := aPriceList.
	currentId := 0.
	idToCart  := Dictionary new.! !


!RESTAdapter methodsFor: 'cart' stamp: 'pfu 11/8/2024 20:37:02'!
addToCart: cartId amount: amountOfBooks of: aBook
	| cart |
	cart := idToCart at: cartId.
	
	cart addBook: aBook amount: amountOfBooks.
	 
	! !

!RESTAdapter methodsFor: 'cart' stamp: 'pfu 11/8/2024 20:27:14'!
createCartForUser: aUserId withPassword: aPassword
	| cart id |
	validator validateUser: aUserId with: aPassword.
	
	cart := Cart acceptingItemsFrom: priceList.
	id := self createNewId.
	idToCart at: id put: cart.
	
	^id! !

!RESTAdapter methodsFor: 'cart' stamp: 'pfu 11/8/2024 20:30:27'!
listCart: aCartId
	| cart |
	cart := idToCart at: aCartId.
	^ cart listYourself.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTAdapter class' category: #TusLibros!
RESTAdapter class
	instanceVariableNames: ''!

!RESTAdapter class methodsFor: 'instance creation' stamp: 'pfu 11/8/2024 20:23:03'!
validatingWith: credentialValidator priceList: priceList 
	^self new validatingWith: credentialValidator priceList: priceList.! !


!classDefinition: #SetupTestObjectsFactory category: #TusLibros!
Object subclass: #SetupTestObjectsFactory
	instanceVariableNames: 'robbed empty numberOfReceivedRequests stubMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SetupTestObjectsFactory methodsFor: 'credit cards' stamp: 'pfu 11/8/2024 18:19:25'!
emptyCreditCard

	^ CreditCard for: 'pedro' with: 1000000000000000 expiringOn: GregorianMonthOfYear current next.! !

!SetupTestObjectsFactory methodsFor: 'credit cards' stamp: 'pfu 11/8/2024 18:19:34'!
expiredCreditCard

	^ CreditCard for: 'pedro' with: 4704550090900872 expiringOn: GregorianMonthOfYear current previous.! !

!SetupTestObjectsFactory methodsFor: 'credit cards' stamp: 'pfu 11/8/2024 18:20:00'!
robbedCreditCard

	^ CreditCard for: 'pedro' with: 9999999999999999 expiringOn: GregorianMonthOfYear current next.! !

!SetupTestObjectsFactory methodsFor: 'credit cards' stamp: 'pfu 11/8/2024 18:29:15'!
stubMerchantProcessor
	^stubMerchantProcessor .! !

!SetupTestObjectsFactory methodsFor: 'credit cards' stamp: 'pfu 11/8/2024 18:20:21'!
validCreditCard

	^ CreditCard for: 'pedro' with: 4704550090900872 expiringOn: GregorianMonthOfYear current next.! !


!SetupTestObjectsFactory methodsFor: 'dates' stamp: 'pfu 11/8/2024 18:24:01'!
today
	^GregorianMonthOfYear current.! !


!SetupTestObjectsFactory methodsFor: 'catalogs' stamp: 'pfu 11/8/2024 20:46:38'!
book1
	^'1'! !

!SetupTestObjectsFactory methodsFor: 'catalogs' stamp: 'pfu 11/8/2024 20:46:41'!
book2
	^'2'! !

!SetupTestObjectsFactory methodsFor: 'catalogs' stamp: 'pfu 11/8/2024 18:19:47'!
priceList
	| aPriceList |
	aPriceList := Dictionary new.
	aPriceList at: '1' put: 25.
	aPriceList at: '2' put: 50.
	aPriceList at: '3' put: 75.
	^aPriceList.! !


!SetupTestObjectsFactory methodsFor: 'credentials' stamp: 'pfu 11/8/2024 20:05:19'!
credentialValidator
	^ StubCredentialValidator new.! !


!SetupTestObjectsFactory methodsFor: 'initialization' stamp: 'pfu 11/8/2024 18:29:24'!
initialize
	super initialize.
	stubMerchantProcessor := 	StubMerchantProcessor robbed: (Set with: 9999999999999999) empty: (Set with: 1000000000000000).! !


!classDefinition: #StubCredentialValidator category: #TusLibros!
Object subclass: #StubCredentialValidator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StubCredentialValidator methodsFor: 'validation' stamp: 'pfu 11/8/2024 20:08:14'!
validateUser: aUserId with: aPassword
	(aUserId = 'pedro' and: [aPassword ~= '123']) ifTrue: [self error: self class invalidCredentials]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StubCredentialValidator class' category: #TusLibros!
StubCredentialValidator class
	instanceVariableNames: ''!

!StubCredentialValidator class methodsFor: 'errors' stamp: 'pfu 11/8/2024 20:08:29'!
invalidCredentials
	^'Invalid Credentials'! !


!classDefinition: #StubMerchantProcessor category: #TusLibros!
Object subclass: #StubMerchantProcessor
	instanceVariableNames: 'robbed empty numberOfReceivedRequests'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StubMerchantProcessor methodsFor: 'initialize' stamp: 'pfu 11/6/2024 11:35:31'!
initializeRobbed: aRobbedCreditCardSet empty: anEmptyCreditCardSet 
	robbed := aRobbedCreditCardSet.
	empty := anEmptyCreditCardSet.
	numberOfReceivedRequests := 0.! !


!StubMerchantProcessor methodsFor: 'validation' stamp: 'pfu 11/6/2024 11:29:59'!
assertIsValid: aCreditCard 
	(robbed anySatisfy: [:robbedNumber | aCreditCard hasNumber: robbedNumber]) ifTrue: [self error: 'Robbed credit card'].
	
	(empty anySatisfy: [:emptyCardNumber | aCreditCard hasNumber: emptyCardNumber]) ifTrue: [self error: 'Empty credit card'].
! !

!StubMerchantProcessor methodsFor: 'validation' stamp: 'pfu 11/6/2024 11:35:49'!
debit: anAmountToDebit from: aCreditCard
	numberOfReceivedRequests := numberOfReceivedRequests + 1.
	self assertIsValid: aCreditCard.
	! !


!StubMerchantProcessor methodsFor: 'tests' stamp: 'pfu 11/6/2024 11:36:04'!
requestsReceived
	^numberOfReceivedRequests ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StubMerchantProcessor class' category: #TusLibros!
StubMerchantProcessor class
	instanceVariableNames: ''!

!StubMerchantProcessor class methodsFor: 'instance creation' stamp: 'pfu 11/5/2024 20:56:07'!
invalids: anInvalidCreditCardSet
	^self new initializeWithInvalids: anInvalidCreditCardSet! !

!StubMerchantProcessor class methodsFor: 'instance creation' stamp: 'pfu 11/6/2024 11:28:51'!
robbed: aRobbedCreditCardSet empty: anEmptyCreditCardSet
	^self new initializeRobbed: aRobbedCreditCardSet empty: anEmptyCreditCardSet ! !
