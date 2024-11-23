!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:18:26'!
test01AccountReportWithDeposit
	"este test no es el mas facil. Deberia ser uno con una cuenta sin transacciones, que devuelva balance=0"
	|a1 report|
	a1 := ReceptiveAccount new.
	Deposit register: 500 on: a1.

	report := AccountSummary for: a1.
	
	self assert: (report text) equals: 
'Depósito por 500.
Balance = 500'! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:20:54'!
test02AccountReportWithManyTransactions
	"quizas aca no iba el zero, one, many?
	podria tener un test por withdraw, otro por depositLeg, otro por withdrawLeg"
	|a1 report a2|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	Deposit register: 500 on: a1.
	Withdraw register: 159 on: a1.
	Transfer from: a1 to: a2 amount: 123.
	Deposit register: 120 on: a1.
	Transfer from: a2 to: a1 amount: 1.

	report := AccountSummary for: a1.
	
	self assert: (report text) equals: 
	
'Depósito por 500.
Extracción por 159.
Salida por transferencia de 123.
Depósito por 120.
Entrada por transferencia de 1.
Balance = 339'! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 10/29/2024 21:31:29'!
test03AccountReportDoesntKnowOfOtherTransactions
	|a1 a2 a3 report|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	a3 := ReceptiveAccount new.

	Deposit register: 150 on: a1.
	Transfer from: a2 to: a3 amount: 100000.
	Withdraw register: 200 on: a2.
	Deposit register: 200 on: a3.

	report := AccountSummary for: a1.
	self assert: (report text) equals: 
	
'Depósito por 150.
Balance = 150'

! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:52:41'!
test04PortfolioReportWithNoAccounts
	|john report |
	john := Portfolio named: 'John'.
	
	report := PortfolioReporter for: john.
	
	self assert: (report text) equals:
'John'
! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:52:41'!
test05PortfolioReportWithAccounts
	|john report junior1 junior2 |
	junior1 := ReceptiveAccount named: 'Junior1'.
	junior2 := ReceptiveAccount named: 'Junior2'.
	john := Portfolio named: 'John' with: junior1 with: junior2.
	
	report := PortfolioReporter for: john.
	
	self assert: (report text) equals:
'John
	Junior1
	Junior2'
! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:52:41'!
test06PortfolioReportWithPortfolios
	|john report junior juniorJunior |
	juniorJunior := ReceptiveAccount named: 'Junior Junior'.
	junior := Portfolio named: 'Junior' with: juniorJunior.
	john := Portfolio named: 'John' with: junior.
	
	report := PortfolioReporter for: john.
	
	self assert: (report text) equals:
'John
	Junior
		Junior Junior'
! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:52:41'!
test07PortfolioReportWithPortfoliosAndAccounts
	|john report junior juniorJunior junior2 |
	john := Portfolio named: 'John'.
	junior := Portfolio named: 'Junior1'.
	juniorJunior := ReceptiveAccount named: 'Junior Junior'.
	junior2 := ReceptiveAccount named: 'Junior2'.
	
	john add: junior.
	junior add: juniorJunior.
	john add: junior2.
	
	
	report := PortfolioReporter for: john.
	
	self assert: (report text) equals:
'John
	Junior1
		Junior Junior
	Junior2'
! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:52:47'!
test08SpecialPortfolioReportWithOnePortfolioOneAccount
	|gago roman report chiqui|
	gago := ReceptiveAccount named: 'Cuenta de Gago'.
	chiqui := ReceptiveAccount named: 'Cuenta del Chiqui Tapia'.
	roman := Portfolio named: 'Portfolio de Roman' with: gago.	
	Transfer from: gago to: chiqui amount:100.
	
	report := SpecialPortfolioReporter for: roman.
	
	self assert: (report text) equals:
'Portfolio de Roman
	Cuenta de Gago
		Salida por transferencia de 100.
		Balance = -100'
! !

!ReportTest methodsFor: 'reports' stamp: 'PUF 11/1/2024 20:52:47'!
test09SpecialPortfolioReportWithOnePortfolioNoAccounts
	|roman report |
	roman := Portfolio named: 'Portfolio de Roman'.
	
	report := SpecialPortfolioReporter for: roman.
	
	self assert: (report text) equals:
'Portfolio de Roman'
! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 10/27/2024 19:24:10'!
test01TransferAffectsBalance
	|a1 a2 t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	Deposit register: 500 on: a1.
	
	t := Transfer from: a1 to: a2 amount: 100.
	
	self assert: a2 balance equals: 100.
	self assert: a1 balance equals: 400.! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 10/27/2024 19:24:09'!
test02InvalidTransferAmount
	|a1 a2 |
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	
	
	self should: [Transfer from: a1 to: a2  amount: -25..]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Invalid amount']
	! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 10/27/2024 19:24:09'!
test03TransferIsRegisteredInBothAccounts
	|a1 a2 t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	Deposit register: 500 on: a1.
	
	t := Transfer from: a1 to: a2 amount: 100.
	
	self assert: (a1 hasRegistered: t withdrawLeg).
	self assert: (a2 hasRegistered: t depositLeg).! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 10/27/2024 19:24:09'!
test04AccountsDontRegisterTheOtherLeg
	|a1 a2 t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	Deposit register: 500 on: a1.
	
	t := Transfer from: a1 to: a2 amount: 100.
	
	self deny: (a1 hasRegistered: t depositLeg).
	self deny: (a2 hasRegistered: t withdrawLeg).
! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 10/27/2024 19:24:09'!
test05AccountsKnowTransferNet
	|a1 a2 t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	Deposit register: 100 on: a1.
	
	t := Transfer from: a1 to: a2 amount: 50.
	t := Transfer from: a2 to: a1 amount: 10.
	
	self assert: a1 transferNet equals: -40.
	self assert: a2 transferNet equals: 40.! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 11/1/2024 20:23:25'!
test06ManyAccountsKnowTransferNet
	|a1 a2 a3 a4 t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	a3 := ReceptiveAccount new.
	a4 := ReceptiveAccount new.
	Deposit register: 100 on: a1.
	Deposit register: 200 on: a2.
	Deposit register: 300 on: a3.
	Deposit register: 400 on: a4.
	
	t := Transfer from: a4 to: a1 amount: 150.
	t := Transfer from: a3 to: a2 amount: 50.
	t := Transfer from: a1 to: a2 amount: 100.
	t := Transfer from: a2 to: a4 amount: 20.
	
	self assert: a1 transferNet equals: 50.
	self assert: a2 transferNet equals: 130.
	self assert: a3 transferNet equals: -50.
	self assert: a4 transferNet equals: -130.! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 11/1/2024 19:57:19'!
test07PortfoliosKnowTransferNet
	|a1 a2 p t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	p := Portfolio new.
	p add: a1.

	t := Transfer from: a1 to: a2 amount: 100.
	
	self assert: p transferNet equals: -100.! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 11/1/2024 19:56:32'!
test08CanGoFromDepositLegToWithdrawLeg
	"este test se me paso... no se me ocurrio en el momento"
	|a1 a2 t|
	a1 := ReceptiveAccount new.
	a2 := ReceptiveAccount new.
	
	t := Transfer from: a1 to: a2 amount: 100.
	
	self assert: t withdrawLeg equals: t depositLeg transfer withdrawLeg.! !

!TransferTest methodsFor: 'balance from transfers' stamp: 'PUF 11/1/2024 20:00:23'!
test09CannotTransferBetweenSameAccounts
	|a1 |
	a1 := ReceptiveAccount new.

	self should: [Transfer from: a1 to: a1 amount: 100]
	raise: Error
	withExceptionDo: [:e | self assert: e messageText equals: 'Cannot transfer between same accounts']
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'PUF 10/27/2024 19:37:38'!
initializeWithName: anAccountName
	name := anAccountName.! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'PUF 10/27/2024 19:51:10'!
name
	^name! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'PUF 10/27/2024 19:37:15'!
named: anAccountName
	^self new initializeWithName: anAccountName! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'balance' stamp: 'PUF 10/26/2024 10:39:05'!
transferNet
	^accounts sum: [ :anAccount | anAccount transferNet ] ifEmpty: [ 0 ]! !



