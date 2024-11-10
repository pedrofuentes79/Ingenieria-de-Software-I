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

!CartTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 20:29:43'!
test03AddingMultipleBooksAffectPurchaseListSize
	|cart |
	"esta demas"
	cart := Cart acceptingItemsFrom: factory priceList.

	
	cart addBook: '1' amount: 1.
	cart addBook: '2' amount: 5.
	
	self assert: cart amountOfItems equals: 6.! !

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

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 21:58:50'!
setupCart

	^ Cart acceptingItemsFrom: factory priceList! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 21:56:44'!
setupCashierFor: aCart

	^ Cashier with: factory stubMerchantProcessor savingOn: factory salesBook for: aCart! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:01:05'!
test01CannotCheckoutEmptyCart
	|cart cashier|
	cart := self setupCart.
	cashier := self setupCashierFor: cart.
	
	self should: [cashier checkoutWith: factory validCreditCard onDate: factory today.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: cashier emptyCartError].
	
	! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:01:21'!
test02CashierCheckoutsCorrectPriceForCart
	|cart cashier sale |
	cart := self setupCart.
	cart addBook: '1' amount: 2.
	
	cashier := self setupCashierFor: cart.
	
	sale := cashier checkoutWith: factory validCreditCard onDate: factory today.
	
	self assert: sale total equals: 50.
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:02:19'!
test03CashierCheckoutsCorrectPriceForCartWithDifferentItems
	|cart cashier sale |
	cart := self setupCart.
	cart addBook: '1' amount: 2.
	cart addBook: '3' amount: 5.
	
	cashier := self setupCashierFor: cart.
	
	sale := cashier checkoutWith: factory validCreditCard onDate: factory today.
	
	self assert: sale total equals: 425.
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:02:23'!
test04CashierCantCheckoutWithExpiredCard
	|cart cashier |
	cart := self setupCart.
	cart addBook: '1' amount: 2.
	cashier := self setupCashierFor: cart.
	
	self should: [cashier checkoutWith: factory expiredCreditCard onDate: factory today]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error |
		self assert: error messageText equals: 'Expired credit card'.
		self assert: cart amountOfItems equals: 2.
		self assert: factory stubMerchantProcessor requestsReceived equals: 0.
		]
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:02:26'!
test05CashierCantCheckoutWithStolenCard
	|cart cashier  |
	cart := self setupCart.
	cart addBook: '1' amount: 2.
	cashier := self setupCashierFor: cart.

	
	self should: [cashier checkoutWith: factory robbedCreditCard onDate: factory today]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'Robbed credit card'.
		self assert: cart amountOfItems equals: 2.
		self assert: factory stubMerchantProcessor requestsReceived equals: 1.
		]
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:02:29'!
test06CashierCantCheckoutWithEmptyCard
	|cart cashier |
	cart := self setupCart.
	cart addBook: '1' amount: 2.
	cashier := self setupCashierFor: cart.	
	
	self should: [cashier checkoutWith: factory emptyCreditCard onDate: factory today]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error |
		self assert: error messageText equals: 'Empty credit card'.
		self assert: cart amountOfItems equals: 2.
		self assert: factory stubMerchantProcessor requestsReceived equals: 1.

		]
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'PFU 11/9/2024 22:02:51'!
test07CashierCheckoutsWithValidCard
	|cart cashier sale |
	cart := self setupCart.
	cashier := self setupCashierFor: cart.	
	
	cart addBook: '1' amount: 2.

	sale := cashier checkoutWith: factory validCreditCard onDate: factory today.
	
	self assert: sale total equals: 50.
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

!RESTAdapterTest methodsFor: 'support' stamp: 'PFU 11/9/2024 18:18:33'!
setUpREST
	^ RESTAdapter 
		validatingWith: factory credentialValidator 
		priceList: factory priceList 
		merchant: factory stubMerchantProcessor 
		onDate: factory today 
		salesBook: factory salesBook.! !


!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 09:40:58'!
test01CreateCartWithInvalidCredentials
	|rest  | 
	rest := self setUpREST.
	
	self should: [rest createCartForUser: 'pedro' withPassword: 'WRONGPASSWORD']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: StubCredentialValidator invalidCredentials.
		
]! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 09:41:21'!
test02CartCreatedWithValidCredentialsIsEmpty
	|rest  cartId | 
	rest := self setUpREST.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	
	self assertRest: rest emptyCart: cartId.
! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 09:41:24'!
test03AddingToCart
	|rest  cartId book1 book2 | 
	rest := self setUpREST.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	book1 := factory book1.
	book2 := factory book2.

	rest addToCart: cartId amount: 3 of: book1.
	rest addToCart: cartId amount: 3 of: book2.
	
	self assert: (rest listCart: cartId) equals: '|',book1,'|3|',book2, '|3'.! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 09:42:31'!
test04InvalidAddToCart
	|rest  cartId book1 | 
	rest := self setUpREST.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	book1 := factory book1.
	
	self should: [rest addToCart: cartId amount:(-1) of: book1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assertRest: rest emptyCart: cartId.
		]! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 09:48:18'!
test05InvalidCartCantBeListed
	|rest  cartId | 
	rest := self setUpREST.
	cartId := 929292929. "an invalid id"
	
	self should: [rest listCart: cartId]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: rest invalidCartIdError.
		]! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 10:01:09'!
test06CannotCheckoutEmptyCart
	|rest cartId creditCard | 
	rest := self setUpREST.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	creditCard := factory validCreditCard.
	
	self should: [rest checkoutCart: cartId for: creditCard owner withCard: creditCard number expiringOn: creditCard expiration ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: rest emptyCartError.
		]! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 21:51:05'!
test07CheckoutAValidCart
	|rest cartId creditCard transactionId | 
	rest := self setUpREST.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	creditCard := factory validCreditCard.
	rest addToCart: cartId amount: 59 of: factory book1.
	
	transactionId := rest checkoutCart: cartId for: creditCard owner withCard: creditCard number expiringOn: creditCard expiration.
	
	self assert: (rest totalFromTransaction: transactionId) equals: 59 * 25.! !

!RESTAdapterTest methodsFor: 'tests' stamp: 'PFU 11/9/2024 21:50:13'!
test08ListPurchases
	|rest cartId response | 
	rest := self setUpREST.
	cartId := rest createCartForUser: 'pedro' withPassword: '123'.
	rest addToCart: cartId amount: 59 of: factory book1.
	
	response := rest listPurchasesFor: 'pedro' withPassword: '123'.
	

	self assert: response equals: ((rest getCartWithId: cartId) listYourself , '|59').! !


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


!Cart methodsFor: 'testing' stamp: 'PFU 11/9/2024 20:29:43'!
amountOfItems
	^books size! !

!Cart methodsFor: 'testing' stamp: 'pfu 11/2/2024 09:04:13'!
isEmpty
	^books size = 0.! !


!Cart methodsFor: 'books' stamp: 'PFU 11/9/2024 20:18:19'!
addBook: anISBN amount: anAmount 
	self assertValidAmountOfBooksToAdd: anAmount.
	self assertValidISBN: anISBN.
	
	books add: anISBN withOccurrences: anAmount.! !

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

!Cart methodsFor: 'asserts' stamp: 'PFU 11/9/2024 20:29:43'!
purchaseList
	^ self listYourself, '|', (self amountOfItems asString).! !

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
	instanceVariableNames: 'merchant salesBook cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'asserts' stamp: 'PFU 11/9/2024 21:59:59'!
assertCartNotEmpty
	cart isEmpty ifTrue:[self error: self emptyCartError].! !

!Cashier methodsFor: 'asserts' stamp: 'PFU 11/9/2024 09:59:19'!
assertCartNotEmpty: aCart
	aCart isEmpty ifTrue:[self error: self emptyCartError].! !

!Cashier methodsFor: 'asserts' stamp: 'pfu 11/8/2024 17:57:03'!
assertValidExpirationDate: aCreditCard withCurrent: aCurrentDate
	(aCreditCard expiresBefore: aCurrentDate) ifTrue: [self error: 'Expired credit card']
! !


!Cashier methodsFor: 'checkout' stamp: 'PFU 11/9/2024 19:01:09'!
checkout: aCart with: aCreditCard onDate: currentDate
	| total |
	self assertCartNotEmpty: aCart.
	total := aCart total.

	self assertValidExpirationDate: aCreditCard withCurrent: currentDate.	
	merchant debit: total from: aCreditCard.
	
	
	^salesBook register: total from: aCreditCard owner onCart: aCart.
	
	! !

!Cashier methodsFor: 'checkout' stamp: 'PFU 11/9/2024 22:00:49'!
checkoutWith: aCreditCard onDate: currentDate
	
	self assertCartNotEmpty.

	self assertValidExpirationDate: aCreditCard withCurrent: currentDate.	
	merchant debit: cart total from: aCreditCard.
	
	
	^salesBook register: cart total from: aCreditCard owner onCart: cart.
	
	! !


!Cashier methodsFor: 'errors' stamp: 'PFU 11/9/2024 09:59:45'!
emptyCartError
	^'Cannot checkout empty cart'! !


