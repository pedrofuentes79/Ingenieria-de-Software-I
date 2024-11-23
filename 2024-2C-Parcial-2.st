!classDefinition: #PacmanTest category: #'2024-2C-Parcial-2'!
TestCase subclass: #PacmanTest
	instanceVariableNames: 'currentTestFixedValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test01PacmanStartsMovingLeftAndLeavesSpaceBehind
	|game |
	
	game := PacmanGame on: self defaultBoard aRandomizer: self.
	
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: 
#(
'######'
'#-BC-#'
'#p=--#'
'######').
	
	! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test02PacmanReceivesPointIfEatsSmallPill
	|game |
	
	game := PacmanGame on: self defaultBoard aRandomizer: self.
	
	game tick.
	
	self assert: (game currentPoints: 1)
	
	! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test03PacmanReceivesTwoPointsIfEatsBigPill
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'######'
	'#-BC-#'
	'#*p--#'
	'######'
	)) aRandomizer: self.
	
	game tick.
	
	self assert: (game currentPoints: 2)
	
	! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test04PacmanCantMoveInsideASideWall
	|game |
	
	game := PacmanGame on: self defaultBoard aRandomizer: self.
	
	game tick.
	game tick.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'######'
	'#-BC-#'
	'#p=--#'
	'######'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test05PacmanCanSwitchHeadingToRight
	|game |
	
	game := PacmanGame on: self defaultBoard aRandomizer: self.
	
	game pacmanMoveRight.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'######'
	'#-BC-#'
	'#-=p-#'
	'######'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test06PacmanCanSwitchHeadingToUp
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'######'
	'#B-C-#'
	'#-p--#'
	'######'
	)) aRandomizer: self.
	
	game pacmanMoveUp.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'######'
	'#BpC-#'
	'#-=--#'
	'######'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test07PacmanCanSwitchHeadingToDown
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'######'
	'#BpC-#'
	'#----#'
	'######'
	)) aRandomizer: self.
	
	game pacmanMoveDown.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'######'
	'#B=C-#'
	'#-p--#'
	'######'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test08PacmanCanSwitchHeadingBackToLeft
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'######'
	'#BpC-#'
	'#----#'
	'######'
	)) aRandomizer: self.
	
	game pacmanMoveDown.
	game tick.
	game pacmanMoveLeft.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'######'
	'#B=C-#'
	'#p=--#'
	'######'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:30:17'!
test09BlinkyStartsMovingLeftAfter4thTick
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'######'
	'#--BC#'
	'#---p#'
	'######'
	)) aRandomizer: self.
	
	4 timesRepeat: [game tick].
	game pacmanMoveUp.
	game tick. "aca se mueve blinky!!"
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'######'
	'#pB=C#'
	'#====#'
	'######'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test10BlinkyLeavesPillIfWalksIntoItAndThenLeaves
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#----BC#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	
	6 timesRepeat: [game tick].

	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#--B-=C#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test11ClydeStartsMovingAfter5thTick
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----B#'
	'#C-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	
	6 timesRepeat: [game tick].

	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#---B-=#'
	'#=C----#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:40:44'!
test12ClydeLeavesPillIfWalksIntoItAndThenLeaves
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----B#'
	'#C-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	
	7 timesRepeat: [game tick].
	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#--B--=#'
	'#=-C---#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:56:59'!
test13GhostMovesAccordingToRandomValueDownWhenMovesIntoAWall
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#B-----#'
	'#-----C#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 4.
	
	6 timesRepeat: [game tick].
	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#=-----#'
	'#B----C#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:58:34'!
test14GhostMovesAccordingToRandomValueUpWhenMovesIntoAWall
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#------#'
	'#B----C#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 3.
	
	6 timesRepeat: [game tick].
	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#B-----#'
	'#=----C#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:05:32'!
test15GhostMovesAccordingToRandomValueLeftWhenMovesIntoAWall
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#B-----#'
	'#C-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 2.
	
	6 timesRepeat: [game tick].
	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#B-----#'
	'#=C----#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:04:22'!
test16GhostMovesAccordingToRandomValueRightWhenMovesIntoAWall
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----C#'
	'#B-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 5.
	
	7 timesRepeat: [game tick].
	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#-----C#'
	'#=-B---#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:06:25'!
test17GhostMovesAccordingToRandomValueNoChangeWhenMovesIntoAWall
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----C#'
	'#B-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 1.
	
	7 timesRepeat: [game tick].
	
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#-----C#'
	'#B-----#'
	'#p=====#'
	'########'
	)! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:51:49'!
test18PacmanLosesLifeWhenEatenByGhost
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----C#'
	'#B-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	
	currentTestFixedValue := 1.
	
	5 timesRepeat: [game tick].
	game pacmanMoveUp.
	game tick.
	
	self assert: (game currentLives: 2).! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:14:24'!
test19PacmanRestartsPositionAfterBeingEatenByAGhost
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----C#'
	'#B-----#'
	'#-----p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 1.
	
	5 timesRepeat: [game tick].
	game pacmanMoveUp.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#-----C#'
	'#B-----#'
	'#=====p#'
	'########'
	).! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:18:11'!
test20GameIsOverIfPacmanReaches0Lives
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#-----C#'
	'#------#'
	'#----Bp#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 1.
	
	3 timesRepeat: [game tick].
	
	self assert: game isOver.! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:19:16'!
