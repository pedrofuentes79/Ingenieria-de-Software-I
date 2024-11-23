!classDefinition: #MinefieldTest category: #'2023-2C'!
TestCase subclass: #MinefieldTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:37'!
defaultGame2x2

	^ Minefield sized: 2@2 lives: 2 startingAtColumn: 1 withPositionsAt: (self positions2x2) random: RandomStubReturns2 new! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:38'!
defaultGame3x3

	^ Minefield sized: 3@3 lives: 2 startingAtColumn: 1 withPositionsAt: (self positions3x3) random: RandomStubReturns2 new! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:32:31'!
positions2x2

	^ OrderedCollection withAll: {LightMine at: 1@2}! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:54:31'!
positions3x3

	^OrderedCollection withAll: {LightMine at: 1@2. (HeavyMine at: (2@2))}! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:46:57'!
test01PlayerStartsAtBottomPosition
	| game |
	game := self defaultGame2x2.
	
	game assert: (game positionIs: 1@1)! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:46:57'!
test02PlayerDoesNotStartInHigherRows
	| game |
	game := self defaultGame2x2.
	
	game deny: (game positionIs: 2@1)! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:38'!
test03GameMustHaveValidLives
	
	self should: [Minefield sized: 2@2 lives: 0 startingAtColumn: 1 withPositionsAt: (self positions2x2) random: RandomStubReturns2 new]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: Minefield invalidStartingLives]
	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:38'!
test04GameMustHaveValidSize
	
	self should: [Minefield sized: 1@1 lives: 3 startingAtColumn: 1 withPositionsAt: (self positions2x2) random: RandomStubReturns2 new]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: Minefield invalidSize]
	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:38'!
test05GameMustHaveValidStartingColumn
	
	self should: [Minefield sized: 3@3 lives: 3 startingAtColumn: 5 withPositionsAt: (self positions2x2) random: RandomStubReturns2 new]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: Minefield invalidColumn ]
	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:46:57'!
test06PlayerWinsIfReachesMaxRow
	
	| game |
	game := self defaultGame2x2.
	
	game moveUp.
	
	self assert: game hasWon.

! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:46:57'!
test07PlayerDoesNotBounceOnSideWalls
	
	| game |
	game := self defaultGame2x2.
	
	game moveLeft.
	
	self assert: (game positionIs: 1@1)

! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:46:57'!
test08PlayerDoesNotBounceOnUpDownWalls
	
	| game |
	game := self defaultGame2x2.
	
	game moveDown.
	
	self assert: (game positionIs: 1@1)

! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:38'!
test09GameCannotBeCreatedWithInvalidPositions
	
	self should:[ Minefield sized: 2@2 lives: 3 startingAtColumn: 1 withPositionsAt: (OrderedCollection withAll: {LightMine at: 9@9}) random: RandomStubReturns2 new]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: Minefield invalidPositions
		]
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:46:57'!
test10PlayerLosesALifeIfMovesIntoALightMine
	
	| game |
	game := self defaultGame2x2.
	
	game moveUp.
	
	self assert: (game currentLives: 1)

! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:37'!
test11PlayerDiesIfHasZeroLivesAndCannotKeepMoving
	| game |
	game := Minefield sized: 2@2 lives: 1 startingAtColumn: 1 withPositionsAt: (self positions2x2) random: RandomStubReturns2 new.
	game moveUp.
	
	self assert: (game playerIsDead).
	self should: [game moveUp]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error| 
		self assert: error messageText equals: 'Player is dead, it cannot keep moving.'
		]

! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 09:48:33'!
test12LightMineExplodesOnlyOnceAndAllowsPlayerToKeepMoving
	| game |
	game := self defaultGame2x2.
	
	game moveUp.
	game moveDown.
	game moveUp.
	
	self deny: (game playerIsDead)

! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 12:53:30'!
test13PlayerLosesTwoLivesIfMovesIntoHeavyMine
	| game startingLives |
	game := self defaultGame3x3.	
	startingLives := game currentLives.
	game moveRight.
	game moveUp.
	
	self assert: (game currentLives: startingLives - 2)! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/16/2024 12:53:05'!