!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'accounts management' stamp: 'PUF 11/1/2024 21:35:03'!
acceptPortfolioReport: aReport
	accounts do:[:account| (account accept: aReport).]! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'reports' stamp: 'PUF 11/1/2024 21:29:41'!
accept: aReport
	^aReport visitPortfolio: self.! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PUF 10/27/2024 20:18:59'!
named: aName with: anAccount
	|portfolio|
	portfolio := self new initializeWithName: aName.
	portfolio add: anAccount.	
	^portfolio.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PUF 10/27/2024 20:17:30'!
named: aName with: anAccount with: anotherAccount
	|portfolio|
	portfolio := self new initializeWithName: aName.
	portfolio add: anAccount.	
	portfolio add: anotherAccount.
	^portfolio.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'PUF 11/1/2024 18:00:04'!
transactions 

	^ transactions copy
	! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'PUF 11/1/2024 21:28:56'!
visitTransactionsWith: aVisitor
	^(transactions do: [:transaction| (transaction accept: aVisitor)]).
! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:31:19'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PUF 10/25/2024 20:14:56'!
putTransactionsIn: aTransactionCollection
	aTransactionCollection addAll: transactions.
	^aTransactionCollection.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PUF 10/26/2024 11:13:10'!
transferNet
	^transactions inject:0 into: [:currentNet :aTransaction | aTransaction affectTransferNet: currentNet].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'PUF 10/26/2024 09:39:36'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'PUF 11/1/2024 21:45:52'!
accept: aVisitor
	^aVisitor visitReceptiveAccount: self.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'PUF 11/1/2024 20:12:13'!
value 
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'PUF 10/15/2024 21:06:21'!
initializeFor: aValue

	value := aValue! !


!AccountTransaction methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:42:55'!
affectBalance: aBalance
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:59:00'!
affectTransferNet: aTransferNet
	^aTransferNet! !


!AccountTransaction methodsFor: 'visitors' stamp: 'PUF 11/1/2024 21:26:42'!
accept: aVisitor
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'PUF 10/15/2024 20:32:03'!
for: aValue
	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'PUF 10/26/2024 09:24:49'!
register: aValue on: account
	| transaction |
	transaction := self for: aValue.
	
	account register: transaction.
	
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'value' stamp: 'PUF 10/15/2024 21:38:59'!
modifyBalance: aBalanceToModify
	^aBalanceToModify + value.! !

!Deposit methodsFor: 'value' stamp: 'PUF 11/1/2024 20:12:22'!
value
	^ value! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:26:42'!
accept: aReport
	^aReport visitDeposit: self.! !


!Deposit methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:31:12'!
affectBalance: aBalance
	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:32:06'!
affectBalance: aBalance
	self subclassResponsibility ! !

!TransferLeg methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:58:50'!
affectTransferNet: aTransferNet
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'value' stamp: 'PUF 11/1/2024 19:53:38'!
transfer
	^transfer! !

!TransferLeg methodsFor: 'value' stamp: 'PUF 10/26/2024 10:03:43'!
value
	^transfer value! !


!TransferLeg methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:26:42'!
accept: aReport
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'initialization' stamp: 'PUF 10/26/2024 09:28:40'!
initializeWithTransfer: aTransfer
	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'PUF 10/26/2024 09:29:15'!
register: aValue on: account
	self shouldNotImplement ! !

!TransferLeg class methodsFor: 'instance creation' stamp: 'PUF 10/26/2024 09:29:28'!
registerTransfer: aTransfer on: anAccount 
	| transaction |
	transaction := self new initializeWithTransfer: aTransfer.
	
	anAccount register: transaction.
	
	^ transaction! !


!classDefinition: #DepositLeg category: #'Portfolio-Solucion'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!
!DepositLeg commentStamp: 'PUF 10/26/2024 09:49:50' prior: 0!
This is the leg that corresponds to the RECEIVER!


!DepositLeg methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:26:42'!
accept: aReport
	^aReport visitDepositLeg: self.! !


!DepositLeg methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:30:37'!
affectBalance: aBalance
	^ aBalance + transfer value.! !

!DepositLeg methodsFor: 'balance' stamp: 'PUF 10/26/2024 10:03:25'!
affectTransferNet: aTransferNet
	^aTransferNet + self value
	! !


