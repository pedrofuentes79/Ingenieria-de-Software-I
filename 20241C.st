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

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 18:26:09'!
test14DevWithOneTaskPerDayDoesNotHaveOverwork
	|project dash docu pfuentes dates |
	
	pfuentes := self pfuentes.
	docu := ConcreteTask named: 'Docu' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	dash := ConcreteTask named: 'Dash' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 2*hour.
	

	project := Project named: 'Dark vessels' with: {docu. dash }.
	
	dates := project overworkingDatesOf: pfuentes.
	
	self assert: dates size equals: 0.	
	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 18:25:46'!
test15DevWithMoreThanOneTaskPerDayHasOverwork
	|project pfuentes dates |
	
	pfuentes := self pfuentes.
	project := Project named: 'Dark vessels' with: {self documentacion. self dashboard }.
	
	dates := project overworkingDatesOf: pfuentes.
	
	self assert: dates size equals: 1.
	self assert: dates includes: July/1/2024.
	
	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 18:53:00'!
test16DevWithMoreThanOneTaskPerDayOnMultipleDaysHasOverworkOnBothDays
	|project pfuentes dates task1 task2 task3 task4 |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 2*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 5*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 2*hour.
	
	project := Project named: 'Boring Project' with: {task1. task2. task3. task4 }.
	dates := project overworkingDatesOf: pfuentes.
	
	self assert: dates size equals: 2.
	self assert: dates includes: July/1/2024.
	self assert: dates includes: July/2/2024.
	
	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 18:55:34'!
test17ProjectKnowsAmountOfTasksPerDayForAGivenResponsible
	|project pfuentes dates task1 task2 task3 task4 |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 2*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 5*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 2*hour.
	
	project := Project named: 'Boring Project' with: {task1. task2. task3. task4 }.
	dates := project worksheetFor: pfuentes.
	
	self assert: (dates at: July/1/2024)	 equals: 2.
	self assert: (dates at: July/2/2024)	 equals: 2.

	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 18:55:24'!
test18ProjectKnowsAmountOfTasksPerDayForAGivenResponsibleWhenATaskSpansOverMultipleDays
	|project pfuentes dates task1 task2 task3 task4 |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 7*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 5*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 9*hour.
	
	project := Project named: 'Boring Project' with: {task1. task2. task3. task4 }.
	dates := project worksheetFor: pfuentes.
	
	self assert: (dates at: July/1/2024)	 equals: 2.
	self assert: (dates at: July/2/2024)	 equals: 3.

	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 18:57:52'!
test19ProjectCanComputeFullCostWhenItHasOneTask
	|project pfuentes task1 cost |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	
	project := Project named: 'Boring Project' with: {task1}.
	cost := project cost.
	
	self assert: cost equals: 6000 * peso.
	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 19:15:51'!
test20ProjectCanComputeFullCostWhenItHasMoreThanOneTask
	|project pfuentes task1 cost task2 task3 task4 |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/2/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/3/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/4/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	
	project := Project named: 'Boring Project' with: {task1. task2. task3. task4 }.
	cost := project cost.
	
	self assert: cost equals: 4 * 6000 * peso.
	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 19:21:00'!
test21ProjectCanComputeFullCostWhenItHasOverwork
	|project pfuentes task1 cost task2 task3 task4 |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	
	project := Project named: 'Boring Project' with: {task1. task2. task3. task4 }.
	cost := project cost.
	
	self assert: project hasOverwork.
	self assert: cost equals: 4 * 6000 * peso.
	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 19:27:42'!
test22ProjectKnowsAmountOfTasksPerDayWithNestedProjects
	|project pfuentes task1 task2 task3 task4 subproject worksheet |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	
	subproject := Project named: 'Boring Subproject' with: {task1. task2. task3}.
	project := Project named: 'Boring Project' with: {subproject. task4 }.
	
	worksheet := project worksheetFor: pfuentes.
	
	self assert: (worksheet at: July/1/2024)	 equals: 4.

	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 19:28:18'!
test23ProjectKnowsOverworkWhenItHasNestedSubprojects
	|project pfuentes task1 task2 task3 task4 subproject |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	
	subproject := Project named: 'Boring Subproject' with: {task1. task2. task3}.
	project := Project named: 'Boring Project' with: {subproject. task4 }.
	
	
	self assert: project hasOverwork

	

	
	! !