!Cashier methodsFor: 'initialize' stamp: 'PFU 11/9/2024 21:55:38'!
initializeWith: aMerchant savingOn: aSalesBook for: aCart   
	merchant := aMerchant.
	salesBook := aSalesBook.
	cart := aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'PFU 11/9/2024 22:02:02'!
with: aMerchant savingOn: aSalesBook for: aCart  
	^self new initializeWith: aMerchant savingOn: aSalesBook for: aCart! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'date' stamp: 'pfu 11/5/2024 21:08:06'!
expiresBefore: anExpirationDate
	^expiration < anExpirationDate ! !


!CreditCard methodsFor: 'number' stamp: 'pfu 11/5/2024 21:00:47'!
hasNumber: aCreditCardNumber
	^number = aCreditCardNumber ! !


!CreditCard methodsFor: 'initialization' stamp: 'PFU 11/9/2024 09:56:01'!
initializeFor: aPerson with: aNumber expiringOn: anExpirationMonthOfYear
	owner := aPerson.
	number := aNumber.
	expiration := anExpirationMonthOfYear.! !


!CreditCard methodsFor: 'getters' stamp: 'PFU 11/9/2024 09:56:16'!
expiration
	^expiration! !

!CreditCard methodsFor: 'getters' stamp: 'PFU 11/9/2024 09:56:12'!
number
	^number! !

!CreditCard methodsFor: 'getters' stamp: 'PFU 11/9/2024 09:56:05'!
owner
	^owner! !

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
	instanceVariableNames: 'validator idToCart priceList currentCartId today salesBook merchant userIdToCart transactionIdToSale currentTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTAdapter methodsFor: 'ids' stamp: 'PFU 11/9/2024 09:46:11'!
getCartWithId: aCartId
	^ idToCart at: aCartId ifAbsent: [self error: self invalidCartIdError].! !

!RESTAdapter methodsFor: 'ids' stamp: 'PFU 11/9/2024 20:26:37'!
getCartsFromUser: aUserId
	^ userIdToCart at: aUserId ifAbsent: [self error: self noCartsForUserError].! !

!RESTAdapter methodsFor: 'ids' stamp: 'PFU 11/9/2024 19:17:19'!
mapUserId: aUserId toCart: aCart

	^ (userIdToCart at: aUserId ifAbsentPut:[Set new]) add: aCart! !

!RESTAdapter methodsFor: 'ids' stamp: 'PFU 11/9/2024 20:37:20'!
newCartIdFor: aCart
	| cartId |
	cartId := currentCartId.
	idToCart at: cartId put: aCart.
	currentCartId := currentCartId + 1.
	^ cartId.! !

!RESTAdapter methodsFor: 'ids' stamp: 'PFU 11/9/2024 19:31:09'!
newTransactionIdFor: aSale
	currentTransactionId := currentTransactionId + 1.
	transactionIdToSale at: currentTransactionId put: aSale.
	^ currentTransactionId 
	! !

!RESTAdapter methodsFor: 'ids' stamp: 'PFU 11/9/2024 20:38:22'!
totalFromTransaction: transactionId 
	^((transactionIdToSale at: transactionId) total)! !


!RESTAdapter methodsFor: 'initialization' stamp: 'PFU 11/9/2024 19:32:17'!
validatingWith: aCredentialValidator priceList: aPriceList merchant: aMerchantProcessor onDate: currentDate salesBook: aSalesBook
	validator := aCredentialValidator.
	priceList := aPriceList.
	currentCartId := 0.
	currentTransactionId := 0.
	transactionIdToSale := Dictionary new.
	idToCart  := Dictionary new.
	userIdToCart := Dictionary new.
	salesBook := aSalesBook.
	today := currentDate.
	merchant := aMerchantProcessor.
	
	
! !


!RESTAdapter methodsFor: 'cart' stamp: 'PFU 11/9/2024 09:46:25'!
addToCart: aCartId amount: amountOfBooks of: aBook
	| cart |
	cart := self getCartWithId: aCartId.
	
	cart addBook: aBook amount: amountOfBooks.
	 
	! !

!RESTAdapter methodsFor: 'cart' stamp: 'PFU 11/9/2024 19:20:05'!
checkoutCart: cartId for: anOwner withCard: aCreditCardNumber expiringOn: anExpirationYearMonth
	| cart card cashier transactionId sale |
	cart := self getCartWithId: cartId.
	card := CreditCard for: anOwner with: aCreditCardNumber expiringOn: anExpirationYearMonth.
	cashier := Cashier with: merchant savingOn: salesBook.
	
	sale := cashier checkout: cart with: card onDate: today.	
	transactionId := self newTransactionIdFor: sale.
	
	^transactionId
	
	
	! !

