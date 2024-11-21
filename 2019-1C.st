!classDefinition: #CalendarTest category: #'2019-1C'!
TestCase subclass: #CalendarTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test01CalendarIsBusyAtSameDateAndTimeOfEvent
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30.

	self assert: (calendar isBusyAt: November/11/2024 from: 9:00 to: 9:30)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test02CalendarIsFreeWhenEmpty
	| calendar |
	calendar := IndividualCalendar new.
	
	self assert: (calendar isFreeAt: November/11/2024 from: 9:00 to: 9:30).! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test03CalendarIsBusyIfMeetingsHaveACoincidenceInTime
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30.

		
	self assert: (calendar isBusyAt: November/11/2024 from: 9:10 to: 9:15)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test04CalendarIsFreeIfMeetingsDoNotHaveACoincidenceInTime
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30.

		
	self assert: (calendar isFreeAt: November/11/2024 from: 9:30 to: 9:40)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test05CalendarIsFreeIfMeetingsDifferInDate
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30.
		
	self assert: (calendar isFreeAt: November/12/2024 from: 9:00 to: 9:30)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test06CalendarIsFreeAtPreviousDateForRepeatedEvent
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30 repeatingEvery: 1*day upTo: November/13/2024.

		
	self assert: (calendar isFreeAt: November/1/2024 from: 9:00 to: 9:30)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test07CalendarIsFreeForRepeatingEventAfterItHasEnded
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30 repeatingEvery: 1*day upTo: November/13/2024.

		
	self assert: (calendar isFreeAt: November/29/2024 from: 9:00 to: 9:30)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test08CalendarIsBusyAtNextDateWhenItHasARepeatedEvent
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30 repeatingEvery: 1*day upTo: November/13/2024.

		
	self assert: (calendar isBusyAt: November/12/2024 from: 9:00 to: 9:30)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test09CalendarIsFreeAtNextDateButDifferentTimeWhenItHasARepeatedEvent
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30 repeatingEvery: 1*day upTo: November/13/2024.

		
	self assert: (calendar isFreeAt: November/12/2024 from: 9:45 to: 9:50)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test10CalendarIsBusyAtVeryFarAwayEvent
	
	| calendar |
	calendar := IndividualCalendar new.
	
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30 repeatingEvery: 1*day upTo: FixedGregorianDate theEndOfTime .

		
	self assert: (calendar isBusyAt: November/12/2090 from: 9:15 to: 9:21)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test11CalendarCanGetNextFreeSpotWhenItsEmpty
	
	| calendar spot |
	calendar := IndividualCalendar new.
	
	spot := calendar nextFreeSpotAt: November/12/2024 startingAt: 9:00 orAsLateAs: 11:00 lasting: 1*hour upTo: November/14/2024.
	self assert: (spot isAt: November/12/2024 from: 9:00 to:10:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test12CalendarNextFreeSpotIsSameDayIfEventsEndBeforeRequestedSpot
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/1/2024 from: 9:00 to: 9:30.

	
	spot := calendar nextFreeSpotAt: November/12/2024 startingAt: 10:00 orAsLateAs: 11:00 lasting: 1*hour upTo: November/14/2024.
	self assert: (spot isAt: November/12/2024 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test13CalendarNextFreeSpotIsSameDayIfEventsStartAfterRequestedSpot
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/29/2024 from: 9:00 to: 9:30.

	
	spot := calendar nextFreeSpotAt: November/12/2024 startingAt: 9:00 orAsLateAs: 11:00 lasting: 1*hour upTo: November/14/2024.
	self assert: ((spot) isAt: November/12/2024 from: 9:00 to: 10:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test14CalendarRequestedEventFreeSpotCoincidesWithExistingEventsDate
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := calendar nextFreeSpotAt: November/10/2024 startingAt: 11:00 orAsLateAs: 12:00 lasting: 1*hour upTo: November/14/2024.
	self assert: ((spot) isAt: November/10/2024 from: 11:00 to: 12:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test15RequestedSpotCoincidesWithExistingEventsDateAndStartTime
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/1/2024 from: 10:00 to: 11:00.

	spot := calendar nextFreeSpotAt: November/1/2024 startingAt: 10:00 orAsLateAs: 12:00 lasting: 1*hour upTo: November/2/2024.
	
	self assert: (spot isAt: November/1/2024 from: 11:00 to: 12:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test16RequestedSpotCoincidesWithExistingEvent
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := calendar nextFreeSpotAt: November/10/2024 startingAt: 9:00 orAsLateAs: 9:00 lasting: 30*minute upTo: November/14/2024.
	
	self assert: (spot isAt: November/11/2024 from: 9:00 to: 9:30).! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test17RequestedFreeSpotCoincidesWithExistingEventsDateButFits
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := calendar nextFreeSpotAt: November/10/2024 startingAt: 9:00 orAsLateAs: 10:00 lasting: 30*minute upTo: November/14/2024.
	self assert: (spot isAt:November/10/2024 from: 9:30 to: 10:00).! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test18RequestedSpotCoincidesWithExistingEventsDateButDoesNotFitBecauseOfDuration
	
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := calendar nextFreeSpotAt: November/10/2024 startingAt: 9:00 orAsLateAs: 9:30 lasting: 1*hour upTo: November/14/2024.
	
	self assert: (spot isAt: November/11/2024 from: 9:00 to: 10:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test19NoFreeSpot
	
	| calendar |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	self should: [calendar nextFreeSpotAt: November/10/2024 startingAt: 9:00 orAsLateAs: 9:00 lasting: 30*minute upTo: November/10/2024 ifNone: [self error: 'No free spots']]
	
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'No free spots']
	
! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test20NoFreeSpotWithMultipleEvents
	
	| calendar |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.
	calendar addEventAt: November/11/2024 from: 9:00 to: 9:30.
	calendar addEventAt: November/12/2024 from: 9:00 to: 9:30.
	
	self should: [calendar nextFreeSpotAt: November/10/2024 startingAt: 9:00 orAsLateAs: 9:00 lasting: 30*minute upTo: November/12/2024 ifNone: [self error: 'No free spots']]
	
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'No free spots']
	
! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:14:59'!
test21GroupCalendarIsFreeIfHasNoCalendars
	| groupCalendar |
	
	groupCalendar := GroupCalendar new.
	
	self assert: (groupCalendar isFreeAt: November/1/2024 from: 9:00 to: 10:00)
	
	
! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test22GroupCalendarIsBusyIfOneOfItsCalendarsIsBusy
	| groupCalendar otherCalendar pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	otherCalendar := IndividualCalendar new.
	
	pepeCalendar addEventAt: November/1/2024 from: 9:00 to: 	10:00.

	groupCalendar := GroupCalendar with: (OrderedCollection withAll: {pepeCalendar. otherCalendar}).
	
	self assert: (groupCalendar isBusyAt: November/1/2024 from: 9:00 to: 	10:00).
	self assert: (pepeCalendar isBusyAt: November/1/2024 from: 9:00 to: 	10:00).

! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 10:24:12'!
test23EventThatIsAddedToGroupCalendarIsAddedToIndividualCalendars
	| groupCalendar otherCalendar pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	otherCalendar := IndividualCalendar new.
	
	groupCalendar := GroupCalendar with: (OrderedCollection withAll: {pepeCalendar. otherCalendar}).
	groupCalendar addEvent: (SingleEvent at: November/1/2024 from: 9:00 to: 	10:00).

	self assert: (pepeCalendar isBusyAt: November/1/2024 from: 9:00 to: 	10:00).
	self assert: (otherCalendar isBusyAt: November/1/2024 from: 9:00 to: 	10:00).


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:38:21'!
test24WeeklyRepeatingEventIsFreeBeforeStart
	| pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	
	pepeCalendar addEvent: (WeeklyEvent at: July/1/2024 from: 10:00 to: 11:00 repeatingEvery: {Monday. Thursday} upTo: September/1/2024).
	
	self assert: (pepeCalendar isFreeAt: July/1/2023 from: 10:00 to: 11:00)


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:38:30'!
test25WeeklyRepeatingEventIsFreeAfterEnd
	| pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	
	pepeCalendar addEvent: (WeeklyEvent at: July/1/2024 from: 10:00 to: 11:00 repeatingEvery: {Monday. Thursday} upTo: September/1/2024).
	
	self assert: (pepeCalendar isFreeAt: July/1/2025 from: 10:00 to: 11:00)


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:37:51'!
test26WeeklyRepeatingEventIsBusyAtStartOfEvent
	| pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	
	pepeCalendar addEvent: (WeeklyEvent at: July/1/2024 from: 10:00 to: 11:00 repeatingEvery: {Monday. Thursday} upTo: September/1/2024).
	
	self assert: (pepeCalendar isBusyAt: July/1/2024 from: 10:00 to: 11:00)


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:38:50'!
test27WeeklyRepeatingEventIsFreeIfEndDateIsNotInRepeatingWeekDays
	| pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	
	pepeCalendar addEvent: (WeeklyEvent at: July/1/2024 from: 10:00 to: 11:00 repeatingEvery: {Monday. Thursday} upTo: September/1/2024).
	
	self assert: (pepeCalendar isFreeAt: September/1/2024 from: 10:00 to: 11:00)


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:39:34'!
test28WeeklyRepeatingEventIsBusyIfEndDateIsInRepeatingWeekDays
	| pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	
	pepeCalendar addEvent: (WeeklyEvent at: July/1/2024 from: 10:00 to: 11:00 repeatingEvery: {Monday. Thursday} upTo: August/29/2024).
	
	self assert: (pepeCalendar isBusyAt: August/29/2024 from: 10:00 to: 10:30)


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:40:04'!
test29WeeklyRepeatingEventIsBusyAtARepetitionInTheMiddle
	| pepeCalendar |
	pepeCalendar := IndividualCalendar new.
	
	pepeCalendar addEvent: (WeeklyEvent at: July/1/2024 from: 10:00 to: 11:00 repeatingEvery: {Monday. Thursday} upTo: August/29/2024).
	
	self assert: (pepeCalendar isBusyAt: August/1/2024 from: 10:00 to: 10:30)


! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 11:46:31'!
test30GroupCalendarNextFreeSpot
	| groupCalendar otherCalendar pepeCalendar spot |
	pepeCalendar := IndividualCalendar new.
	otherCalendar := IndividualCalendar new.
	
	pepeCalendar addEventAt: November/1/2024 from: 9:00 to: 	10:00.

	groupCalendar := GroupCalendar with: (OrderedCollection withAll: {pepeCalendar. otherCalendar}).
	
	spot := groupCalendar nextFreeSpotAt: November/1/2024 startingAt: 9:00 orAsLateAs: 11:00 lasting: 30*minute upTo: November/1/2024 ifNone: [self fail].
	
	self assert: (spot isAt: November/1/2024 from: 10:00 to: 10:30)
! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 12:18:08'!
test31NextSpotSearchingEvery30minutes
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := (CalendarSpotFinder for: calendar at: November/10/2024 upTo: November/10/2024 startingOn: 9:15 orAsLateAs: 11:15 lasting: 1*hour searchingEvery: 30*minute ifNone: [self fail]) find.
	
	self assert: (spot isAt: November/10/2024 from: 9:45 to: 10:45).! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 12:19:38'!
test32NextSpotSearchingEveryMinuteFindsTheVeryExactFreeMinute
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:37.

	
	spot := (CalendarSpotFinder for: calendar at: November/10/2024 upTo: November/10/2024 startingOn: 9:15 orAsLateAs: 11:15 lasting: 1*hour searchingEvery: 1*minute ifNone: [self fail]) find.
	
	self assert: (spot isAt: November/10/2024 from: 9:37 to: 10:37).! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 12:24:00'!
test33NextSpotSearchingAvoidingNoWeekDaysFindsAnyNextSpot
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := (CalendarSpotFinder for: calendar at: November/10/2024 upTo: November/10/2024 startingOn: 9:15 orAsLateAs: 11:15 lasting: 1*hour searchingEvery: 30*minute avoiding: {} ifNone: [self fail]) find.
	
	self assert: (spot isAt: November/10/2024 from: 9:45 to: 10:45).! !

!CalendarTest methodsFor: 'tests' stamp: 'PFU 11/21/2024 12:30:05'!
test34NextSpotSearchingAvoidingWeekendsFindsASpotOnANonWeekendDay
	| calendar spot |
	calendar := IndividualCalendar new.
	calendar addEventAt: November/10/2024 from: 9:00 to: 9:30.

	
	spot := (CalendarSpotFinder for: calendar at: November/9/2024 upTo: November/11/2024 startingOn: 9:15 orAsLateAs: 11:15 lasting: 1*hour searchingEvery: 30*minute avoiding: {Saturday. Sunday.} ifNone: [self fail]) find.
	
	self assert: (spot isAt: November/11/2024 from: 9:15 to: 10:15).! !


!classDefinition: #Calendar category: #'2019-1C'!
Object subclass: #Calendar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!Calendar methodsFor: 'accessing' stamp: 'PFU 11/21/2024 10:22:46'!
isBusyAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility! !

!Calendar methodsFor: 'accessing' stamp: 'PFU 11/21/2024 10:22:50'!
isFreeAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility! !


!Calendar methodsFor: 'adding' stamp: 'PFU 11/21/2024 10:22:56'!
addEvent: anEvent

	self subclassResponsibility! !


!Calendar methodsFor: 'testing' stamp: 'PFU 11/21/2024 12:12:17'!
nextFreeSpotAt: aStartDate startingAt: aStartTime orAsLateAs: aLatestStartTime lasting: aDuration upTo: anEndDate
	^ self nextFreeSpotAt: aStartDate startingAt: aStartTime orAsLateAs: aLatestStartTime lasting: aDuration upTo: anEndDate
	ifNone: [self error: 'No free spots']! !

!Calendar methodsFor: 'testing' stamp: 'PFU 11/21/2024 12:12:17'!
nextFreeSpotAt: aStartDate startingAt: aStartTime orAsLateAs: aLatestStartTime lasting: aDuration upTo: anEndDate ifNone: noneBlock
	^(CalendarSpotFinder 
		for: self 
		at: aStartDate
		upTo: anEndDate
		startingOn: aStartTime
		orAsLateAs: aLatestStartTime
		lasting: aDuration 
		ifNone: noneBlock) find
		! !


!classDefinition: #GroupCalendar category: #'2019-1C'!
Calendar subclass: #GroupCalendar
	instanceVariableNames: 'calendars'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!GroupCalendar methodsFor: 'initialization' stamp: 'PFU 11/21/2024 10:22:39'!
initialize
	super initialize.
	calendars := OrderedCollection new.
! !

!GroupCalendar methodsFor: 'initialization' stamp: 'PFU 11/21/2024 10:04:41'!
initializeWith: aCalendarCollection
	calendars := aCalendarCollection.! !


!GroupCalendar methodsFor: 'accessing' stamp: 'PFU 11/21/2024 10:16:28'!
isBusyAt: aDate from: aStartTime to: anEndTime 
	^ calendars anySatisfy: [:aCalendar | aCalendar isBusyAt: aDate from: aStartTime to: anEndTime].! !

!GroupCalendar methodsFor: 'accessing' stamp: 'PFU 11/21/2024 10:15:54'!
isFreeAt: aDate from: aStartTime to: anEndTime 
	^ calendars allSatisfy: [:aCalendar | aCalendar isFreeAt: aDate from: aStartTime to: anEndTime].! !


!GroupCalendar methodsFor: 'adding' stamp: 'PFU 11/21/2024 10:21:47'!
addEvent: anEvent 
	calendars do: [:aCalendar | aCalendar addEvent: anEvent]! !



"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GroupCalendar class' category: #'2019-1C'!
GroupCalendar class
	instanceVariableNames: ''!

!GroupCalendar class methodsFor: 'instance creation' stamp: 'PFU 11/21/2024 10:04:26'!
with: aCalendarCollection
	^ self new initializeWith: aCalendarCollection.! !


!classDefinition: #IndividualCalendar category: #'2019-1C'!
Calendar subclass: #IndividualCalendar
	instanceVariableNames: 'responsible events'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!IndividualCalendar methodsFor: 'initialization' stamp: 'PFU 11/21/2024 10:25:01'!
initialize
	super initialize.
	events := OrderedCollection new.! !


!IndividualCalendar methodsFor: 'events' stamp: 'PFU 11/21/2024 08:38:45'!
addEvent: anEvent
	events add: anEvent! !

!IndividualCalendar methodsFor: 'events' stamp: 'PFU 11/21/2024 07:37:22'!
addEventAt: aDate from: aStartTime to: anEndTime
	events add: (SingleEvent at: aDate from: aStartTime to: anEndTime)! !

!IndividualCalendar methodsFor: 'events' stamp: 'PFU 11/20/2024 20:33:47'!
addEventAt: anEventDate from: aStartTime to: anEndTime repeatingEvery: aRepetitionFrequency upTo: anEndDate 
	events add: (RepeatingEvent at: anEventDate from: aStartTime to: anEndTime repeatingEvery: aRepetitionFrequency upTo: anEndDate)! !


!IndividualCalendar methodsFor: 'testing' stamp: 'PFU 11/20/2024 20:07:50'!
isBusyAt: aDate from: aStartTime to: anEndTime

	^events anySatisfy: [:anEvent | anEvent isBusyAt: aDate from: aStartTime to: anEndTime]! !

!IndividualCalendar methodsFor: 'testing' stamp: 'PFU 11/20/2024 20:38:05'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^events allSatisfy: [:anEvent | anEvent isFreeAt: aDate from: aStartTime to: anEndTime]! !



!classDefinition: #CalendarSpotFinder category: #'2019-1C'!
Object subclass: #CalendarSpotFinder
	instanceVariableNames: 'calendar startDate endDate noneBlock latestStartTime duration startTime currentDate currentTime timeStep weekDaysToAvoid'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!CalendarSpotFinder methodsFor: 'initialization' stamp: 'PFU 11/21/2024 12:28:25'!
initializeFor: aCalendar at: aStartDate upTo: anEndDate startingOn: aStartTime orAsLateAs: aLatestStartTime lasting: aDuration searchingEvery: aTimeStep avoiding: aWeekDaysCollection ifNone: aNoneBlock

	calendar := aCalendar.
	startDate := aStartDate.
	endDate := anEndDate.
	startTime := aStartTime.
	latestStartTime := aLatestStartTime.
	duration := aDuration.
	timeStep := aTimeStep.
	weekDaysToAvoid := aWeekDaysCollection.
	noneBlock := aNoneBlock.

	! !


!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 10:39:10'!
currentSpot

	^ SingleEvent at: currentDate from: currentTime to: (currentTime next: duration)! !

!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 12:16:16'!
find
	currentDate := startDate.
	currentTime := startTime.

	self moveToNextFreeSpot.
	
	^ self currentSpot.! !

!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 12:33:41'!
isCurrentEventFreeInCalendar

	^ calendar isFreeAt: currentDate from: currentTime to: (currentTime next: duration)! !

!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 12:33:49'!
isCurrentEventValid

	^ self isCurrentEventFreeInCalendar and: [self isValidWeekDay]! !

!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 12:34:58'!
isValidWeekDay
	^ weekDaysToAvoid noneSatisfy: [:aWeekDay | currentDate day = aWeekDay]! !

!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 10:36:45'!
reachedMaxDate

	^ currentDate > endDate! !

!CalendarSpotFinder methodsFor: 'evaluating' stamp: 'PFU 11/21/2024 12:34:29'!
shouldMoveToNextDay

	^ currentTime > latestStartTime or: self isValidWeekDay not .! !


!CalendarSpotFinder methodsFor: 'moving' stamp: 'PFU 11/21/2024 12:25:15'!
moveToNextDay

	currentTime := startTime. 
	currentDate := currentDate next! !

!CalendarSpotFinder methodsFor: 'moving' stamp: 'PFU 11/21/2024 12:33:20'!
moveToNextFreeSpot

	[self isCurrentEventValid] whileFalse: [
			self moveToNextTime.
			self shouldMoveToNextDay ifTrue: [self moveToNextDay.].
			self reachedMaxDate ifTrue: [noneBlock value].

		]! !

!CalendarSpotFinder methodsFor: 'moving' stamp: 'PFU 11/21/2024 12:08:37'!
moveToNextTime

	^ currentTime := currentTime next: timeStep.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CalendarSpotFinder class' category: #'2019-1C'!
CalendarSpotFinder class
	instanceVariableNames: ''!

!CalendarSpotFinder class methodsFor: 'instance creation' stamp: 'PFU 11/21/2024 12:21:53'!
for: aCalendar at: aStartDate upTo: anEndDate startingOn: anAStartTime orAsLateAs: aLatestStartTime lasting: aDuration ifNone: aNoneBlock
	"this ignores the timestep, setting it the same as duration. This is to allow clients to search without time step with transparency"

	^self new 
	initializeFor: aCalendar 
	at: aStartDate 
	upTo: anEndDate 
	startingOn: anAStartTime 
	orAsLateAs: aLatestStartTime 
	lasting: aDuration 
	searchingEvery: aDuration 
	avoiding: {} 
	ifNone: aNoneBlock! !

!CalendarSpotFinder class methodsFor: 'instance creation' stamp: 'PFU 11/21/2024 12:21:28'!
for: aCalendar at: aStartDate upTo: anEndDate startingOn: anAStartTime orAsLateAs: aLatestStartTime lasting: aDuration searchingEvery: aTimeStep avoiding: aWeekDaysCollection ifNone: aNoneBlock
	^self new 
	initializeFor: aCalendar 
	at: aStartDate 
	upTo: anEndDate 
	startingOn: anAStartTime 
	orAsLateAs: aLatestStartTime 
	lasting: aDuration 
	searchingEvery: aTimeStep 
	avoiding: aWeekDaysCollection ifNone: aNoneBlock! !

!CalendarSpotFinder class methodsFor: 'instance creation' stamp: 'PFU 11/21/2024 12:21:49'!
for: aCalendar at: aStartDate upTo: anEndDate startingOn: anAStartTime orAsLateAs: aLatestStartTime lasting: aDuration searchingEvery: aTimeStep ifNone: aNoneBlock
	^self new 
	initializeFor: aCalendar 
	at: aStartDate 
	upTo: anEndDate 
	startingOn: anAStartTime 
	orAsLateAs: aLatestStartTime 
	lasting: aDuration 
	searchingEvery: aTimeStep 
	avoiding: {} 
	ifNone: aNoneBlock! !


!classDefinition: #Event category: #'2019-1C'!
Object subclass: #Event
	instanceVariableNames: 'startTime endTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!Event methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:37:53'!
isBusyAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility! !

!Event methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:40:03'!
isFreeAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility! !

!Event methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:43:53'!
timeCoincidesWith: aTime

	self subclassResponsibility! !

!Event methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:44:01'!
timeCoincidesWith: aTime or: anotherTime

	self subclassResponsibility! !


!classDefinition: #RepeatingEvent category: #'2019-1C'!
Event subclass: #RepeatingEvent
	instanceVariableNames: 'timeInterval'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!RepeatingEvent methodsFor: 'initialization' stamp: 'PFU 11/21/2024 08:30:20'!
initializeAt: aStartDate from: aStartTime to: anEndTime repeatingEvery: aRepetitionFrequency upTo: anEndDate 
	
	timeInterval := aStartDate to: anEndDate by: aRepetitionFrequency.
	startTime := aStartTime.
	endTime := anEndTime.! !


!RepeatingEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 08:29:34'!
hasARepetitionAt: aDate

	^ timeInterval includes: aDate! !

!RepeatingEvent methodsFor: 'accessing' stamp: 'PFU 11/20/2024 21:07:02'!
isBusyAt: aDate from: aStartTime to: anEndTime 
	^ (self hasARepetitionAt: aDate) and: [self timeCoincidesWith: aStartTime or: anEndTime]! !

!RepeatingEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:40:03'!
isFreeAt: aDate from: aStartTime to: anEndTime 	
	^ (self isBusyAt: aDate from: aStartTime to: anEndTime) not! !

!RepeatingEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:43:53'!
timeCoincidesWith: aTime

	^ startTime <= aTime and: [aTime < endTime]! !

!RepeatingEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:44:01'!
timeCoincidesWith: aTime or: anotherTime

	^ (self timeCoincidesWith: aTime) or: [self timeCoincidesWith: anotherTime]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RepeatingEvent class' category: #'2019-1C'!
RepeatingEvent class
	instanceVariableNames: ''!

!RepeatingEvent class methodsFor: 'instance creation' stamp: 'PFU 11/20/2024 20:34:01'!
at: anEventDate from: aStartTime to: anEndTime repeatingEvery: aRepetitionFrequency upTo: anEndDate 
	^self new initializeAt: anEventDate from: aStartTime to: anEndTime repeatingEvery: aRepetitionFrequency upTo: anEndDate ! !


!classDefinition: #SingleEvent category: #'2019-1C'!
Event subclass: #SingleEvent
	instanceVariableNames: 'startDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!SingleEvent methodsFor: 'initialization' stamp: 'PFU 11/21/2024 07:38:33'!
initializeAt: aDate from: aStartTime to: anEndTime 
	startDate := aDate.
	startTime := aStartTime.
	endTime := anEndTime.! !


!SingleEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 08:47:28'!
isAt: aDate from: aStartTime to: anEndTime 
	^ aDate = startDate and: [aStartTime = startTime and: [anEndTime = endTime ]]! !

!SingleEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:38:33'!
isBusyAt: aDate from: aStartTime to: anEndTime 
	
	^ aDate = startDate and: [self timeCoincidesWith: aStartTime or: anEndTime]! !

!SingleEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:40:03'!
isFreeAt: aDate from: aStartTime to: anEndTime 	
	^ (self isBusyAt: aDate from: aStartTime to: anEndTime) not! !

!SingleEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:43:53'!
timeCoincidesWith: aTime

	^ startTime <= aTime and: [aTime < endTime]! !

!SingleEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 07:44:01'!
timeCoincidesWith: aTime or: anotherTime

	^ (self timeCoincidesWith: aTime) or: [self timeCoincidesWith: anotherTime]! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SingleEvent class' category: #'2019-1C'!
SingleEvent class
	instanceVariableNames: ''!

!SingleEvent class methodsFor: 'instance creation' stamp: 'PFU 11/20/2024 20:09:43'!
at: aDate from: aStartTime to: anEndTime 
	
	^self new initializeAt: aDate from: aStartTime to: anEndTime ! !


!classDefinition: #WeeklyEvent category: #'2019-1C'!
Event subclass: #WeeklyEvent
	instanceVariableNames: 'startDate weekDays endDate timeIntervals'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2019-1C'!

!WeeklyEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 11:33:51'!
hasARepetitionAt: aDate
	^ timeIntervals anySatisfy: [:aTimeInterval | aTimeInterval includes: aDate]
	! !

!WeeklyEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 11:13:17'!
isBusyAt: aDate from: aStartTime to: anEndTime
	^ (self hasARepetitionAt: aDate) and: [self timeCoincidesWith: aStartTime or: anEndTime]! !

!WeeklyEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 11:36:03'!
isFreeAt: aDate from: aStartTime to: anEndTime 	
	^ (self isBusyAt: aDate from: aStartTime to: anEndTime) not! !

!WeeklyEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 11:14:35'!
timeCoincidesWith: aTime

	^ startTime <= aTime and: [aTime < endTime]! !

!WeeklyEvent methodsFor: 'accessing' stamp: 'PFU 11/21/2024 11:14:26'!
timeCoincidesWith: aTime or: anotherTime

	^ (self timeCoincidesWith: aTime) or: [self timeCoincidesWith: anotherTime]! !


!WeeklyEvent methodsFor: 'initialization' stamp: 'PFU 11/21/2024 11:32:26'!
computeTimeIntervalsFrom: aWeekDayCollection startingOn: aStartDate endingOn: anEndDate

	timeIntervals := OrderedCollection new.
	
	aWeekDayCollection do: [:aWeekDay | timeIntervals add: (self timeIntervalFor: aWeekDay startingOn: aStartDate endingOn: anEndDate)].
	! !

!WeeklyEvent methodsFor: 'initialization' stamp: 'PFU 11/21/2024 11:32:38'!
initializeAt: aStartDate from: aStartTime to: anEndTime repeatingEvery: aWeekDayCollection upTo: anEndDate 
	startTime := aStartTime.
	endTime := anEndTime.
	
	self computeTimeIntervalsFrom: aWeekDayCollection startingOn: aStartDate endingOn: anEndDate.! !

!WeeklyEvent methodsFor: 'initialization' stamp: 'PFU 11/21/2024 11:32:19'!
timeIntervalFor: aWeekDay startingOn: aStartDate endingOn: anEndDate
	|intervalStartDate|

	intervalStartDate := (aStartDate day = aWeekDay) ifTrue: [aStartDate] ifFalse: [aStartDate nextDay: aWeekDay].
	
	^ intervalStartDate to: anEndDate by: 1*week.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WeeklyEvent class' category: #'2019-1C'!
WeeklyEvent class
	instanceVariableNames: ''!

!WeeklyEvent class methodsFor: 'instance creation' stamp: 'PFU 11/21/2024 11:11:20'!
at: aStartDate from: aStartTime to: anEndTime repeatingEvery: aWeekDay upTo: anEndDate 
	^self new initializeAt: aStartDate from: aStartTime to: anEndTime repeatingEvery: aWeekDay upTo: anEndDate ! !
