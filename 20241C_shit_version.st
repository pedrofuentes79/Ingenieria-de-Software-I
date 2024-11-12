!classDefinition: #TaskTest category: #'20241C'!
TestCase subclass: #TaskTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!


!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:31:24'!
dashboard: aStartDate

	^ Task named: 'Dashboard Dark Vessels' effort: 10 * hour startingAt: aStartDate dependingOn: Set new! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:31:00'!
pfuentes

	^ Developer named: 'pfuentes' working: 6 * hour / day gettingPaid: 1000 * peso / hour! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:31:00'!
test01ATaskCanComputeItsEndTimeForADev

	| task dev startDate |
	startDate := November / 4 / 2024.
	task := Task named: 'Documentacion Dark Vessels' effort: 3 * hour startingAt: startDate dependingOn: Set new.
	
	dev := self pfuentes.
	
	task assignTo: dev.
	
	self assert: (task end) equals: startDate.! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:31:00'!
test02ATaskCanEndOnNextDay

	| task dev startDate |
	startDate := November / 4 / 2024.
	task := Task named: 'Documentacion Dark Vessels' effort: 12 * hour startingAt: startDate dependingOn: Set new.
	
	dev := self pfuentes.
	
	task assignTo: dev.
	
	self assert: task end equals: startDate next.! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:26:19'!
test03ATaskCannotHaveAnEndDateWithoutAnAssignee

	| task startDate |
	startDate := November / 4 / 2024.
	task := Task named: 'Documentacion Dark Vessels' effort: 12 * hour startingAt: startDate dependingOn: Set new.

	
	self should: [task end]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: Task noAssignedDevError.
		].
! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:31:13'!
test04ATaskKnowsItsCost
	| task dev startDate |
	startDate := November / 4 / 2024.
	task := self dashboard: startDate.
	
	dev := self pfuentes.
	
	task assignTo: dev.
	
	self assert: (task cost) equals: 12000 * peso.! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:31:13'!
test05TaskCantEndIfItsDependenciesArentFinished
	| dev startDate dashboard documentacion |
	startDate := November / 4 / 2024.
	
	dashboard := self dashboard: startDate.
	documentacion := Task named: 'Documentacion Dark Vessels' effort: 10 * hour startingAt: startDate dependingOn: (Set with: dashboard).
	dev := self pfuentes.
	
	dashboard assignTo: dev.
	documentacion assignTo: dev.
	
	self should: [documentacion end]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: error messageText equals: Task unfinishedDependenciesError.
		]! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:45:20'!
test06TaskCanEndIfItsDependenciesHaveFinished
	| dev startDate dashboard documentacion dashboardEndDate |
	startDate := November / 4 / 2024.
	
	dashboard := self dashboard: startDate.
	documentacion := Task named: 'Documentacion Dark Vessels' effort: 10 * hour startingAt: startDate dependingOn: (Set with: dashboard).
	dev := self pfuentes.
	
	dashboard assignTo: dev.
	documentacion assignTo: dev.
	
	dashboardEndDate := dashboard end.
	self assert: (documentacion endStartingAt: dashboardEndDate next) equals: (November / 7 / 2024)! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 15:48:15'!
test07TaskCannotStartBeforeStartDate
	| dev startDate dashboard documentacion dashboardEndDate |
	startDate := November / 4 / 2024.
	
	dashboard := self dashboard: startDate.
	documentacion := Task named: 'Documentacion' effort: 10 * hour startingAt: (November/15/2024) dependingOn: (Set with: dashboard).
	dev := self pfuentes.
	
	dashboard assignTo: dev.
	documentacion assignTo: dev.
	
	dashboardEndDate := dashboard end.
	self should: [documentacion endStartingAt: dashboardEndDate next]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: Task triedToStartBeforeStartDateError].
	! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 16:34:58'!
