!classDefinition: #TaskTest category: #'20241C'!
TestCase subclass: #TaskTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 20:05:13'!
assignVessels

	^ ConcreteTask named: 'AssignVessels' startingOn: July/1/2024 assignedTo: self ds dependingOn: {} requiring: 16*hour! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:22:22'!
assignVesselsDependingOnDocu

	^ ConcreteTask named: 'AssignVessels' startingOn: July/1/2024 assignedTo: self ds dependingOn: {self documentacion } requiring: 16*hour! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 20:36:23'!
dashboard

	^ ConcreteTask named: 'Dashboard' startingOn: July/1/2024 assignedTo: self pfuentes dependingOn: {} requiring: 3*hour! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 19:48:13'!
documentacion

	^ ConcreteTask named: 'Docu' startingOn: July/1/2024 assignedTo: self pfuentes dependingOn: {} requiring: 6*hour! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 19:48:13'!
test01TaskEndsOnStartDateIfDevHasSameEffort
	|task|
	task := self documentacion.
	
	self assert: (task endsOn: July/1/2024)
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 19:09:01'!
test02TaskEndsOnStartDateIfDevHasLessEffort
	|task|
	task := ConcreteTask named: 'Docu' startingOn: July/1/2024 assignedTo: self pfuentes dependingOn: {} requiring: 10*hour.
	
	self deny: (task endsOn: July/1/2024)
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 20:05:13'!
test03TaskEndsOnStartDateIfTeamHasSameEffort
	|task|
	task := self assignVessels.
	
	"este test NO considera que el esfuerzo SE DIVIDE EN TODO EL EQUIPO. Es decir, si la tarea toma 10 horas y las dos personas del equipo trabajan 5 por dia, la tarea termina el mismo dia. En Team >> timeToComplete: aTaskTime esta comentada la solucion que hace que esto sea asi"
	
	self assert: (task endsOn: July/3/2024)
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 20:05:13'!
test04TaskStartsOnDesiredStartDateWhenItDoesNotHaveDependencies
	|task|
	task := self assignVessels.
	
	self assert: (task startsOn: July/1/2024).
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 20:15:11'!
test05TaskDoesNotStartsOnDesiredStartDateWhenItHasDependenciesThatForbidItsStartDate
	|task|
	
	task := ConcreteTask named: 'AssignVessels' startingOn: July/1/2024 assignedTo: self ds dependingOn: {self documentacion} requiring: 16*hour.
	
	self deny: (task startsOn: July/1/2024).
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 20:36:36'!
test06TaskStartsOnDesiredStartDateEvenIfDependenciesFinishEarlier
	|task|
	
	task := ConcreteTask named: 'AssignVessels' startingOn: July/5/2024 assignedTo: self ds dependingOn: {self documentacion. self dashboard } requiring: 16*hour.
	
	self assert: (task startsOn: July/5/2024).
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:15:40'!
test07TaskWithDependenciesAndEarlyStartDateNeedsToWaitForItsDependencies
	|task|
	task := ConcreteTask named: 'AssignVessels' startingOn: July/1/2024 assignedTo: self ds dependingOn: {self documentacion} requiring: 16*hour.
	
	self assert: (task startsOn: July/2/2024).
	self assert: (task endsOn: July/4/2024).! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:22:47'!
test08ProjectStartsOnEarliestTaskStartDate
	|project|
	
	project := Project named: 'Dark vessels' with: {self documentacion. self assignVesselsDependingOnDocu}.
	
	self assert: (project startsOn: self documentacion startDate).
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:22:43'!
test09ProjectDoesNotStartsLaterThanOnEarliestTaskStartDate
	|project|
	
	project := Project named: 'Dark vessels' with: {self documentacion. self assignVesselsDependingOnDocu}.
	
	self deny: (project startsOn: self assignVesselsDependingOnDocu startDate ).
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:22:39'!
test10ProjectEndsOnLatestTaskEndDate
	|project|
	
	project := Project named: 'Dark vessels' with: {self documentacion. self assignVesselsDependingOnDocu}.
	
	self assert: (project endsOn: self assignVesselsDependingOnDocu endDate).
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:28:24'!
test11ProjectDoesNotHaveOverworkWhenDevsDontHaveOverwork
	|project|
	
	project := Project named: 'Dark vessels' with: {self documentacion}.
	
	self deny: project hasOverwork
	
	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:50:02'!