test14PlayerFliesIntoTheAirWhenMovingIntoHeavyMine
	| game startPosition expectedFinalPosition |
	game := self defaultGame3x3.	
	startPosition := game position.
	expectedFinalPosition := (startPosition - (2@2)) min: game size max: 1@1.
	game moveRight.
	game moveUp.
	
	self assert: game position equals: expectedFinalPosition.
	
	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/17/2024 08:52:38'!
test15HeavyMineExplodesOnce
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: (self positions3x3) random: RandomStubReturns2 new.
	"goes into mine once"
	game moveRight.
	game moveUp.
	"goes into mine again"
	game moveLeft. 
	game moveRight.
	
	
	self assert: (game currentLives: 2).! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 08:20:37'!
test16LightArmorProtectsPlayerOnce
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 
	withPositionsAt: 
	(OrderedCollection withAll: {LightMine at:1@2. LightMine at:3@2. ArmorFieldPosition at: 2@2 with:LightArmor new}) 
	random: RandomStubReturns2 new.
			
	game moveRight. game moveUp.    "equip light armor"
	game moveLeft.		                  "step into mine"
	game moveRight. game moveRight. "step into another mine"
	
	self assert: (game currentLives: 3).! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 08:20:57'!
test17LightArmorProtectsPlayerFromHeavyMineAffectingItsMovement
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 
	withPositionsAt: (OrderedCollection withAll: {HeavyMine at:3@3. ArmorFieldPosition at: 1@2 with: LightArmor new.}) 
	random: RandomStubReturns2 new.
	
	game moveUp.
	game moveRight. game moveRight. game moveUp.
	
	self assert: (game positionIs: 2@2).! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 08:33:13'!
test18HeavyArmorProtectsPlayerOnlyTwiceFromLightMine
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: 
	(OrderedCollection withAll: {LightMine at:2@2. LightMine at:2@1. ArmorFieldPosition at: 1@2 with: HeavyArmor new. LightMine at:2@3}) 
	random: RandomStubReturns2 new.
	
	game moveUp.
	game moveRight. game moveDown.
	
	self assert: (game currentLives: 4).
	
	game moveUp. game moveUp.
	self assert: (game currentLives: 3)! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 08:37:27'!
test19HeavyArmorProtectsPlayerFromHeavyMine
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: 
	(OrderedCollection withAll: {HeavyMine at:2@2. ArmorFieldPosition at: 1@2 with: HeavyArmor new. }) 
	random: RandomStubReturns2 new.
	
	game moveUp.
	game moveRight.
	
	self assert: (game currentLives: 4).
	self assert: (game positionIs: 2@2).! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 08:49:27'!
test20HeavyArmorCannotProtectPlayerFromHeavyMineIfItHasProtectedFromLightMineEarlier
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: 
	(OrderedCollection withAll: {LightMine at:2@2. HeavyMine at:2@1. ArmorFieldPosition at: 1@2 with: HeavyArmor new.}) 
	random: RandomStubReturns2 new.
	
	game moveUp.
	game moveRight.	
	game moveDown.
	
	self assert: (game currentLives: 2).
	self assert: (game positionIs: 1@1).
	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 09:16:30'!
test21TunnelMovesPlayerFromPositions
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: 
	(OrderedCollection withAll: {Tunnel from: 2@2 to: 3@3.}) 
	random: RandomStubReturns2 new.
	
	game moveUp. game moveRight. 
	
	self assert: (game positionIs: 3@3)

	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 19:03:45'!
test22TunnelIsBidirectional
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: 
	(OrderedCollection withAll: {Tunnel from: 3@3 to: 2@2.}) 
	random: RandomStubReturns2 new.
	
	game moveUp. game moveRight. 
	
	self assert: (game positionIs: 3@3)

	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 20:02:59'!
test23PlayerEquipsAnyArmorItStepsInto
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: 
	(OrderedCollection withAll: {
	ArmorFieldPosition at: 1@2 with: LightArmor new. 
	ArmorFieldPosition at: 2@2 with: HeavyArmor new. 
	HeavyMine at: 2@1.}) 
	random: RandomStubReturns2 new.
	
	game moveUp. game moveRight. game moveDown. 
	
	self assert: (game positionIs: 2@1).
	self assert: (game currentLives: 4)

	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/18/2024 20:05:35'!
