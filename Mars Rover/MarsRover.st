!classDefinition: #TestMarsRover category: #MarsRover!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:05'!
test00MarsRoverStaysAtPositionWhenInitialized
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.
	
	"este test no agrega mucho valor desde el punto de vista de lo que TIENE que hacer el mars rover"
	
	self assert: (rover isFacingNorth).
	self assert: (rover isAt: startPosition).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:06'!
test01MarsRoverMovesForward
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'f'.
	
	self assert: (rover isAt: 2@3).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:06'!
test02MarsRoverMovesBackward
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'b'.
	
	self assert: (rover isAt: 2@1)
		
	
	
	
	! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:05'!
test02MarsRoverRotatesLeft
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'l'.
	
	self assert: (rover isFacingWest).
	
		! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:05'!
test03MarsRoverRotatesRight
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'r'.
	
	self assert: (rover isFacingEast).
	! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:05'!
test04MarsExecutesTwoCommandsInARow
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'ff'.
	
	self assert: (rover isAt: 2@4).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:06'!
test05RoverMovesTwiceWithDifferentDirections
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'frf'.
	
	self assert: (rover isAt: 3@3).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:16'!
test06RoverMovesTwiceWithDifferentDirections
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingSouth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'blf'.
	
	self assert: (rover isAt: 3@3).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:16:43'!
test07RoverMovesEastBackwardAndForward
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingEast new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'bf'.
	
	self assert: (rover isAt: startPosition ).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:27'!
test08RoverMovesWestBackwardAndForward
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingWest new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'bf'.
	
	self assert: (rover isAt: startPosition ).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:16'!
test09RoverMovesSouthBackwardAndForward
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingSouth new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'bf'.
	
	self assert: (rover isAt: startPosition ).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:27'!
test10RoverMovesNorthBackwardAndForward
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingWest new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'bf'.
	
	self assert: (rover isAt: startPosition ).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:27'!
test11InvalidInstruction
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingWest new.
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'fafffffffffffff'.
	
	self assert: (rover isAt: 1@2).! !

!TestMarsRover methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:17:27'!
test12CheckAllDirections
	|rover startPosition direction|
	startPosition := 2@2.
	direction := MarsRoverHeadingWest new.
	
	"con este test (un poco mejor hecho) se pueden testear todas las direcciones de una, incluso moviendose en el plano, no quedandose quieto"
	
	rover := MarsRover newAt: startPosition facingAt: direction.

	rover receiveCommandStream: 'lrfbrlrfbrlrfbrlfbrlrfb'.
	
	self assert: (rover isAt: 2@2).! !


!classDefinition: #TestMarsRoverElRegreso category: #MarsRover!
TestCase subclass: #TestMarsRoverElRegreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:30:41'!
test01LogPositionStartsEmpty
	|rover startPosition direction log |
	startPosition := 2@2.
	direction := MarsRoverHeadingNorth new.
	rover := MarsRover newAt: startPosition facingAt: direction.
	log := RoverLogObserver new.
	
	rover attach: log.
	
	self assert: log isEmpty.! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:33:20'!
test02LogKnowsLastPosition
	|rover log |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	log := RoverLogObserver new.
	rover attach: log.

	rover receiveCommandStream: 'ff'.

	self assert: log lastPosition equals: 2@4.! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:56:36'!
test03LogKnowsFirstMoveAndLast
	|rover log |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	log := RoverLogObserver new.
	rover attach: log.

	rover receiveCommandStream: 'ff'.

	self assert: (log positionNumber: 1) equals: 2@3.
	self assert: (log positionNumber: 2) equals: log lastPosition.! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:37:38'!
test04LogOnlyKnowsAboutOneRover
	|rover1 log rover2 |
	rover1 := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	rover2 := MarsRover newAt: 3@3 facingAt: MarsRoverHeadingEast new.
	log := RoverLogObserver new.
	
	rover1 attach: log.
	rover1 receiveCommandStream: 'ff'.
	rover2 receiveCommandStream: 'fff'.

	self deny: (log lastPosition = (6@3)).! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:40:51'!