test08AProjectCanComputeItsEndTime
	| dev project dashboard documentacion |
	project := Project named: 'Dark Vessels'.
	dev := self pfuentes.
	dashboard := Task named: 'Dashboard' effort: 2 * hour startingAt: November / 4 / 2024 dependingOn: Set new.
	documentacion := Task named: 'Documentacion' effort: 10 * hour startingAt: November / 6 / 2024 dependingOn: (Set with: dashboard).
	
	documentacion assignTo: dev.
	dashboard assignTo: dev.
	
	project add: documentacion.
	project add: dashboard.
	
	self assert: project end equals: (November / 7 / 2024).
	
	
	! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/10/2024 17:38:09'!
test09ProjectWithNestedProject
	| project dashboard subproject |
	project := Project named: 'Dark Vessels'.
	subproject := Project named: 'Front'.
	dashboard := Task named: 'Dashboard' effort: 8 * hour startingAt: November / 4 / 2024 dependingOn: Set new.
	dashboard assignTo: self pfuentes.
	
	project add: subproject.
	subproject add: dashboard.
	
	self assert: project end equals: (November / 5 / 2024).
	
	
	! !

!TaskTest methodsFor: 'test' stamp: 'PFU 11/11/2024 18:32:30'!
test10ProjectWithNestedProjectCanComputeCost
	| project dashboard subproject |
	project := Project named: 'Dark Vessels'.
	subproject := Project named: 'Front'.
	dashboard := Task named: 'Dashboard' effort: 8 * hour startingAt: November / 4 / 2024 dependingOn: Set new.
	dashboard assignTo: self pfuentes.
	
	project add: subproject.
	subproject add: dashboard.
	
	self assert: project cost equals: 1.! !


!classDefinition: #Developer category: #'20241C'!
Object subclass: #Developer
	instanceVariableNames: 'name effort cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Developer methodsFor: 'initialization' stamp: 'PFU 11/10/2024 09:29:20'!
initializeNamed: aName working: anAmountOfHours gettingPaid: aCost  
	name := aName.
	effort := anAmountOfHours.
	cost := aCost.! !


!Developer methodsFor: 'work' stamp: 'PFU 11/10/2024 09:32:53'!
costFromWorking: aTimeRangeInDays

	^ aTimeRangeInDays * effort * cost! !

!Developer methodsFor: 'work' stamp: 'PFU 11/10/2024 09:29:47'!
workOn: aTask from: currentDate
	^aTask reduceWorkLoadBy: (effort * day) currentDayIs: currentDate next.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #'20241C'!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'PFU 11/10/2024 08:57:48'!
named: aName working: anAmountOfHours gettingPaid: aCost  
	^self new initializeNamed: aName working: anAmountOfHours gettingPaid: aCost ! !


!classDefinition: #NullDeveloper category: #'20241C'!
Developer subclass: #NullDeveloper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!NullDeveloper methodsFor: 'work' stamp: 'PFU 11/10/2024 09:14:17'!
workOn: aTask from: currentDate
	aTask reduceWorkLoadByNullDeveloper.! !


!classDefinition: #EndDateVisitor category: #'20241C'!
Object subclass: #EndDateVisitor
	instanceVariableNames: 'workable'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!EndDateVisitor methodsFor: 'tasks' stamp: 'PFU 11/11/2024 18:49:53'!
visitTask: aTaskToVisit
	! !


!EndDateVisitor methodsFor: 'end' stamp: 'PFU 11/11/2024 18:49:30'!
endStartingAt: aStartDate
	workable accept: self.! !


!EndDateVisitor methodsFor: 'initialization' stamp: 'PFU 11/11/2024 18:48:16'!
for: aWorkableItem
	workable := aWorkableItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EndDateVisitor class' category: #'20241C'!
EndDateVisitor class
	instanceVariableNames: ''!

!EndDateVisitor class methodsFor: 'instance creation' stamp: 'PFU 11/11/2024 18:47:58'!
for: aWorkableItem
	^self new for: aWorkableItem! !


!classDefinition: #Workable category: #'20241C'!
Object subclass: #Workable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Workable methodsFor: 'as yet unclassified' stamp: 'PFU 11/10/2024 17:33:47'!
earliestStartDate
	self shouldBeImplemented.! !