test12ProjectHasOverworkWhenTasksHappenInTheSameDay
	|project|
	
	project := Project named: 'Dark vessels' with: {self documentacion. self dashboard }.
	
	self assert: project hasOverwork
	
	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/11/2024 21:49:39'!
test13ProjectDoesNotHaveOverworkWhenTasksAreSeparated
	|project dash docu |
	
	docu := ConcreteTask named: 'Docu' startingOn: July/1/2024 assignedTo: self pfuentes dependingOn: {} requiring: 30*hour.
	dash := ConcreteTask named: 'Dash' startingOn: July/10/2024 assignedTo: self pfuentes dependingOn: {} requiring: 1*hour.
	
	
	project := Project named: 'Dark vessels' with: {docu. dash }.
	
	self deny: project hasOverwork.

	
	! !


!TaskTest methodsFor: 'support' stamp: 'PFU 11/11/2024 19:24:17'!
ds
	^ Team named: 'ASADS' with: {self pfuentes. self iiragui}! !

!TaskTest methodsFor: 'support' stamp: 'PFU 11/11/2024 19:21:57'!
iiragui
	^ Developer named: 'iiragui' working: 8*hour/day earning: 1500 * peso / hour.! !

!TaskTest methodsFor: 'support' stamp: 'PFU 11/11/2024 19:16:18'!
pfuentes
	^ Developer named: 'pfuentes' working: 6*hour/day earning: 1000 * peso / hour.! !


!classDefinition: #Responsible category: #'20241C'!
Object subclass: #Responsible
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Responsible methodsFor: 'work' stamp: 'PFU 11/11/2024 21:25:26'!
timeToComplete: aTaskTime

	self subclassResponsibility! !


!classDefinition: #Developer category: #'20241C'!
Responsible subclass: #Developer
	instanceVariableNames: 'dedication cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Developer methodsFor: 'effort' stamp: 'PFU 11/11/2024 19:26:05'!
timeToComplete: aTaskTime
	^ (aTaskTime / dedication) ceiling! !


!Developer methodsFor: 'initialization' stamp: 'PFU 11/11/2024 19:11:32'!
initializeNamed: aName working: anEffort earning: aCost 
	name := aName.
	dedication := anEffort.
	cost := aCost.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #'20241C'!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'PFU 11/11/2024 19:06:10'!
named: aName working: anEffort earning: aCost 
	^self new initializeNamed: aName working: anEffort earning: aCost ! !


!classDefinition: #Team category: #'20241C'!
Responsible subclass: #Team
	instanceVariableNames: 'responsibles'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Team methodsFor: 'work' stamp: 'PFU 11/11/2024 19:37:46'!
minimumEffortResponsibleFor: aTaskTime

	^ responsibles inject: responsibles first 
	into: [:minResponsible :aResponsible | 
			(aResponsible timeToComplete: aTaskTime) > (minResponsible timeToComplete: aTaskTime) 
				ifTrue: [aResponsible] ifFalse: [minResponsible]		]! !

!Team methodsFor: 'work' stamp: 'PFU 11/11/2024 19:45:48'!
timeToComplete: aTaskTime
	
	^responsibles max: [:aResponsible | aResponsible timeToComplete: aTaskTime]
	
	" otra version, explicada en el test3"
	"|minEffortResponsible timeItTakesForTheMinEffortResponsible |
	minEffortResponsible := self minimumEffortResponsibleFor: aTaskTime.
	timeItTakesForTheMinEffortResponsible := minEffortResponsible timeToComplete: aTaskTime.
	
	^ (timeItTakesForTheMinEffortResponsible / responsibles size) ceiling."
			
	
	
	
	! !


!Team methodsFor: 'initialization' stamp: 'PFU 11/11/2024 19:31:41'!
initializeNamed: aName with: aDevCollection
	name := aName.
	responsibles := aDevCollection! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Team class' category: #'20241C'!
Team class
	instanceVariableNames: ''!

!Team class methodsFor: 'instance creation' stamp: 'PFU 11/11/2024 19:24:31'!
named: aName with: aDevCollection

	^self new initializeNamed: aName with: aDevCollection! !