test05LogKnowsLastDirection
	|rover1 log |
	rover1 := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	log := RoverLogObserver new.
	
	rover1 attach: log.
	rover1 receiveCommandStream: 'r'.

	self assert: log lastDirection isEast! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:42:00'!
test06LogKnowsASpecificDirection
	|rover1 log |
	rover1 := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	log := RoverLogObserver new.
	
	rover1 attach: log.
	rover1 receiveCommandStream: 'll'.

	self assert: (log directionNumber: 1) isWest! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:45:09'!
test07LogKnowsBothRotationAndDirection
	|rover1 log |
	rover1 := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	log := RoverLogObserver new.
	
	rover1 attach: log.
	rover1 receiveCommandStream: 'lf'.

	self assert: log lastDirection isWest.
	self assert: log lastPosition equals: 1@2.! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:57:24'!
test08WindowKnowsAboutLastPosition
	|rover window |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	window := RoverWindowObserver new.
	
	rover attach: window.
	rover receiveCommandStream: 'lf'.
	
	self assert: window lastPosition equals: 1@2.
	
	! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 19:57:50'!
test09WindowKnowsAboutLastDirection
	|rover window |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	window := RoverWindowObserver new.
	
	rover attach: window.
	rover receiveCommandStream: 'lf'.
	
	self assert: window lastDirection isWest
	
	! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 20:01:53'!
test10WindowDoesNotKnowAboutPreviousPosition
	|rover window |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	window := RoverWindowObserver new.
	
	rover attach: window.
	rover receiveCommandStream: 'ff'.
	
	self deny: (window lastPosition = (2@3)).
	
	! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 20:01:48'!
test11WindowDoesNotKnowAboutPreviousDirection
	|rover window |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	window := RoverWindowObserver new.
	
	rover attach: window.
	rover receiveCommandStream: 'll'.
	
	self deny: window lastDirection isWest
	
	! !

!TestMarsRoverElRegreso methodsFor: 'tests' stamp: 'PUF 11/12/2024 20:09:03'!
test12WindowCanBeEmptyWhenRoverDidNotMove
	|rover window |
	rover := MarsRover newAt: 2@2 facingAt: MarsRoverHeadingNorth new.
	window := RoverWindowObserver new.
	
	rover attach: window.
	
	self assert: window isEmpty
	
	! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction observers XXX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'PUF 11/12/2024 20:38:10'!
initializeAt: startPosition facingAt: aStartDirection 
	position := startPosition.
	direction := aStartDirection.
	observers := OrderedCollection new.
	XXX := RoverDecoratorForUpdates for: self.! !


!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:24'!
moveBackwardEast
	position := (position x - 1)@(position y).! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:27'!
moveBackwardNorth
	position := (position x)@(position y - 1).
! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:37'!
moveBackwardSouth
	position := (position x )@(position y+1).
! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:33'!
moveBackwardWest
	position := (position x + 1)@(position y).
	
! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:42'!
moveForwardEast
	position := (position x + 1)@(position y).! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:46'!
moveForwardNorth
	position := (position x)@(position y + 1).! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 20:27:53'!
moveForwardSouth
	position := (position x )@(position y-1).! !

!MarsRover methodsFor: 'moving' stamp: 'PUF 11/12/2024 21:30:11'!
moveForwardWest
	position := (position x - 1)@(position y).
! !


!MarsRover methodsFor: 'commands' stamp: 'PUF 10/11/2024 17:52:12'!
isValidCommand: aCommandToCheckValidity
	^#($f $b $l $r) includes: aCommandToCheckValidity.! !

!MarsRover methodsFor: 'commands' stamp: 'PUF 11/12/2024 20:45:31'!
moveBackward
	direction moveRoverBackward: self.! !