!classDefinition: #WithdrawLeg category: #'Portfolio-Solucion'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!
!WithdrawLeg commentStamp: 'PUF 10/26/2024 09:49:46' prior: 0!
This is the leg that corresponds to the SENDER!


!WithdrawLeg methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:26:42'!
accept: aReport
	^aReport visitWithdrawLeg: self.! !


!WithdrawLeg methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:31:43'!
affectBalance: aBalance
	^ aBalance - transfer value.! !

!WithdrawLeg methodsFor: 'balance' stamp: 'PUF 10/26/2024 10:03:56'!
affectTransferNet: aTransferNet
	^aTransferNet - self value
	! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:26:42'!
accept: aReport
	^aReport visitWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'PUF 10/26/2024 09:31:52'!
affectBalance: aBalance
	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountVisitor category: #'Portfolio-Solucion'!
Object subclass: #AccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountVisitor class' category: #'Portfolio-Solucion'!
AccountVisitor class
	instanceVariableNames: ''!

!AccountVisitor class methodsFor: 'instance creation' stamp: 'PUF 11/1/2024 21:04:50'!
for: anAccount
	^self new visit: anAccount! !


!classDefinition: #PortfolioReporter category: #'Portfolio-Solucion'!
AccountVisitor subclass: #PortfolioReporter
	instanceVariableNames: 'text'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReporter methodsFor: 'text' stamp: 'PUF 11/1/2024 21:10:22'!
addTabsToText: aStringToTab

	^ String streamContents: [:stream | 
						aStringToTab linesDo: [:line | 
									stream nextPutAll: String tab, line; 
									nextPutAll: String newLineString.
								].
							]! !

!PortfolioReporter methodsFor: 'text' stamp: 'PUF 11/1/2024 21:10:16'!
removeLast

	text := text copyFrom: 1 to: text size - 1! !

!PortfolioReporter methodsFor: 'text' stamp: 'PUF 11/1/2024 21:06:32'!
text
	^text copy! !


!PortfolioReporter methodsFor: 'initialization' stamp: 'PUF 11/1/2024 21:09:44'!
initialize
	text := String new.! !


!PortfolioReporter methodsFor: 'visit' stamp: 'PUF 11/1/2024 21:37:09'!
visit: aPortfolio
	text := String new, aPortfolio name, String newLineString.
	aPortfolio acceptPortfolioReport: self.
	
	self removeLast.! !

!PortfolioReporter methodsFor: 'visit' stamp: 'PUF 11/1/2024 21:40:06'!
visitPortfolio: aPortfolio
	| portfolioText |
	portfolioText := (self class for: aPortfolio) text.
	
	text := text, (self addTabsToText: portfolioText).! !

!PortfolioReporter methodsFor: 'visit' stamp: 'PUF 11/1/2024 21:32:03'!
visitReceptiveAccount: aReceptiveAccount
	text := text, String tab, aReceptiveAccount name, String newLineString.! !


!classDefinition: #SpecialPortfolioReporter category: #'Portfolio-Solucion'!
AccountVisitor subclass: #SpecialPortfolioReporter
	instanceVariableNames: 'text'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialPortfolioReporter methodsFor: 'initialization' stamp: 'PUF 11/2/2024 08:45:02'!
initialize
	text := String new.! !


!SpecialPortfolioReporter methodsFor: 'text' stamp: 'PUF 11/2/2024 08:45:22'!
addTabsToText: aStringToTab

	^ String streamContents: [:stream | 
						aStringToTab linesDo: [:line | 
									stream nextPutAll: String tab, line; 
									nextPutAll: String newLineString.
								].
							]! !

!SpecialPortfolioReporter methodsFor: 'text' stamp: 'PUF 11/2/2024 08:45:31'!
removeLast

	text := text copyFrom: 1 to: text size - 1! !

!SpecialPortfolioReporter methodsFor: 'text' stamp: 'PUF 11/2/2024 08:45:38'!
text
	^text copy! !


!SpecialPortfolioReporter methodsFor: 'visit' stamp: 'PUF 11/2/2024 08:44:32'!
visit: aPortfolio
	text := String new, aPortfolio name, String newLineString.
	aPortfolio acceptPortfolioReport: self.
	
	self removeLast.! !