test24PlayerDoesNotBounceOffTheWalls
	| game |
	game := Minefield sized: 3@3 lives: 4 startingAtColumn: 1 withPositionsAt: (OrderedCollection new) 
	random: RandomStubReturns2 new.
	
	3 timesRepeat: [game moveRight].
	
	self assert: (game positionIs: 3@1)

	
! !

!MinefieldTest methodsFor: 'tests' stamp: 'pfu 11/19/2024 08:58:05'!
test25TunnelMustHaveDifferentStartAndEndHoles
	self should: [Tunnel from: 1@1 to: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'Tunnel must have different start and end holes']
! !


!classDefinition: #Armor category: #'2023-2C'!
Object subclass: #Armor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!


!classDefinition: #HeavyArmor category: #'2023-2C'!
Armor subclass: #HeavyArmor
	instanceVariableNames: 'defensePoints'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!HeavyArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:35:09'!
defendFromHeavyMineIn: aMineField
	defensePoints < 2 
	ifTrue: [aMineField blowPlayerUpInTheAirWhenEquippedWithUsedHeavyArmor.] ! !

!HeavyArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/18/2024 08:31:48'!
defendFromLightMineIn: aMineField
	defensePoints := 0 max: defensePoints - 1.
	defensePoints = 0 ifTrue: [aMineField removeArmor]! !

!HeavyArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/18/2024 08:08:53'!
initialize
	defensePoints := 2.	! !


!classDefinition: #LightArmor category: #'2023-2C'!
Armor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!LightArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/18/2024 09:06:57'!
defendFromHeavyMineIn: aMinefield
	aMinefield blowPlayerUpInTheAirWhenEquippedWithLightArmor.
	aMinefield removeArmor.! !

!LightArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/17/2024 08:42:11'!
defendFromLightMineIn: aMinefield
	aMinefield removeArmor.! !


!classDefinition: #NoArmor category: #'2023-2C'!
Armor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!NoArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/17/2024 08:50:39'!
defendFromHeavyMineIn: aMinefield
	aMinefield reduceLifeByTwo.
	aMinefield blowPlayerUpInTheAir.

	! !

!NoArmor methodsFor: 'as yet unclassified' stamp: 'pfu 11/17/2024 08:43:34'!
defendFromLightMineIn: aMinefield
	aMinefield reduceLifeByOne ! !


!classDefinition: #MineFieldPosition category: #'2023-2C'!
Object subclass: #MineFieldPosition
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!MineFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:28:36'!
affectGame: aMineFieldGame

	self subclassResponsibility! !

!MineFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:29:02'!
between: aMinimumPoint and: aMaximumPoint

	self subclassResponsibility! !

!MineFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/17/2024 08:15:55'!
initializeAt: aPosition
	position := aPosition.! !

!MineFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:07'!
isAt: aPosition

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineFieldPosition class' category: #'2023-2C'!
MineFieldPosition class
	instanceVariableNames: ''!

!MineFieldPosition class methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:59'!
at: aPosition

	self subclassResponsibility! !


!classDefinition: #ArmorFieldPosition category: #'2023-2C'!
MineFieldPosition subclass: #ArmorFieldPosition
	instanceVariableNames: 'armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!ArmorFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/18/2024 08:18:57'!
affectGame: aMinefieldGame
	aMinefieldGame playerSteppedIntoArmorFieldPosition: self with: armor.! !

!ArmorFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:29:02'!
between: aMinimumPoint and: aMaximumPoint
	^ position between: aMinimumPoint and: aMaximumPoint.! !

!ArmorFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:07'!
isAt: aPosition
	^ position = aPosition ! !


!ArmorFieldPosition methodsFor: 'initialization' stamp: 'pfu 11/18/2024 08:18:44'!
initializeAt: aPosition with: anArmor
	position := aPosition.
	armor := anArmor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ArmorFieldPosition class' category: #'2023-2C'!
ArmorFieldPosition class
	instanceVariableNames: ''!

!ArmorFieldPosition class methodsFor: 'as yet unclassified' stamp: 'pfu 11/18/2024 08:18:07'!
at: aPosition with: anArmor
	^ self new initializeAt: aPosition with: anArmor! !