!MarsRover methodsFor: 'commands' stamp: 'PUF 11/12/2024 20:45:34'!
moveForward
	direction moveRoverForward: self.! !

!MarsRover methodsFor: 'commands' stamp: 'PUF 11/12/2024 20:45:15'!
receiveCommand: aCommand

	aCommand = $f ifTrue:[XXX moveForward].
	
	aCommand = $b ifTrue:[XXX moveBackward.].
	aCommand = $l ifTrue:[XXX rotateLeft.].
	aCommand = $r ifTrue:[XXX rotateRight.].! !

!MarsRover methodsFor: 'commands' stamp: 'PUF 10/11/2024 18:03:38'!
receiveCommandStream: aCommandStream 
	aCommandStream
		selectFirst: [ :each | self isValidCommand: each ]
		thenDo: [ :validCommand | self receiveCommand: validCommand ].! !

!MarsRover methodsFor: 'commands' stamp: 'PUF 11/12/2024 20:45:40'!
rotateLeft
	direction:=direction rotateLeft.! !

!MarsRover methodsFor: 'commands' stamp: 'PUF 11/12/2024 20:45:44'!
rotateRight
	direction:=direction rotateRight.! !


!MarsRover methodsFor: 'testing' stamp: 'PUF 10/8/2024 20:25:58'!
isAt: aPosition
	^aPosition = position.! !

!MarsRover methodsFor: 'testing' stamp: 'PUF 10/8/2024 21:16:39'!
isFacingEast
	^direction isEast! !

!MarsRover methodsFor: 'testing' stamp: 'PUF 10/8/2024 21:14:34'!
isFacingNorth
	^direction isNorth.! !

!MarsRover methodsFor: 'testing' stamp: 'PUF 10/8/2024 21:16:32'!
isFacingSouth
	^direction isSouth! !

!MarsRover methodsFor: 'testing' stamp: 'PUF 10/8/2024 21:16:00'!
isFacingWest
	^direction isWest.! !


!MarsRover methodsFor: 'observers' stamp: 'PUF 11/12/2024 20:44:55'!
attach: aMarsRoverObserver
	"should implement unattach, it looks for the observer in the collection and removes it"
	observers add: aMarsRoverObserver! !

!MarsRover methodsFor: 'observers' stamp: 'PUF 11/12/2024 19:55:56'!
updateDirection
	observers do: [:anObserver | anObserver updateDirection: direction ].
	! !

!MarsRover methodsFor: 'observers' stamp: 'PUF 11/12/2024 19:24:55'!
updatePosition
	observers do: [:anObserver | anObserver updatePosition: position].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'PUF 10/8/2024 20:05:01'!
newAt: startPosition facingAt: aStartDirection 
	^self new initializeAt: startPosition facingAt: aStartDirection ! !


!classDefinition: #MarsRoverDirection category: #MarsRover!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirection methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:05'!
isEast
	^false! !

!MarsRoverDirection methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:03'!
isNorth
	^false! !

!MarsRoverDirection methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:18:29'!
isSouth
	^false! !

!MarsRoverDirection methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:07'!
isWest
	^false! !


!classDefinition: #MarsRoverHeadingEast category: #MarsRover!
MarsRoverDirection subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingEast methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:17:05'!
rotateLeft
	^MarsRoverHeadingNorth new.! !

!MarsRoverHeadingEast methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:17:16'!
rotateRight
	^MarsRoverHeadingSouth new.! !


!MarsRoverHeadingEast methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:17'!
isEast
	^true.! !


!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'PUF 10/8/2024 21:07:34'!
moveRoverBackward: aMarsRover
	aMarsRover moveBackwardEast! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'PUF 10/8/2024 21:07:22'!
moveRoverForward: aMarsRover
	aMarsRover moveForwardEast! !


!classDefinition: #MarsRoverHeadingNorth category: #MarsRover!
MarsRoverDirection subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingNorth methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:17:27'!
rotateLeft
	^MarsRoverHeadingWest new.! !