!classDefinition: #Task category: #'20241C'!
Object subclass: #Task
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Task methodsFor: 'end' stamp: 'PFU 11/11/2024 21:23:52'!
endDate

	self subclassResponsibility! !


!Task methodsFor: 'start' stamp: 'PFU 11/11/2024 21:24:20'!
endsOn: anEndDate 
	^ anEndDate = self endDate.! !

!Task methodsFor: 'start' stamp: 'PFU 11/11/2024 21:23:59'!
startDate

	self subclassResponsibility! !

!Task methodsFor: 'start' stamp: 'PFU 11/11/2024 21:24:34'!
startsOn: aStartDate 
	^ aStartDate = self startDate.! !


!classDefinition: #ConcreteTask category: #'20241C'!
Task subclass: #ConcreteTask
	instanceVariableNames: 'desiredStartDate responsible dependencies effort'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!ConcreteTask methodsFor: 'initialization' stamp: 'PFU 11/11/2024 19:08:01'!
initializeNamed: aName startingOn: aDesiredStartDate assignedTo: aResponsible dependingOn: aDependencies requiring: anEffort 
	name := aName.
	desiredStartDate := aDesiredStartDate.
	responsible := aResponsible.
	dependencies := aDependencies.
	effort := anEffort.! !


!ConcreteTask methodsFor: 'end' stamp: 'PFU 11/11/2024 21:08:27'!
endDate

	^ self startDate next: self timeToComplete! !

!ConcreteTask methodsFor: 'end' stamp: 'PFU 11/11/2024 19:19:28'!
timeToComplete

	^ (responsible timeToComplete: effort) - (1 * day)! !


!ConcreteTask methodsFor: 'start' stamp: 'PFU 11/11/2024 20:33:04'!
maxDependenciesEndDate
	"will break if dependencies is empty"
	^ dependencies max:[ :aDependency | aDependency endDate]! !

!ConcreteTask methodsFor: 'start' stamp: 'PFU 11/11/2024 20:40:03'!
startDate

	^ dependencies ifEmpty:[desiredStartDate ]
					ifNotEmpty: [self maxDependenciesEndDate next max: desiredStartDate ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConcreteTask class' category: #'20241C'!
ConcreteTask class
	instanceVariableNames: ''!

!ConcreteTask class methodsFor: 'instance creation' stamp: 'PFU 11/11/2024 19:07:49'!
named: aName startingOn: aDesiredStartDate assignedTo: aResponsible dependingOn: aDependencies requiring: anEffort 

	^self new initializeNamed: aName startingOn: aDesiredStartDate assignedTo: aResponsible dependingOn: aDependencies requiring: anEffort ! !



!classDefinition: #Project category: #'20241C'!
Task subclass: #Project
	instanceVariableNames: 'tasks'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Project methodsFor: 'initialization' stamp: 'PFU 11/11/2024 20:06:05'!
initializeNamed: aName with: aTaskCollection 
	name := aName.
	tasks := aTaskCollection.! !


!Project methodsFor: 'start' stamp: 'PFU 11/11/2024 21:20:17'!
endDate
	^ tasks max: [:aTask | aTask endDate].! !

!Project methodsFor: 'start' stamp: 'PFU 11/11/2024 21:19:04'!
startDate
	^ tasks min: [:aTask | aTask startDate].! !


!Project methodsFor: 'overwork' stamp: 'PFU 11/11/2024 21:48:44'!
hasOverlap: aTask with: anotherTask
	"aTask pertenece a anotherTask"
	"deberia saber responderlo la propia task?"

	^ anotherTask startDate <= aTask startDate and: [aTask startDate <= anotherTask endDate].! !

!Project methodsFor: 'overwork' stamp: 'PFU 11/11/2024 21:47:56'!
hasOverwork
	^ tasks anySatisfy: [:aTask | 
			tasks anySatisfy: [:anotherTask | 
					"si dos tareas distintas se overlapean => overwork"
					aTask ~= anotherTask and:[self hasOverlap: aTask with: anotherTask			]
		]
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'20241C'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'PFU 11/11/2024 20:05:51'!
named: aName with: aTaskCollection 
	^self new initializeNamed: aName with: aTaskCollection ! !