!classDefinition: #Project category: #'20241C'!
Workable subclass: #Project
	instanceVariableNames: 'workables name finished'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Project methodsFor: 'initialization' stamp: 'PFU 11/10/2024 16:17:21'!
initializeWithName: aName 
	name := aName.
	workables := OrderedCollection new.
	finished := false.! !


!Project methodsFor: 'tasks' stamp: 'PFU 11/10/2024 17:50:22'!
getNextTask

	| startables next |
	startables := workables select: [:aWorkableItem | aWorkableItem canStart].
	startables isEmpty ifTrue: [finished := true. ^ nil].
	
	next :=  self earliestTaskFrom: startables.
	^ next.! !

!Project methodsFor: 'tasks' stamp: 'PFU 11/10/2024 17:46:34'!
processNextTask: aWorkableItemToFinish startingAt: aStartDate
	| nextStartDate next |
    nextStartDate := aWorkableItemToFinish endStartingAt: (aWorkableItemToFinish earliestStartDate: aStartDate).
    next := self getNextTask.

	"stops recursion if there is no next task"
    next ifNil: [^nextStartDate]. 
    
    ^ self processNextTask: next startingAt: nextStartDate.! !


!Project methodsFor: 'workables' stamp: 'PFU 11/10/2024 15:04:24'!
add: aWorkableItem 
	workables add: aWorkableItem.! !

!Project methodsFor: 'workables' stamp: 'PFU 11/11/2024 18:34:19'!
cost
	^self costStartingAt: self earliestStartDate.! !

!Project methodsFor: 'workables' stamp: 'PFU 11/11/2024 18:34:41'!
costStartingAt: aStartDate
	| nextStartDate next|
	nextStartDate := aStartDate.
	next := self getNextTask.
	
	! !

!Project methodsFor: 'workables' stamp: 'PFU 11/10/2024 17:45:21'!
end
	^self endStartingAt: (self earliestStartDate)
	
		! !

!Project methodsFor: 'workables' stamp: 'PFU 11/10/2024 17:46:16'!
endStartingAt: aStartDate
	| nextStartDate next|
	nextStartDate := aStartDate.
	next := self getNextTask.
	
	nextStartDate := self processNextTask: next startingAt: nextStartDate.

	^ nextStartDate.
	
		! !


!Project methodsFor: 'getters' stamp: 'PFU 11/10/2024 17:32:56'!
canStart
	^ workables allSatisfy: [:aWorkableItem | aWorkableItem canStart].! !

!Project methodsFor: 'getters' stamp: 'PFU 11/10/2024 17:50:51'!
earliestStartDate
	^(self earliestTaskFrom: workables) earliestStartDate.! !

!Project methodsFor: 'getters' stamp: 'PFU 11/10/2024 17:47:06'!
earliestStartDate: aPotentialStartDate
	^ self earliestStartDate max: aPotentialStartDate.! !

!Project methodsFor: 'getters' stamp: 'PFU 11/10/2024 17:50:02'!
earliestTaskFrom: aCollectionOfWorkableItems
	| earliestTask |
	earliestTask := (aCollectionOfWorkableItems 
		inject: aCollectionOfWorkableItems first 
		into: [:minItem :each | (each earliestStartDate < minItem earliestStartDate) ifTrue: [each] ifFalse: [minItem]]).
		
	^ earliestTask ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'20241C'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'PFU 11/10/2024 14:56:39'!
named: aName
	^self new initializeWithName: aName! !


!classDefinition: #Task category: #'20241C'!
Workable subclass: #Task
	instanceVariableNames: 'name effort assignee startDate dependencies'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Task methodsFor: 'initialization' stamp: 'PFU 11/10/2024 08:17:39'!
assignTo: aDeveloper
	assignee := aDeveloper.! !