!TaskTest methodsFor: 'tests' stamp: 'PFU 11/14/2024 19:29:15'!
test24ProjectCanComputeFullCostWhenNestedProjects
	|project pfuentes task1 task2 task3 task4 subproject |
	
	pfuentes := self pfuentes.
	
	task1 := ConcreteTask named: 'task1' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task2 := ConcreteTask named: 'task2' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task3 := ConcreteTask named: 'task3' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	task4 := ConcreteTask named: 'task4' startingOn: July/1/2024 assignedTo: pfuentes dependingOn: {} requiring: 1*hour.
	
	subproject := Project named: 'Boring Subproject' with: {task1. task2. task3}.
	project := Project named: 'Boring Project' with: {subproject. task4 }.
	
	
	self assert: project cost equals: 4 * 6000 * peso.

	

	
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


!Responsible methodsFor: 'getter' stamp: 'PFU 11/14/2024 18:47:39'!
name
	^ name! !


!classDefinition: #Developer category: #'20241C'!
Responsible subclass: #Developer
	instanceVariableNames: 'dedication cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: '20241C'!

!Developer methodsFor: 'effort' stamp: 'PFU 11/11/2024 19:26:05'!
timeToComplete: aTaskTime
	^ (aTaskTime / dedication) ceiling! !


!Developer methodsFor: 'cost' stamp: 'PFU 11/14/2024 19:13:33'!
costToComplete: aTaskTime
	| costPerDay taskTimeInDays |
	costPerDay := dedication * cost.
	taskTimeInDays := self timeToComplete: aTaskTime.
	
	^ costPerDay * taskTimeInDays
	
	! !


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


!ConcreteTask methodsFor: 'overwork' stamp: 'PFU 11/14/2024 18:48:39'!
addWorkingDaysOf: aResponsible to: aWorksheet
	(aResponsible name = responsible name) ifFalse: [^aWorksheet].
		
	self workingDays do: [:aWorkingDay | 
			| tasksInDay | 
			tasksInDay := aWorksheet at: aWorkingDay ifAbsent:[0].
			aWorksheet at: aWorkingDay put: tasksInDay + 1.
		].
	
	^aWorksheet 
	
	
	! !

!ConcreteTask methodsFor: 'overwork' stamp: 'PFU 11/14/2024 18:48:27'!
workingDays

	^ self startDate to: self endDate by: 1* day! !


!ConcreteTask methodsFor: 'start' stamp: 'PFU 11/11/2024 20:33:04'!
maxDependenciesEndDate
	"will break if dependencies is empty"
	^ dependencies max:[ :aDependency | aDependency endDate]! !

!ConcreteTask methodsFor: 'start' stamp: 'PFU 11/11/2024 20:40:03'!
startDate

	^ dependencies ifEmpty:[desiredStartDate ]
					ifNotEmpty: [self maxDependenciesEndDate next max: desiredStartDate ]! !


!ConcreteTask methodsFor: 'cost' stamp: 'PFU 11/14/2024 19:00:54'!
cost
	^ responsible costToComplete: effort! !

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


!Project methodsFor: 'cost' stamp: 'PFU 11/14/2024 19:13:00'!
cost
	|cost|
	cost := 0.
	
	tasks do: [:aTask | cost := cost + aTask cost.].
	
	^ cost! !


!Project methodsFor: 'overwork' stamp: 'PFU 11/14/2024 18:49:45'!
addWorkingDaysOf: aResponsible to: aWorksheet

	tasks do: [:aTask | aTask addWorkingDaysOf: aResponsible to: aWorksheet].
	! !

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

!Project methodsFor: 'overwork' stamp: 'PFU 11/14/2024 18:46:09'!
overworkingDatesOf: aResponsible
	|overworkingDates worksheet|
	
	worksheet := self worksheetFor: aResponsible.
	
	overworkingDates := Set new.
	worksheet keysAndValuesDo: [:aWorkingDay :aNumberOfTasks | aNumberOfTasks > 1 ifTrue: [overworkingDates add: aWorkingDay ]].
	
	^ overworkingDates 
	
	! !

!Project methodsFor: 'overwork' stamp: 'PFU 11/14/2024 18:46:16'!
worksheetFor: aResponsible
	| worksheet |
	worksheet := Dictionary new.

	tasks do: [:aTask | aTask addWorkingDaysOf: aResponsible to: worksheet].
	
	^ worksheet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'20241C'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'PFU 11/11/2024 20:05:51'!
named: aName with: aTaskCollection 
	^self new initializeNamed: aName with: aTaskCollection ! !