!RESTAdapter methodsFor: 'cart' stamp: 'PFU 11/9/2024 20:36:09'!
createCartForUser: aUserId withPassword: aPassword
	| cart cartId |
	validator validateUser: aUserId with: aPassword.
	
	cart := Cart acceptingItemsFrom: priceList.
	
	cartId := self newCartIdFor: cart.
	
	self mapUserId: aUserId toCart: cart.
	
	^cartId! !

!RESTAdapter methodsFor: 'cart' stamp: 'PFU 11/9/2024 09:45:40'!
listCart: aCartId
	| cart |	
	cart := self getCartWithId: aCartId.
	^ cart listYourself.! !

!RESTAdapter methodsFor: 'cart' stamp: 'PFU 11/9/2024 20:31:16'!
listPurchasesFor: aUserId withPassword: aPassword
	| carts totalItems response |
	validator validateUser: aUserId with: aPassword.
	
	carts := self getCartsFromUser: aUserId.
	
	totalItems := 0.
	response := String new.
	
	carts do: [:aCart | 
		totalItems := totalItems + aCart amountOfItems.
		response := response, aCart listYourself.
	].
	
	response := response, '|', totalItems asString.
	^ response
	
	! !


!RESTAdapter methodsFor: 'errors' stamp: 'PFU 11/9/2024 10:01:25'!
emptyCartError
	^'Cannot checkout empty cart'! !

!RESTAdapter methodsFor: 'errors' stamp: 'PFU 11/9/2024 09:44:28'!
invalidCartIdError
	^ 'Invalid Cart Id'! !

!RESTAdapter methodsFor: 'errors' stamp: 'PFU 11/9/2024 20:26:48'!
noCartsForUserError
	^ 'This user does not have any carts'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTAdapter class' category: #TusLibros!
RESTAdapter class
	instanceVariableNames: ''!

!RESTAdapter class methodsFor: 'instance creation' stamp: 'PFU 11/9/2024 18:13:10'!
validatingWith: credentialValidator priceList: priceList merchant: merchant onDate: onDate salesBook: salesBook    
	^self new validatingWith: credentialValidator priceList: priceList merchant: merchant onDate: onDate salesBook: salesBook.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'name cart total clientName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'getters' stamp: 'PFU 11/9/2024 19:23:50'!
total
	^total! !


!Sale methodsFor: 'initialization' stamp: 'PFU 11/9/2024 19:23:11'!
initializeFrom: aClientName with: aCart total: aTotal 
	clientName := aClientName.
	cart := aCart.
	total := aTotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'PFU 11/9/2024 19:22:57'!
from: aClientName with: aCart total: aTotal 
	^self new initializeFrom: aClientName with: aCart total: aTotal ! !


!classDefinition: #SalesBook category: #TusLibros!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!SalesBook methodsFor: 'initialization' stamp: 'PFU 11/9/2024 20:38:51'!
initialize
	super initialize.
	sales := OrderedCollection new.
! !

!SalesBook methodsFor: 'initialization' stamp: 'PFU 11/9/2024 20:41:24'!
register: total from: aUsername onCart: aCart
	|sale|
	sale := Sale from: aUsername with: aCart total: total.
	sales add: sale.
	^sale.
! !


!classDefinition: #SetupTestObjectsFactory category: #TusLibros!
Object subclass: #SetupTestObjectsFactory
	instanceVariableNames: 'robbed empty numberOfReceivedRequests stubMerchantProcessor salesBook'
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

!SetupTestObjectsFactory methodsFor: 'credit cards' stamp: 'PFU 11/9/2024 19:00:21'!
salesBook
	^salesBook! !

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


!SetupTestObjectsFactory methodsFor: 'initialization' stamp: 'PFU 11/9/2024 18:59:43'!
initialize
	super initialize.
	stubMerchantProcessor := 	StubMerchantProcessor robbed: (Set with: 9999999999999999) empty: (Set with: 1000000000000000).
	salesBook :=  SalesBook new.! !


!classDefinition: #StubCredentialValidator category: #TusLibros!
Object subclass: #StubCredentialValidator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StubCredentialValidator methodsFor: 'validation' stamp: 'PFU 11/9/2024 09:39:59'!
validateUser: aUserId with: aPassword
	(aUserId = 'pedro' and: [aPassword ~= '123']) ifTrue: [self error: self class invalidCredentials].! !

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