!classDefinition: #EmptyMineFieldPosition category: #'2023-2C'!
MineFieldPosition subclass: #EmptyMineFieldPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!EmptyMineFieldPosition methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:40:04'!
affectGame: aMineFieldGame
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyMineFieldPosition class' category: #'2023-2C'!
EmptyMineFieldPosition class
	instanceVariableNames: ''!

!EmptyMineFieldPosition class methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:59'!
at: aPosition
	^ self new initializeAt: aPosition! !


!classDefinition: #HeavyMine category: #'2023-2C'!
MineFieldPosition subclass: #HeavyMine
	instanceVariableNames: 'random'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!HeavyMine methodsFor: 'as yet unclassified' stamp: 'pfu 11/17/2024 08:45:55'!
affectGame: aMineFieldGame
	
	aMineFieldGame playerSteppedIntoHeavyMine: self.! !

!HeavyMine methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:29:02'!
between: aMinimumPoint and: aMaximumPoint
	^ position between: aMinimumPoint and: aMaximumPoint.! !

!HeavyMine methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:07'!
isAt: aPosition
	^ position = aPosition ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeavyMine class' category: #'2023-2C'!
HeavyMine class
	instanceVariableNames: ''!


!HeavyMine class methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:59'!
at: aPosition
	^ self new initializeAt: aPosition! !


!classDefinition: #LightMine category: #'2023-2C'!
MineFieldPosition subclass: #LightMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!LightMine methodsFor: 'as yet unclassified' stamp: 'pfu 11/17/2024 08:29:33'!
affectGame: aMineFieldGame
	aMineFieldGame playerSteppedIntoLightMine: self.! !

!LightMine methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:29:02'!
between: aMinimumPoint and: aMaximumPoint
	^ position between: aMinimumPoint and: aMaximumPoint.! !

!LightMine methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:06'!
isAt: aPosition
	^ position = aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LightMine class' category: #'2023-2C'!
LightMine class
	instanceVariableNames: ''!

!LightMine class methodsFor: 'as yet unclassified' stamp: 'pfu 11/19/2024 10:27:59'!
at: aPosition
	^ self new initializeAt: aPosition! !


!classDefinition: #Tunnel category: #'2023-2C'!
MineFieldPosition subclass: #Tunnel
	instanceVariableNames: 'start end'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!Tunnel methodsFor: 'initialization' stamp: 'pfu 11/18/2024 09:14:43'!
initializeFrom: aStartPosition to: anEndPosition 
	start := aStartPosition.
	end := anEndPosition.! !


!Tunnel methodsFor: 'testing' stamp: 'pfu 11/19/2024 10:29:10'!
between: aMinimumPoint and: aMaximumPoint
	^ (start between: aMinimumPoint and: aMaximumPoint) and: [end between: aMinimumPoint and: aMaximumPoint]! !

!Tunnel methodsFor: 'testing' stamp: 'pfu 11/19/2024 10:27:13'!
isAt: aPosition
	^ start = aPosition or: [end = aPosition]! !


!Tunnel methodsFor: 'moving' stamp: 'pfu 11/18/2024 19:04:27'!
affectGame: aMineField
	aMineField playerSteppedIntoTunnel: self! !

!Tunnel methodsFor: 'moving' stamp: 'pfu 11/19/2024 08:58:37'!
movePlayerFrom: aPosition in: aMinefield 
	|finalPosition|
	finalPosition := (aPosition = start) ifTrue:[end] ifFalse:[start].

	aMinefield playerSteppedOutFromTunnelAt: finalPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunnel class' category: #'2023-2C'!
Tunnel class
	instanceVariableNames: ''!

!Tunnel class methodsFor: 'instance creation' stamp: 'pfu 11/19/2024 08:57:31'!
from: aStartPosition to: anEndPosition
	aStartPosition = anEndPosition ifTrue:[self error: 'Tunnel must have different start and end holes'].
	
	^self new initializeFrom: aStartPosition to: anEndPosition.! !


!classDefinition: #Minefield category: #'2023-2C'!
Object subclass: #Minefield
	instanceVariableNames: 'size lives position positions armor random'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!Minefield methodsFor: 'initialization' stamp: 'pfu 11/17/2024 08:53:08'!