!MarsRoverHeadingNorth methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:16:43'!
rotateRight
	^MarsRoverHeadingEast new.! !


!MarsRoverHeadingNorth methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:30'!
isNorth
	^true! !


!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'PUF 10/11/2024 17:35:58'!
moveRoverBackward: aMarsRover 
	aMarsRover moveBackwardNorth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'PUF 10/11/2024 17:36:29'!
moveRoverForward: aMarsRover 
	aMarsRover moveForwardNorth! !


!classDefinition: #MarsRoverHeadingSouth category: #MarsRover!
MarsRoverDirection subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingSouth methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:16:43'!
rotateLeft
	^MarsRoverHeadingEast new.! !

!MarsRoverHeadingSouth methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:17:27'!
rotateRight
	^MarsRoverHeadingWest new.! !


!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'PUF 10/11/2024 17:36:16'!
moveRoverBackward: aMarsRover 
	aMarsRover moveBackwardSouth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'PUF 10/11/2024 17:38:11'!
moveRoverForward: aMarsRover 
	aMarsRover moveForwardSouth! !


!MarsRoverHeadingSouth methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:38'!
isSouth
	^true.! !


!classDefinition: #MarsRoverHeadingWest category: #MarsRover!
MarsRoverDirection subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingWest methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:17:16'!
rotateLeft
	^MarsRoverHeadingSouth new.! !

!MarsRoverHeadingWest methodsFor: 'redirection' stamp: 'PUF 11/12/2024 19:17:05'!
rotateRight
	^MarsRoverHeadingNorth new.! !


!MarsRoverHeadingWest methodsFor: 'asserts' stamp: 'PUF 10/8/2024 21:15:45'!
isWest
	^true.! !


!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'PUF 10/11/2024 17:32:08'!
moveRoverBackward: aMarsRover 
	aMarsRover moveBackwardWest! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'PUF 10/11/2024 17:33:38'!
moveRoverForward: aMarsRover 
	aMarsRover moveForwardWest.! !


!classDefinition: #ObservedVariable category: #MarsRover!
Object subclass: #ObservedVariable
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!ObservedVariable methodsFor: 'as yet unclassified' stamp: 'PUF 11/13/2024 08:05:24'!
assign: aValue
"
target es el objeto que la esta usando.
esto es medio metaprogramacion, no es el objetivo de Variable. Lo dejo porque me gusto.


	target class compile: 
	'set: aValue
', name, ' := ', aValue.

	target perform: #set: with: aValue.
"	
	! !

!ObservedVariable methodsFor: 'as yet unclassified' stamp: 'PUF 11/13/2024 08:05:50'!
attach: anObserver
	observers add: anObserver! !

!ObservedVariable methodsFor: 'as yet unclassified' stamp: 'PUF 11/13/2024 08:03:22'!
set: aValue
	value := aValue.
	observers update: value.! !

!ObservedVariable methodsFor: 'as yet unclassified' stamp: 'PUF 11/13/2024 08:06:02'!
value
	^ value! !


!ObservedVariable methodsFor: 'initialization' stamp: 'PUF 11/12/2024 21:25:55'!
initializeNamed: aName for: anObject 
	name := aName.
	target := anObject.! !

!ObservedVariable methodsFor: 'initialization' stamp: 'PUF 11/13/2024 08:04:38'!
initializeValued: anInitialValue
	value := anInitialValue.
	observers := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObservedVariable class' category: #MarsRover!
ObservedVariable class
	instanceVariableNames: ''!

!ObservedVariable class methodsFor: 'instance creation' stamp: 'PUF 11/13/2024 08:04:06'!
valued: aValue
	^self new initializeValued: aValue! !


!classDefinition: #RoverDecoratorForUpdates category: #MarsRover!
Object subclass: #RoverDecoratorForUpdates
	instanceVariableNames: 'rover commandSideEffects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverDecoratorForUpdates methodsFor: 'as yet unclassified' stamp: 'PUF 11/12/2024 21:02:41'!