test21GameIsOverIfThereAreNoMorePills
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#=====C#'
	'#=====B#'
	'#====-p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 1.
	
	game tick.
		
	self assert: game isOver.! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:30:26'!
test22GameIsNotOverIfThereIsAHiddenPill
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#=====C#'
	'#====-B#'
	'#====-p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 3.
	
	5 timesRepeat: [game tick.].
		
	self deny: game isOver.! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:25:42'!
test23GameCannotTickIfItsOver
	|game |
	
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#=====C#'
	'#=====B#'
	'#====-p#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 3.
	
	game tick.
		
	self should: [game tick]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'Game is over']! !

!PacmanTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 21:55:38'!
_test25GhostsCanMoveToBigPillAndLeaveItThere
	|game |
	game := PacmanGame on: (StringPacmanBoard representedAs:#(
	'########'
	'#--*BC*#'
	'#p-----#'
	'########'
	)) aRandomizer: self.
	currentTestFixedValue := 4.
	
	7 timesRepeat: [game tick].
	
	self assert: game stringRepresentationOfBoard equals:
	#(
	'########'
	'#B-*==*#'
	'#p----C#'
	'########'
	).
		
	! !


!PacmanTest methodsFor: 'support' stamp: 'PFU 11/22/2024 17:37:29'!
defaultBoard

	^ StringPacmanBoard representedAs:#(
	'######'
	'#-BC-#'
	'#-p--#'
	'######'
	)! !

!PacmanTest methodsFor: 'support' stamp: 'PFU 11/22/2024 20:49:03'!
nextInteger: aMaxIntegerToReturn 
	^ currentTestFixedValue! !

!PacmanTest methodsFor: 'support' stamp: 'PFU 11/22/2024 20:49:21'!
setUp
	currentTestFixedValue := 1.! !