!Task methodsFor: 'initialization' stamp: 'PFU 11/10/2024 15:35:54'!
initializeNamed: aName effort: anEffort startingAt: aStartDate dependingOn: aTaskCollection   
	name := aName.
	effort := anEffort.
	assignee := NullDeveloper new.
	startDate := aStartDate.
	dependencies := aTaskCollection.
! !


!Task methodsFor: 'nulls' stamp: 'PFU 11/10/2024 09:17:21'!
reduceWorkLoadByNullDeveloper
	self error: self class noAssignedDevError.! !


!Task methodsFor: 'getters' stamp: 'PFU 11/10/2024 16:13:44'!
canStart
	^ (self isFinished not) and: [dependencies allSatisfy: [:aTask | aTask isFinished]]! !

!Task methodsFor: 'getters' stamp: 'PFU 11/10/2024 16:23:09'!
earliestStartDate
	^startDate! !

!Task methodsFor: 'getters' stamp: 'PFU 11/10/2024 17:37:30'!
earliestStartDate: aPotentialStartDate
	^ startDate max: aPotentialStartDate ! !

!Task methodsFor: 'getters' stamp: 'PFU 11/10/2024 15:36:09'!
isFinished
	^ effort = 0.! !


!Task methodsFor: 'finishing' stamp: 'PFU 11/10/2024 15:00:58'!
cost
	| endDate workDays |
	endDate := self end.
	workDays := (startDate distanceTo: endDate) + (1 * day).
		
	^ assignee costFromWorking: workDays.! !

!Task methodsFor: 'finishing' stamp: 'PFU 11/10/2024 15:06:27'!
costStartingAt: aStartDate
	| endDate workDays |
	endDate := self endStartingAt: aStartDate.
	workDays := (aStartDate distanceTo: endDate) + (1 * day).
		
	^ assignee costFromWorking: workDays.! !

!Task methodsFor: 'finishing' stamp: 'PFU 11/10/2024 15:29:18'!
end
	^self endStartingAt: startDate.
! !

!Task methodsFor: 'finishing' stamp: 'PFU 11/10/2024 15:48:56'!
endStartingAt: aStartDate
	self assertFinishedDependencies.
	self assertValidDate: aStartDate.
	
	

	^assignee workOn: self from: aStartDate.
! !

!Task methodsFor: 'finishing' stamp: 'PFU 11/10/2024 15:38:32'!
reduceWorkLoadBy: aWorkTime currentDayIs: currentDate
	| remainingEffort |
	remainingEffort := effort - aWorkTime.
	
	effort := remainingEffort max: (0 * hour).

	(remainingEffort <= 0) 
		ifTrue:  [^ currentDate previous]
		ifFalse: [^ assignee workOn: self from: currentDate]
	! !


!Task methodsFor: 'asserts' stamp: 'PFU 11/11/2024 18:44:00'!
assertFinishedDependencies

	^ (self canStart) ifFalse: [self error: self class unfinishedDependenciesError]! !

!Task methodsFor: 'asserts' stamp: 'PFU 11/10/2024 15:50:06'!
assertValidDate: aStartDate
	(aStartDate >= startDate) ifFalse: [self error: self class triedToStartBeforeStartDateError]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Task class' category: #'20241C'!
Task class
	instanceVariableNames: ''!

!Task class methodsFor: 'instance creation' stamp: 'PFU 11/10/2024 15:33:03'!
named: aName effort: anEffort startingAt: aStartDate dependingOn: aTask   
	^self new initializeNamed: aName effort: anEffort startingAt: aStartDate dependingOn: aTask ! !


!Task class methodsFor: 'errors' stamp: 'PFU 11/10/2024 09:12:59'!
noAssignedDevError
	^'I dont have any Developers assigned'! !

!Task class methodsFor: 'errors' stamp: 'PFU 11/10/2024 15:50:22'!
triedToStartBeforeStartDateError
	^'I cannot start before my start date'! !

!Task class methodsFor: 'errors' stamp: 'PFU 11/10/2024 15:28:59'!
unfinishedDependenciesError
	^'I cannot be started. My dependencies are unfinished.'! !