initializeSized: aSize lives: aNumberOfLives startingAtColumn: aStartingColumn withPositionsAt: aSpecialPositionsDictionary random: aRandomGenerator  
	size := aSize.
	lives := aNumberOfLives.
	position := (aStartingColumn)@(1).
	positions := aSpecialPositionsDictionary.
	armor := NoArmor new.
	random := aRandomGenerator.! !


!Minefield methodsFor: 'testing' stamp: 'pfu 11/16/2024 09:54:23'!
currentLives
	^ lives! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/15/2024 22:37:31'!
currentLives: aNumberOfLives
	^ aNumberOfLives = lives ! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/15/2024 22:10:49'!
hasWon
	^ position y = size y! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/16/2024 09:43:46'!
isAlive
	^ self playerIsDead not! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/15/2024 22:57:16'!
playerIsDead
	^ lives = 0! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/16/2024 12:48:45'!
position
	^ position! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/15/2024 21:48:25'!
positionIs: aPosition
	^ aPosition = position ! !

!Minefield methodsFor: 'testing' stamp: 'pfu 11/16/2024 12:53:17'!
size
	^ size. ! !


!Minefield methodsFor: 'lives' stamp: 'pfu 11/16/2024 09:47:53'!
reduceLifeByOne
	lives := (lives - 1) max: 0.! !

!Minefield methodsFor: 'lives' stamp: 'pfu 11/16/2024 09:57:30'!
reduceLifeByTwo
	lives := (lives - 2) max: 0.! !


!Minefield methodsFor: 'asserts' stamp: 'pfu 11/16/2024 09:46:27'!
assertIsAlive
	self isAlive ifFalse:[self error: 'Player is dead, it cannot keep moving.']! !


!Minefield methodsFor: 'field positions' stamp: 'pfu 11/17/2024 08:18:56'!
currentFieldPosition

	^ positions detect: [:aFieldPosition | aFieldPosition isAt: position] ifNone: [EmptyMineFieldPosition new]! !

!Minefield methodsFor: 'field positions' stamp: 'pfu 11/17/2024 08:30:53'!
removeFieldElement: aFieldElement
	positions remove: aFieldElement.! !


!Minefield methodsFor: 'moving' stamp: 'pfu 11/16/2024 12:48:08'!
moveDown
	self assertIsAlive.
	self moveTo: (position x)@(position y - 1).
! !

!Minefield methodsFor: 'moving' stamp: 'pfu 11/16/2024 12:48:04'!
moveLeft
	self assertIsAlive.

	self moveTo: (position x-1)@(position y).
! !

!Minefield methodsFor: 'moving' stamp: 'pfu 11/16/2024 12:48:01'!
moveRight
	self assertIsAlive.
	self moveTo: (position x+1)@(position y).
! !

!Minefield methodsFor: 'moving' stamp: 'pfu 11/18/2024 19:02:23'!
moveTo: aNewPosition
		
	self setPosition: aNewPosition.
	
	self currentFieldPosition affectGame: self.! !

!Minefield methodsFor: 'moving' stamp: 'pfu 11/16/2024 12:47:56'!
moveUp
	self assertIsAlive.
	self moveTo: (position x)@(position y + 1).
! !

!Minefield methodsFor: 'moving' stamp: 'pfu 11/18/2024 19:02:12'!
setPosition: aPosition

	^ position := aPosition min: size max: 1@1! !


!Minefield methodsFor: 'armor' stamp: 'pfu 11/16/2024 19:24:51'!
equip: anArmor 
	armor := anArmor.! !

!Minefield methodsFor: 'armor' stamp: 'pfu 11/17/2024 08:44:02'!
removeArmor
	armor := NoArmor new.! !


!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/18/2024 09:03:31'!
blowPlayerUpInTheAir
	self moveTo: position + self generateRandomPoint.
	
	
! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/18/2024 09:06:57'!
blowPlayerUpInTheAirWhenEquippedWithLightArmor
	self moveTo: 	position + (self generateRandomPoint // 2)

	
	
! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/18/2024 09:06:36'!
blowPlayerUpInTheAirWhenEquippedWithUsedHeavyArmor
	self blowPlayerUpInTheAir.
	self reduceLifeByTwo.

	
	
! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/17/2024 09:01:41'!
generateRandomPoint

	| xToMove yToMove |	
	xToMove := (random nextInteger: 6) - 3.
	yToMove := (random nextInteger: 6) - 3.
	^ xToMove@yToMove! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/17/2024 08:37:16'!
playerSteppedIntoArmorFieldPosition: anArmorFieldPosition with: anArmor
	self equip: anArmor.
	
	self removeFieldElement: anArmorFieldPosition.	
	
! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/17/2024 08:46:32'!
playerSteppedIntoHeavyMine: aHeavyMine
	armor defendFromHeavyMineIn: self.
	
	self removeFieldElement: aHeavyMine.
	
	
! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/17/2024 08:44:55'!
playerSteppedIntoLightMine: aLightMine
	armor defendFromLightMineIn: self.
	self removeFieldElement: aLightMine.
	
	
! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/18/2024 19:04:42'!
playerSteppedIntoTunnel: aTunnel 
	aTunnel movePlayerFrom: position in: self! !

!Minefield methodsFor: 'player stepped into' stamp: 'pfu 11/18/2024 19:51:09'!
playerSteppedOutFromTunnelAt: anEndOfTunnel
	self setPosition: anEndOfTunnel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Minefield class' category: #'2023-2C'!
Minefield class
	instanceVariableNames: ''!

!Minefield class methodsFor: 'errors' stamp: 'pfu 11/15/2024 22:31:26'!
invalidPositions
	^ 'Invalid positions'! !

!Minefield class methodsFor: 'errors' stamp: 'pfu 11/15/2024 21:53:15'!
invalidSize
	^'Invalid size'! !

!Minefield class methodsFor: 'errors' stamp: 'pfu 11/15/2024 21:53:30'!
invalidStartingLives
	^ 'Invalid starting lives'! !


!Minefield class methodsFor: 'instance creation' stamp: 'pfu 11/15/2024 22:05:10'!
assertValidLives: aNumberOfLives
	aNumberOfLives > 0 ifFalse:[self error: self invalidStartingLives ]! !

!Minefield class methodsFor: 'instance creation' stamp: 'pfu 11/17/2024 08:22:05'!
assertValidPositions: aPositionsDictionary withSize: aSize
	(aPositionsDictionary allSatisfy: [:aFieldPosition | (aFieldPosition between: 1@1 and: aSize)]) 
	ifFalse: [self error: self invalidPositions]! !

!Minefield class methodsFor: 'instance creation' stamp: 'pfu 11/15/2024 22:03:10'!
assertValidSize: aSize
	(aSize < (2@2)) ifTrue: [self error: self invalidSize]! !

!Minefield class methodsFor: 'instance creation' stamp: 'pfu 11/15/2024 22:05:54'!
assertValidStartingColumn: aStartingColumn withSize: aSize
	(aStartingColumn < aSize x) ifFalse: [self error: self invalidColumn]! !

!Minefield class methodsFor: 'instance creation' stamp: 'pfu 11/15/2024 22:06:09'!
invalidColumn
	^'Invalid Column'! !

!Minefield class methodsFor: 'instance creation' stamp: 'pfu 11/17/2024 08:53:02'!
sized: aSize lives: aNumberOfLives startingAtColumn: aStartingColumn withPositionsAt: aSpecialPositionsCollection random: aRandomGenerator 
	self assertValidSize: aSize.
	self assertValidLives: aNumberOfLives.
	self assertValidStartingColumn: aStartingColumn withSize: aSize.
	self assertValidPositions: aSpecialPositionsCollection withSize: aSize.

	^self new initializeSized: aSize lives: aNumberOfLives startingAtColumn: aStartingColumn withPositionsAt: aSpecialPositionsCollection random: aRandomGenerator ! !


!classDefinition: #RandomStubReturns2 category: #'2023-2C'!
Object subclass: #RandomStubReturns2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2023-2C'!

!RandomStubReturns2 methodsFor: 'generating' stamp: 'pfu 11/16/2024 12:43:52'!
nextInteger: aMaxValue
	^ 2 min: aMaxValue! !