!classDefinition: #StringPacmanBoardTest category: #'2024-2C-Parcial-2'!
TestCase subclass: #StringPacmanBoardTest
	instanceVariableNames: 'visitedElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test01CannotCreateABoardWithoutThePacman

	self 
		should: [ StringPacmanBoard representedAs: #('BC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard pacmanName)
		! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test02CannotCreateABoardWithMoreThanOnePacman

	self 
		should: [ StringPacmanBoard representedAs: #('BCpp') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard pacmanName)
		! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test03CannotCreateABoardWithoutBlinky

	self 
		should: [ StringPacmanBoard representedAs: #('pC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard blinkyName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 14:32:55'!
test04CannotCreateABoardWithMoreThanOneBlinky

	self 
		should: [ StringPacmanBoard representedAs: #('pBBC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard blinkyName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:33'!
test05CannotCreateABoardWithoutClyde

	self 
		should: [ StringPacmanBoard representedAs: #('pB') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard clydeName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:40'!
test06CannotCreateABoardWithMoreThanOneClyde

	self 
		should: [ StringPacmanBoard representedAs: #('pBCC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard clydeName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:49'!
test07AllRowsHaveSameSize

	self 
		should: [ StringPacmanBoard representedAs: #('pBC' '') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: StringPacmanBoard rowsMustHaveSameSizeErrorDescription! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:51:00'!
test08VisitElementsWithRightPosition

	| board |
	
	visitedElements := Dictionary new.
	
	board := StringPacmanBoard representedAs: #('pBC#-*=').
	board visitElementsWith: self.
	
	self assert: (visitedElements at: #pacman) equals: 1@1.
	self assert: (visitedElements at: #blinky) equals: 2@1.
	self assert: (visitedElements at: #clyde) equals: 3@1.
	self assert: (visitedElements at: #wall) equals: 4@1.
	self assert: (visitedElements at: #smallPill) equals: 5@1.
	self assert: (visitedElements at: #bigPill) equals: 6@1.
	self assert: (visitedElements at: #space) equals: 7@1.
	self assert: visitedElements size equals: 7
	
	
	! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:51:11'!
test09InvalidCharactersAreNotAllowed

	self 
		should: [ StringPacmanBoard representedAs: #('pBCx') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard notAllowCharaterErrorDescriptionFor: $x)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'PFU 11/22/2024 20:41:06'!
test10BoardTranslationExample
"
	HACER PASAR ESTE TEST ANTES DE COMENZAR: falla porque en la posicion del pacman (p) pone un string en vez de #pacman
"
	| board translator |
	
	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p=-#'
'######').

	translator := BoardTranslatorExample on: board.
	
	self assert: translator stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#-p=-#'
'######').
! !


!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:25'!
visitBigPillAt: position 
	
	visitedElements at: #bigPill put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:27'!
visitBlinkyAt: position 
	
	visitedElements at: #blinky put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:56'!
visitClydeAt: position 
	
	visitedElements at: #clyde put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:10'!
visitPacmanAt: position 
	
	visitedElements at: #pacman put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:14'!
visitSmallPillAt: position 
	
	visitedElements at: #smallPill put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:17:12'!
visitSpaceAt: position 
	
	visitedElements at: #space put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:05'!
visitWallAt: position 
	
	visitedElements at: #wall put: position ! !


!classDefinition: #BoardTranslatorExample category: #'2024-2C-Parcial-2'!
Object subclass: #BoardTranslatorExample
	instanceVariableNames: 'board boardExtent entitiesPositions game stringBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'HAW 11/22/2024 14:38:51'!
characterRepresentationOf: anElement
	
	(anElement = #smallPill) ifTrue: [ ^StringPacmanBoard smallPillCharacter ].
	(anElement = #bigPill) ifTrue: [ ^StringPacmanBoard bigPillCharacter ].
	(anElement = #blinky) ifTrue: [ ^StringPacmanBoard blinkyCharacter ].
	(anElement = #clyde) ifTrue: [ ^StringPacmanBoard clydeCharacter ].
	(anElement = #space) ifTrue: [ ^StringPacmanBoard spaceCharacter ].
	(anElement = #wall) ifTrue: [ ^StringPacmanBoard wallCharacter ].
	(anElement = #pacman) ifTrue: [ ^StringPacmanBoard pacmanCharacter ].
	
	self error: 'Unknown pacman element type'! !

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'HAW 11/22/2024 14:45:23'!
representationOfRowNumber: y
	
	^String streamContents: [ :rowStream |
		1 to: boardExtent x do: [ :x |
			rowStream nextPut: (self characterRepresentationOf: (board at: x@y))]]! !

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'LL 11/22/2024 10:44:29'!
stringRepresentationOfBoard
	
	| rows |
	
	rows := OrderedCollection new.

	1 to: boardExtent y do: [ :y | 
		rows add: (self representationOfRowNumber: y) ].
	
	^rows asArray! !


!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:42:38'!
visitBigPillAt: aPosition 
	
	board at: aPosition put: #bigPill! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:40:34'!
visitBlinkyAt: aPosition 
	
	board at: aPosition put: #blinky! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:04'!
visitClydeAt: aPosition 
	
	board at: aPosition put: #clyde! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'PFU 11/22/2024 18:07:49'!
visitPacmanAt: aPosition 
	
	board at: aPosition put: #pacman.
	
	entitiesPositions at: #pacman put: aPosition! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:22'!
visitSmallPillAt: aPosition 
	
	board at: aPosition put: #smallPill! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:30'!
visitSpaceAt: aPosition

	board at: aPosition put: #space
	
	! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:35'!
visitWallAt: aPosition 
	
	board at: aPosition put: #wall! !


!BoardTranslatorExample methodsFor: 'moving' stamp: 'PFU 11/22/2024 18:19:31'!
movePacmanToTheLeft
	|previousPacmanPosition newPacmanPosition |
	previousPacmanPosition := (entitiesPositions at: #pacman).
	newPacmanPosition := 	previousPacmanPosition +(-1@0).
	
	((board at: newPacmanPosition) = #smallPill) ifTrue: [game pacmanAteSmallPill].

	board at: previousPacmanPosition put: #space.
	board at: newPacmanPosition put: #pacman.
	entitiesPositions at: #pacman put: newPacmanPosition.
	
	
	! !


!BoardTranslatorExample methodsFor: 'accessing' stamp: 'PFU 11/22/2024 18:29:16'!
positionOf: anElement
	entitiesPositions at: anElement.! !


!BoardTranslatorExample methodsFor: 'initialization' stamp: 'PFU 11/22/2024 20:42:55'!
initializeOn: aBoard

	board := Dictionary new.
	entitiesPositions := Dictionary new.
	boardExtent := aBoard extent.
	aBoard visitElementsWith: self.! !

!BoardTranslatorExample methodsFor: 'initialization' stamp: 'PFU 11/22/2024 18:12:01'!
initializeOn: aBoard for: aPacmanGame

	board := Dictionary new.
	entitiesPositions := Dictionary new.
	boardExtent := aBoard extent.
	game := aPacmanGame.
	aBoard visitElementsWith: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardTranslatorExample class' category: #'2024-2C-Parcial-2'!
BoardTranslatorExample class
	instanceVariableNames: ''!

!BoardTranslatorExample class methodsFor: 'as yet unclassified' stamp: 'PFU 11/22/2024 20:43:04'!
on: aBoard

	^self new initializeOn: aBoard! !

!BoardTranslatorExample class methodsFor: 'as yet unclassified' stamp: 'PFU 11/22/2024 18:11:35'!
on: aBoard for: aPacmanGame

	^self new initializeOn: aBoard for: aPacmanGame.! !


!classDefinition: #Heading category: #'2024-2C-Parcial-2'!
Object subclass: #Heading
	instanceVariableNames: 'entity'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Heading methodsFor: 'initialization' stamp: 'PFU 11/22/2024 19:29:41'!
initializeFor: anEntity 

	entity := anEntity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Heading class' category: #'2024-2C-Parcial-2'!
Heading class
	instanceVariableNames: ''!

!Heading class methodsFor: 'instance creation' stamp: 'PFU 11/22/2024 19:29:33'!
for: anEntity
	^self new initializeFor: anEntity ! !


!classDefinition: #HeadingDown category: #'2024-2C-Parcial-2'!
Heading subclass: #HeadingDown
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!HeadingDown methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:35:55'!
move
	entity moveDown.! !


!classDefinition: #HeadingLeft category: #'2024-2C-Parcial-2'!
Heading subclass: #HeadingLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!HeadingLeft methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:31:25'!
move
	entity moveLeft! !


!classDefinition: #HeadingRight category: #'2024-2C-Parcial-2'!
Heading subclass: #HeadingRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!HeadingRight methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:31:40'!
move
	entity moveRight! !


!classDefinition: #HeadingUp category: #'2024-2C-Parcial-2'!
Heading subclass: #HeadingUp
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!HeadingUp methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:34:25'!
move
	entity moveUp.! !


!classDefinition: #PacmanGame category: #'2024-2C-Parcial-2'!
Object subclass: #PacmanGame
	instanceVariableNames: 'lives points pacman positions clyde blinky extent ticks hiddenPositions randomizer pacmanInitialPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGame methodsFor: 'initialization' stamp: 'PFU 11/22/2024 21:10:34'!
initializeOn: aBoard withRandomizer: aRandomizer 

	positions := Dictionary new.
	hiddenPositions := Dictionary new.
	points := 0.
	lives := 3.
	extent := aBoard extent.
	ticks := 0.
	randomizer := aRandomizer.
	aBoard visitElementsWith: self.
	pacman saveInitialPosition.
	
	! !

!PacmanGame methodsFor: 'initialization' stamp: 'PFU 11/22/2024 21:11:01'!
pacmanInitialPositionIs: anInitialPosition
	pacmanInitialPosition := anInitialPosition.! !


!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 21:29:15'!
assertGameNotOver
	self isOver ifTrue: [self error: 'Game is over'.]! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 21:12:31'!
currentLives: aNumberOfLives 
	^ aNumberOfLives = lives.! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 17:50:24'!
currentPoints: anAmountOfPoints 
	^ anAmountOfPoints = points! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:52:09'!
extent
	^extent! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 21:20:38'!
isOver
	^ lives = 0 or: [self thereAreNoMorePills]! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 20:41:16'!
stringRepresentationOfBoard
	^ (BoardTranslatorExample on: self) stringRepresentationOfBoard! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 21:33:54'!
thereAreNoMorePills
	^ (self thereAreNoPillsInPositionCollection: positions) and: [self thereAreNoPillsInPositionCollection: hiddenPositions]! !

!PacmanGame methodsFor: 'testing' stamp: 'PFU 11/22/2024 21:33:29'!
thereAreNoPillsInPositionCollection: aPositionCollection
	^ (aPositionCollection values anySatisfy: [:anElement | anElement isBigPill or: [anElement isSmallPill]]) not! !


!PacmanGame methodsFor: 'moving' stamp: 'PFU 11/22/2024 18:42:38'!
addPoint
	points := points + 1.! !

!PacmanGame methodsFor: 'moving' stamp: 'PFU 11/22/2024 18:43:17'!
movePacmanTo: aPosition 
	positions at: aPosition put: pacman.
	pacman changePositionTo: aPosition.! !

!PacmanGame methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:35:26'!
pacmanMoveDown
	pacman switchHeadingToDown.! !

!PacmanGame methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:37:20'!
pacmanMoveLeft
	pacman switchHeadingToLeft! !

!PacmanGame methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:24:33'!
pacmanMoveRight
	pacman switchHeadingToRight.! !

!PacmanGame methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:33:41'!
pacmanMoveUp
	pacman switchHeadingToUp.! !


!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 19:18:17'!
visit: anElement at: aPosition with: aPacmanBoardVisitor

	(anElement isWall) ifTrue: [ ^aPacmanBoardVisitor visitWallAt: aPosition ].
	(anElement isSmallPill) ifTrue: [ ^aPacmanBoardVisitor visitSmallPillAt: aPosition ].
	(anElement isBigPill) ifTrue: [ ^aPacmanBoardVisitor visitBigPillAt: aPosition ].
	(anElement isBlinky) ifTrue: [ ^aPacmanBoardVisitor visitBlinkyAt: aPosition ].
	(anElement isClyde) ifTrue: [ ^aPacmanBoardVisitor visitClydeAt: aPosition ].
	(anElement isPacman) ifTrue: [ ^aPacmanBoardVisitor visitPacmanAt: aPosition ].
	(anElement isSpace) ifTrue: [ ^aPacmanBoardVisitor visitSpaceAt: aPosition ].

	! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 19:12:48'!
visitBigPillAt: aPosition 
	positions at: aPosition put: (BigPill on: self at: aPosition)! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 18:49:06'!
visitBlinkyAt: aPosition 
	blinky := Blinky on: self at: aPosition.
	positions at: aPosition put: (blinky).! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 18:48:50'!
visitClydeAt: aPosition 
	clyde := Clyde on: self at: aPosition.
	positions at: aPosition put: (clyde).! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 18:57:49'!
visitElementsWith: aPacmanBoardVisitor
	
	 positions keysAndValuesDo: [:position :element | 			self visit: element at: position with: aPacmanBoardVisitor.].! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 18:34:26'!
visitPacmanAt: aPosition
	pacman := Pacman on: self at: aPosition.
	positions at: aPosition put: pacman.! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 18:38:58'!
visitSmallPillAt: aPosition 
	positions at: aPosition put: (SmallPill on: self at: aPosition)! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 21:20:03'!
visitSpaceAt: aPosition 
	positions at: aPosition put: (Space on: self at: aPosition).! !

!PacmanGame methodsFor: 'visiting' stamp: 'PFU 11/22/2024 18:37:47'!
visitWallAt: aPosition
	positions at: aPosition put: (Wall on: self at: aPosition).! !


!PacmanGame methodsFor: 'ticks' stamp: 'PFU 11/22/2024 19:43:44'!
incrementTickCounter
	ticks := ticks + 1.! !

!PacmanGame methodsFor: 'ticks' stamp: 'PFU 11/22/2024 19:45:01'!
shouldMoveBlinky
	^ ticks >= 4! !

!PacmanGame methodsFor: 'ticks' stamp: 'PFU 11/22/2024 19:44:58'!
shouldMoveClyde
	^ ticks >= 5! !

!PacmanGame methodsFor: 'ticks' stamp: 'PFU 11/22/2024 21:28:56'!
tick
	self assertGameNotOver.

	pacman move.	
	self shouldMoveBlinky ifTrue: [blinky move.].
	self shouldMoveClyde ifTrue: [clyde move].
	
	self incrementTickCounter.! !


!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:43:02'!
bigPillReceivesBlinkyAt: aBigPillPosition 
	self bigPillReceivesGhost: blinky at: aBigPillPosition ! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:43:08'!
bigPillReceivesClydeAt: aBigPillPosition 
	self bigPillReceivesGhost: clyde at: aBigPillPosition ! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:42:34'!
bigPillReceivesGhost: aGhost at: aBigPillPosition 
	hiddenPositions at: aBigPillPosition put: (BigPill on: self at: aBigPillPosition).
	self validElementReceivesEntity: aGhost at: aBigPillPosition! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:28:31'!
bigPillReceivesPacmanAt: aBigPillPosition 
	self validElementReceivesPacmanAt: aBigPillPosition.
	points := points + 2.
! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:09:03'!
ghostReceivedPacman
	self pacmanDied.! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:49:09'!
receiveBlinkyAt: aPosition 
	(positions at: aPosition) receiveBlinky.! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:15:19'!
receiveClydeAt: aPosition 
	(positions at: aPosition) receiveClyde.! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:21:39'!
receivePacmanAt: aPosition 
	(positions at: aPosition) receivePacman.! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:23:51'!
smallPillReceivesBlinkyAt: aSmallPillPosition
	self smallPillReceivesGhost: blinky at: aSmallPillPosition 
! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:23:42'!
smallPillReceivesClydeAt: aSmallPillPosition 
	self smallPillReceivesGhost: clyde at: aSmallPillPosition ! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:42:22'!
smallPillReceivesGhost: aGhost at: aSmallPillPosition 
	hiddenPositions at: aSmallPillPosition put: (SmallPill on: self at: aSmallPillPosition).
	self validElementReceivesEntity: aGhost at: aSmallPillPosition! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:28:11'!
smallPillReceivesPacmanAt: aSmallPillPosition 
	self validElementReceivesPacmanAt: aSmallPillPosition.
	points := points + 1.
! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:38:33'!
spaceReceivesEntityAt: aPosition
	self validElementReceivesPacmanAt: aPosition
! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:41:29'!
validElementReceivesEntity: anEntity at: aPosition

	positions at: aPosition put: anEntity.
	
	anEntity leavePosition.
	anEntity moveTo: aPosition! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:41:43'!
validElementReceivesPacmanAt: aPosition

	self validElementReceivesEntity: pacman at: aPosition! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:47:09'!
wallReceivesBlinkyAt: aPosition
	self wallReceivesGhost: blinky at: aPosition.! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:46:58'!
wallReceivesClydeAt: aPosition
	self wallReceivesGhost: clyde at: aPosition.! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:48:27'!
wallReceivesGhost: aGhost at: aPosition 
	| movementKey |
	movementKey := randomizer nextInteger: 5.
	
	movementKey = 2 ifTrue: [aGhost switchHeadingToLeft].
	movementKey = 3 ifTrue: [aGhost switchHeadingToUp].
	movementKey = 4 ifTrue: [aGhost switchHeadingToDown].
	movementKey = 5 ifTrue: [aGhost switchHeadingToRight].! !

!PacmanGame methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:21:04'!
wallReceivesPacmanAt: aPosition 
! !


!PacmanGame methodsFor: 'entity leaves position' stamp: 'PFU 11/22/2024 20:13:31'!
ghostLeavesPositionAt: aPositionBeingLeftByAGhost 
	
	| elementToPutInPosition |
	elementToPutInPosition := hiddenPositions at: aPositionBeingLeftByAGhost 
		ifPresent: [:elementInPosition | hiddenPositions removeKey: (hiddenPositions keyAtValue: elementInPosition). elementInPosition.] 
		ifAbsent: [Space on: self at: aPositionBeingLeftByAGhost].
	
	positions at: aPositionBeingLeftByAGhost put: elementToPutInPosition.

	! !

!PacmanGame methodsFor: 'entity leaves position' stamp: 'PFU 11/22/2024 20:26:24'!
pacmanLeavesPositionAt: aPositionBeingLeftByAPacman 
	
	positions at: aPositionBeingLeftByAPacman put: (Space on: self at: aPositionBeingLeftByAPacman).

	! !


!PacmanGame methodsFor: 'pacman - ghost interaction' stamp: 'PFU 11/22/2024 21:17:30'!
pacmanDied
	lives := lives - 1.
	self restorePacmanPosition.
	ticks := 0.! !

!PacmanGame methodsFor: 'pacman - ghost interaction' stamp: 'PFU 11/22/2024 21:14:50'!
restorePacmanPosition
	pacman leavePosition.
	positions at: pacmanInitialPosition put: pacman.
	pacman moveTo: pacmanInitialPosition.! !


!PacmanGame methodsFor: 'as yet unclassified' stamp: 'PFU 11/22/2024 21:36:56'!
spaceReceivesBlinkyAt: position1 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PacmanGame class' category: #'2024-2C-Parcial-2'!
PacmanGame class
	instanceVariableNames: ''!

!PacmanGame class methodsFor: 'instance creation' stamp: 'PFU 11/22/2024 20:41:41'!
on: aBoard aRandomizer: aRandomizer 
	^self new initializeOn: aBoard withRandomizer: aRandomizer ! !


!classDefinition: #PacmanGameElement category: #'2024-2C-Parcial-2'!
Object subclass: #PacmanGameElement
	instanceVariableNames: 'position game'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGameElement methodsFor: 'initialization' stamp: 'PFU 11/22/2024 18:38:33'!
initializeOn: aPacmanGame at: aPosition 
	game := aPacmanGame.
	position := aPosition.! !


!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:55:41'!
isBigPill
	^ false! !

!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:55:48'!
isBlinky
	^false! !

!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:55:58'!
isClyde
	^false! !

!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:56:06'!
isPacman
	^ false! !

!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:55:32'!
isSmallPill
	^ false! !

!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:56:14'!
isSpace
	^ false! !

!PacmanGameElement methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:55:21'!
isWall
	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PacmanGameElement class' category: #'2024-2C-Parcial-2'!
PacmanGameElement class
	instanceVariableNames: ''!

!PacmanGameElement class methodsFor: 'instance creation' stamp: 'PFU 11/22/2024 18:38:16'!
on: aPacmanGame at: aPosition 
	^self new initializeOn: aPacmanGame at: aPosition ! !


!classDefinition: #BigPill category: #'2024-2C-Parcial-2'!
PacmanGameElement subclass: #BigPill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!BigPill methodsFor: 'testing' stamp: 'PFU 11/22/2024 19:13:13'!
isBigPill
	^ true.! !


!BigPill methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:45:56'!
receiveBlinky
	game bigPillReceivesBlinkyAt: position! !

!BigPill methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:46:09'!
receiveClyde
	game bigPillReceivesClydeAt: position! !

!BigPill methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:14:09'!
receivePacman
	game bigPillReceivesPacmanAt: position.! !


!classDefinition: #PacmanGameEntity category: #'2024-2C-Parcial-2'!
PacmanGameElement subclass: #PacmanGameEntity
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGameEntity methodsFor: 'heading' stamp: 'PFU 11/22/2024 19:35:45'!
switchHeadingToDown
	heading := HeadingDown for: self.! !

!PacmanGameEntity methodsFor: 'heading' stamp: 'PFU 11/22/2024 19:37:37'!
switchHeadingToLeft
	heading := HeadingLeft for: self.! !

!PacmanGameEntity methodsFor: 'heading' stamp: 'PFU 11/22/2024 19:30:17'!
switchHeadingToRight
	heading := HeadingRight for: self! !

!PacmanGameEntity methodsFor: 'heading' stamp: 'PFU 11/22/2024 19:34:13'!
switchHeadingToUp
	heading := HeadingUp for: self.! !


!PacmanGameEntity methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:52:23'!
downPosition

	^ position + (0@1)! !

!PacmanGameEntity methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:47:31'!
leftPosition

	^ position + (-1@0)! !

!PacmanGameEntity methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:31:09'!
move
	heading move! !

!PacmanGameEntity methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:08:11'!
moveTo: aPosition
	position := aPosition.! !

!PacmanGameEntity methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:47:16'!
rightPosition

	^ position + (1@0)! !

!PacmanGameEntity methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:48:03'!
upPosition

	^ position + (0@-1)! !


!classDefinition: #Pacman category: #'2024-2C-Parcial-2'!
PacmanGameEntity subclass: #Pacman
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Pacman methodsFor: 'moving' stamp: 'PFU 11/22/2024 18:43:29'!
changePositionTo: aPosition 
	position := aPosition.! !

!Pacman methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:25:46'!
leavePosition
	game pacmanLeavesPositionAt: position.! !

!Pacman methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:47:39'!
moveDown
	game receivePacmanAt: self downPosition.! !

!Pacman methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:47:26'!
moveLeft
	game receivePacmanAt: self leftPosition
	! !

!Pacman methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:47:12'!
moveRight
	game receivePacmanAt: self rightPosition
	! !

!Pacman methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:47:59'!
moveUp
	game receivePacmanAt: self upPosition! !


!Pacman methodsFor: 'testing' stamp: 'PFU 11/22/2024 19:00:02'!
isPacman
	^ true.! !


!Pacman methodsFor: 'initialization' stamp: 'PFU 11/22/2024 19:28:56'!
initializeOn: aPacmanGame at: aPosition 
	game := aPacmanGame.
	position := aPosition.
	heading := HeadingLeft for: self.! !

!Pacman methodsFor: 'initialization' stamp: 'PFU 11/22/2024 21:11:18'!
saveInitialPosition
	game pacmanInitialPositionIs: position.! !


!classDefinition: #PacmanGameGhost category: #'2024-2C-Parcial-2'!
PacmanGameEntity subclass: #PacmanGameGhost
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGameGhost methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:27:17'!
leavePosition
	game ghostLeavesPositionAt: position.! !

!PacmanGameGhost methodsFor: 'moving' stamp: 'PFU 11/22/2024 21:08:31'!
receivePacman
	game ghostReceivedPacman! !


!classDefinition: #Blinky category: #'2024-2C-Parcial-2'!
PacmanGameGhost subclass: #Blinky
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Blinky methodsFor: 'initialization' stamp: 'PFU 11/22/2024 19:49:48'!
initializeOn: aPacmanGame at: aPosition 
	game := aPacmanGame.
	position := aPosition.
	heading := HeadingLeft for: self.! !


!Blinky methodsFor: 'testing' stamp: 'PFU 11/22/2024 19:00:20'!
isBlinky
	^ true.! !


!Blinky methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:51:58'!
moveDown
	game receiveBlinkyAt: self downPosition! !

!Blinky methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:50:16'!
moveLeft
	game receiveBlinkyAt: self leftPosition! !

!Blinky methodsFor: 'moving' stamp: 'PFU 11/22/2024 19:48:17'!
moveRight
	game receiveBlinkyAt: self rightPosition.! !

!Blinky methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:52:38'!
moveUp
	game receiveBlinkyAt: self upPosition! !


!classDefinition: #Clyde category: #'2024-2C-Parcial-2'!
PacmanGameGhost subclass: #Clyde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Clyde methodsFor: 'initialization' stamp: 'PFU 11/22/2024 19:49:53'!
initializeOn: aPacmanGame at: aPosition 
	game := aPacmanGame.
	position := aPosition.
	heading := HeadingRight for: self.! !


!Clyde methodsFor: 'testing' stamp: 'PFU 11/22/2024 19:00:11'!
isClyde
	^ true.! !


!Clyde methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:53:00'!
moveDown
	game receiveClydeAt: self downPosition! !

!Clyde methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:52:47'!
moveLeft
	game receiveClydeAt: self leftPosition! !

!Clyde methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:14:44'!
moveRight
	game receiveClydeAt: self rightPosition! !

!Clyde methodsFor: 'moving' stamp: 'PFU 11/22/2024 20:52:53'!
moveUp
	game receiveClydeAt: self upPosition! !


!classDefinition: #SmallPill category: #'2024-2C-Parcial-2'!
PacmanGameElement subclass: #SmallPill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!SmallPill methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:59:52'!
isSmallPill
	^ true! !


!SmallPill methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:54:40'!
receiveBlinky
	game smallPillReceivesBlinkyAt: position.! !

!SmallPill methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:21:46'!
receiveClyde
	game smallPillReceivesClydeAt: position.! !

!SmallPill methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:05:48'!
receivePacman
	game smallPillReceivesPacmanAt: position.! !


!classDefinition: #Space category: #'2024-2C-Parcial-2'!
PacmanGameElement subclass: #Space
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Space methodsFor: 'testing' stamp: 'PFU 11/22/2024 19:10:37'!
isSpace
	^ true! !


!Space methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:37:26'!
receiveBlinky
	game spaceReceivesEntityAt: position! !

!Space methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:37:30'!
receiveClyde
	game spaceReceivesEntityAt: position.! !

!Space methodsFor: 'receiving' stamp: 'PFU 11/22/2024 21:37:22'!
receivePacman
	game spaceReceivesEntityAt: position.! !


!classDefinition: #Wall category: #'2024-2C-Parcial-2'!
PacmanGameElement subclass: #Wall
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Wall methodsFor: 'testing' stamp: 'PFU 11/22/2024 18:55:09'!
isWall
	^true! !


!Wall methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:50:20'!
receiveBlinky
	game wallReceivesBlinkyAt: position.! !

!Wall methodsFor: 'receiving' stamp: 'PFU 11/22/2024 20:15:46'!
receiveClyde
	game wallReceivesClydeAt: position.! !

!Wall methodsFor: 'receiving' stamp: 'PFU 11/22/2024 19:20:53'!
receivePacman
	game wallReceivesPacmanAt: position.! !


!classDefinition: #StringPacmanBoard category: #'2024-2C-Parcial-2'!
Object subclass: #StringPacmanBoard
	instanceVariableNames: 'stringRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!StringPacmanBoard methodsFor: 'initialization' stamp: 'HAW 11/18/2024 19:29:26'!
initializeRepresentedAs: aStringRepresentation 
	
	stringRepresentation := aStringRepresentation.! !


!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:23:48'!
bigPillCharacter

	^self class bigPillCharacter! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:20'!
blinkyCharacter

	^ self class blinkyCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:30'!
clydeCharacter

	^ self class clydeCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:52'!
pacmanCharacter

	^ self class pacmanCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:25:15'!
smallPillCharacter

	^self class smallPillCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:25:37'!
spaceCharacter

	^self class spaceCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:26:00'!
wallCharacter

	^self class wallCharacter! !


!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:21'!
isBigPill: anElement

	^ anElement = self bigPillCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:36'!
isBlinky: anElement

	^ anElement = self blinkyCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:09'!
isClyde: anElement

	^ anElement = self clydeCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:17'!
isPacman: anElement

	^ anElement = self pacmanCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'PFU 11/22/2024 17:32:03'!
isSmallPill: anElement

	^ anElement = self smallPillCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:29'!
isSpace: anElement

	^ anElement = self spaceCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:03'!
isWall: anElement

	^ anElement = self wallCharacter! !


!StringPacmanBoard methodsFor: 'visiting' stamp: 'PFU 11/22/2024 17:32:04'!
visit: anElement at: position with: aPacmanBoardVisitor

	(self isWall: anElement) ifTrue: [ ^aPacmanBoardVisitor visitWallAt: position ].
	(self isSmallPill: anElement) ifTrue: [ ^aPacmanBoardVisitor visitSmallPillAt: position ].
	(self isBigPill: anElement) ifTrue: [ ^aPacmanBoardVisitor visitBigPillAt: position ].
	(self isBlinky: anElement) ifTrue: [ ^aPacmanBoardVisitor visitBlinkyAt: position ].
	(self isClyde: anElement) ifTrue: [ ^aPacmanBoardVisitor visitClydeAt: position ].
	(self isPacman: anElement) ifTrue: [ ^aPacmanBoardVisitor visitPacmanAt: position ].
	(self isSpace: anElement) ifTrue: [ ^aPacmanBoardVisitor visitSpaceAt: position ].
	
	"No hay necesidad de generar un error porque no se permite crear un board con caracteres distintos a todos estos - Hernan"! !

!StringPacmanBoard methodsFor: 'visiting' stamp: 'HAW 11/20/2024 17:22:41'!
visitElementsWith: aPacmanBoardVisitor

	stringRepresentation withIndexDo: [ :aRow :y |
		aRow withIndexDo: [ :anElement :x | 
			self visit: anElement at: x@y with: aPacmanBoardVisitor.]]! !


!StringPacmanBoard methodsFor: 'extent' stamp: 'HAW 11/22/2024 10:50:10'!
extent
	
	"There is always a row and their size is the same to all - Hernan"
	^stringRepresentation first size @ stringRepresentation size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StringPacmanBoard class' category: #'2024-2C-Parcial-2'!
StringPacmanBoard class
	instanceVariableNames: ''!

!StringPacmanBoard class methodsFor: 'instance creation' stamp: 'HAW 11/22/2024 10:48:32'!
representedAs: aStringRepresentation 
	
	| elementCharactersCount |
	
	elementCharactersCount := self elementCharacterCountOf: aStringRepresentation.	
	self asserltAllActorsAreIn: elementCharactersCount.
	"If I get here the there is always a row - Hernan"
	self assertAllRowsHaveSameSizeIn: aStringRepresentation.
	
	^self new initializeRepresentedAs: aStringRepresentation 
	! !


!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 16:58:30'!
characterIsMissingErrorDescriptionFor: aCharacterName
	
	^aCharacterName, ' is missing'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 17:39:12'!
notAllowCharaterErrorDescriptionFor: aCharacter

	^'Character ', aCharacter asString, ' is not allowed'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 17:07:31'!
rowsMustHaveSameSizeErrorDescription
	
	^'Rows must have same number of columns'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 16:58:01'!
shouldBeUniqueErrorDescriptionFor: aCharacterName
	
	^'There should be only one ', aCharacterName ! !


!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/21/2024 20:17:42'!
allowedCharacters
	
	^ {
	self pacmanCharacter.
	self blinkyCharacter.
	self clydeCharacter.
	self wallCharacter.
	self bigPillCharacter.
	self smallPillCharacter.
	self spaceCharacter.
	}! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:24:06'!
bigPillCharacter
	
	^ $*! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:56:25'!
blinkyCharacter
	
	^$B! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:56:42'!
clydeCharacter
	
	^$C! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:41:25'!
pacmanCharacter
	
	^$p! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:25:24'!
smallPillCharacter
	
	^ $-! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:25:46'!
spaceCharacter
	
	^ $=! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:26:06'!
wallCharacter
	
	^ $#! !


!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:12'!
blinkyName

	^ #blinky! !

!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:29'!
clydeName

	^ #clyde! !

!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:05'!
pacmanName

	^ #pacman! !


!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/21/2024 19:59:27'!
asserltAllActorsAreIn: elementCharactersCount

	{ self pacmanName. self blinkyName. self clydeName } do: [ :aCharacterName | 
		self assertActorIsCorrect: aCharacterName in: elementCharactersCount ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:04'!
assert: anElementCharacter isAllowed: allowedCharacters

	(allowedCharacters includes: anElementCharacter) ifFalse: [ self error: (self notAllowCharaterErrorDescriptionFor: anElementCharacter) ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:48:41'!
assertActorIsCorrect: aCharacterName in: elements 
	
	| characterIdentifier |
	
	characterIdentifier := self perform: (aCharacterName, #Character) asSymbol.
	(elements includes: characterIdentifier)
		ifFalse: [ self error: (self characterIsMissingErrorDescriptionFor: aCharacterName) ].
		
	(elements occurrencesOf: characterIdentifier) > 1
		ifTrue: [ self error: (self shouldBeUniqueErrorDescriptionFor: aCharacterName) ].
! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:16'!
assertAllRowsHaveSameSizeIn: aStringRepresentation

	(aStringRepresentation allSatisfy: [ :aRow | aRow size = aStringRepresentation first size ]) ifFalse: [ 
		self error: self rowsMustHaveSameSizeErrorDescription ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:30'!
elementCharacterCountOf: aStringRepresentation

	| elementCharactersCount allowedCharacters |
	
	elementCharactersCount := Bag new.
	allowedCharacters := self allowedCharacters.
	
	aStringRepresentation do: [ :aRow |
		aRow do: [ :anElementCharacter | 
			self assert: anElementCharacter isAllowed: allowedCharacters.
			elementCharactersCount add: anElementCharacter ]].
	
	^elementCharactersCount ! !