!SpecialPortfolioReporter methodsFor: 'visit' stamp: 'PUF 11/2/2024 08:44:22'!
visitPortfolio: aPortfolio
	| portfolioText |
	portfolioText := (self class for: aPortfolio) text.
	
	text := text, (self addTabsToText: portfolioText).! !

!SpecialPortfolioReporter methodsFor: 'visit' stamp: 'PUF 11/1/2024 21:42:12'!
visitReceptiveAccount: anAccount
	| receptiveAccountReport finalTabbedText |
	"tabs the report first. since we want that with another level of identation with respect to the account name"
	receptiveAccountReport := self addTabsToText: (AccountSummary for: anAccount) text .
	
	"here, it all gets tabbed so it is tabbed respecting its portfolio"
	finalTabbedText := self addTabsToText: (anAccount name, String newLineString, receptiveAccountReport).
	
	text := text, (finalTabbedText copyFrom: 1 to: finalTabbedText size - 2).! !


!classDefinition: #TransactionVisitor category: #'Portfolio-Solucion'!
Object subclass: #TransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionVisitor class' category: #'Portfolio-Solucion'!
TransactionVisitor class
	instanceVariableNames: ''!

!TransactionVisitor class methodsFor: 'instance creation' stamp: 'PUF 11/1/2024 21:07:37'!
for: anAccount
	^self new visit: anAccount! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
TransactionVisitor subclass: #AccountSummary
	instanceVariableNames: 'text'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:24:33'!
visitDeposit: aDeposit
	 text := text, 'Depósito por ', aDeposit value asString, '.', String newLineString.
! !

!AccountSummary methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:24:54'!
visitDepositLeg: aDepositLeg
	text := text, 'Entrada por transferencia de ', aDepositLeg value asString, '.', String newLineString.! !

!AccountSummary methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:25:05'!
visitWithdraw: aWithdraw
	text := text, 'Extracción por ', aWithdraw value asString, '.', String newLineString.! !

!AccountSummary methodsFor: 'generateText' stamp: 'PUF 11/1/2024 21:25:15'!
visitWithdrawLeg: aDepositLeg
	text := text, 'Salida por transferencia de ', aDepositLeg value asString, '.', String newLineString.! !


!AccountSummary methodsFor: 'generate' stamp: 'PUF 11/1/2024 21:28:56'!
visit: anAccount
	text := String new.
	anAccount visitTransactionsWith: self.
	
	text := text, 'Balance = ', anAccount balance asString.
! !


!AccountSummary methodsFor: 'text' stamp: 'PUF 11/1/2024 21:06:23'!
text
	^text copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: 'reportText'!


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg value depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'PUF 10/26/2024 10:52:49'!
initializeWith: aSender receiver: aReceiver amount: anAmount 
	value := anAmount.
	
	withdrawLeg := WithdrawLeg registerTransfer: self on: aSender.
	depositLeg := DepositLeg registerTransfer: self on: aReceiver.
	! !

!Transfer methodsFor: 'initialization' stamp: 'PUF 10/25/2024 21:42:19'!
value 
	^value! !


!Transfer methodsFor: 'accessing' stamp: 'PUF 10/26/2024 09:48:38'!
depositLeg
	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'PUF 10/26/2024 10:52:49'!
withdrawLeg
	^withdrawLeg! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'testing' stamp: 'PUF 10/26/2024 09:34:30'!
assertIsValidAmount: anAmountOfMoney
	anAmountOfMoney > 0 ifFalse: [self error: 'Invalid amount']! !

!Transfer class methodsFor: 'testing' stamp: 'PUF 11/1/2024 19:59:47'!
assertSender: aSender isDifferentFrom: aReceiver.
	aSender = aReceiver ifTrue: [self error: 'Cannot transfer between same accounts']
! !


!Transfer class methodsFor: 'instance creation' stamp: 'PUF 11/1/2024 19:59:13'!
from: aSender to: aReceiver amount: anAmount
	self assertIsValidAmount: anAmount.
	self assertSender: aSender isDifferentFrom: aReceiver.
	
	^self new initializeWith: aSender receiver: aReceiver amount: anAmount! !