doesNotUnderstand: aMessage
	| sideEffect |
	aMessage sendTo: rover.
       
	sideEffect := (commandSideEffects at: aMessage selector ifAbsent: [nil]).
		
	sideEffect ifNotNil: [:effect | effect value].! !


!RoverDecoratorForUpdates methodsFor: 'initialization' stamp: 'PUF 11/12/2024 21:01:03'!
initializeFor: aRover
	rover := aRover.
	commandSideEffects := Dictionary newFrom: {
            #moveForward -> [rover updatePosition].
            #moveBackward -> [rover updatePosition].
            #rotateLeft -> [rover updateDirection].
            #rotateRight -> [rover updateDirection].
        }.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverDecoratorForUpdates class' category: #MarsRover!
RoverDecoratorForUpdates class
	instanceVariableNames: ''!

!RoverDecoratorForUpdates class methodsFor: 'instance creation' stamp: 'PUF 11/12/2024 20:43:04'!
for: aRover
	^self new initializeFor: aRover! !


!classDefinition: #RoverObserver category: #MarsRover!
Object subclass: #RoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 20:08:10'!
updateDirection: aDirection

	self subclassResponsibility! !

!RoverObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 20:08:06'!
updatePosition: aPosition

	self subclassResponsibility! !


!classDefinition: #RoverLogObserver category: #MarsRover!
RoverObserver subclass: #RoverLogObserver
	instanceVariableNames: 'positions directions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverLogObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 19:33:43'!
lastPosition
	^positions last! !

!RoverLogObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 19:34:55'!
positionNumber: aPositionNumber
	^ positions at: aPositionNumber.! !

!RoverLogObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 19:55:56'!
updateDirection: aDirection
	directions add: aDirection.! !

!RoverLogObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 19:28:26'!
updatePosition: aPosition
	positions add: aPosition.! !


!RoverLogObserver methodsFor: 'initialization' stamp: 'PUF 11/12/2024 19:30:29'!
initialize
	super initialize.
	positions := OrderedCollection new.
	directions := OrderedCollection new.! !


!RoverLogObserver methodsFor: 'testing' stamp: 'PUF 11/12/2024 20:04:14'!
isEmpty
	^ positions isEmpty and: [directions isEmpty]! !


!RoverLogObserver methodsFor: 'direction' stamp: 'PUF 11/12/2024 19:42:23'!
directionNumber: aDirectionNumber
	^ directions at: aDirectionNumber.! !

!RoverLogObserver methodsFor: 'direction' stamp: 'PUF 11/12/2024 19:41:07'!
lastDirection
	^ directions last! !


!classDefinition: #RoverWindowObserver category: #MarsRover!
RoverObserver subclass: #RoverWindowObserver
	instanceVariableNames: 'lastPosition lastDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverWindowObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 19:53:48'!
lastPosition
	^ lastPosition ! !

!RoverWindowObserver methodsFor: 'position' stamp: 'PUF 11/12/2024 19:54:26'!
updatePosition: aPosition
	lastPosition := aPosition.! !


!RoverWindowObserver methodsFor: 'initialization' stamp: 'PUF 11/12/2024 19:50:08'!
initialize
	super initialize.
	"tengo que ponerle algo a position / direction?"! !


!RoverWindowObserver methodsFor: 'testing' stamp: 'PUF 11/12/2024 20:08:41'!
isEmpty
	^ lastPosition isNil and: [lastDirection isNil]! !


!RoverWindowObserver methodsFor: 'direction' stamp: 'PUF 11/12/2024 19:54:08'!
lastDirection
	^ lastDirection! !

!RoverWindowObserver methodsFor: 'direction' stamp: 'PUF 11/12/2024 19:54:41'!
updateDirection: aDirection
	lastDirection := aDirection.! !
