!classDefinition: #CocheraTest category: #Cochera!
TestCase subclass: #CocheraTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:07:29'!
test01CocheraSeAsignaALaUnicaPersonaQueLaPidio

	| cochera |
	cochera := Cochera new.
	
	cochera requestAt: July/1/2024 for: 'pedro' dueTo: Reunion new.
	cochera assignOn: July/1/2024.
	
	self assert: (cochera isAssignedTo: 'pedro' on: July/1/2024)! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:07:45'!
test02SiHayDosPersonasLaCocheraSeAsignaAQuienTengaMasPrioridad

	| cochera requestDate |
	cochera := Cochera new.
	requestDate := July/1/2024.
	
	cochera requestAt: requestDate for: 'pedro' dueTo: Clase new.
	cochera requestAt: requestDate for: 'vini' dueTo: Reunion new.
	cochera assignOn: requestDate.

	self assert: (cochera isAssignedTo: 'vini' on: requestDate)! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:07:53'!
test03DosPersonasUnaConClaseOtraConUsoPersonal

	| cochera requestDate |
	cochera := Cochera new.
	requestDate := July/1/2024.
	
	cochera requestAt: requestDate for: 'pedro' dueTo: Clase new.
	cochera requestAt: requestDate for: 'vini' dueTo: UsoPersonal new.
	cochera assignOn: requestDate.

	self assert: (cochera isAssignedTo: 'pedro' on: requestDate)! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:08:04'!
test04DosPersonasUnaConReunionOtraConUsoPersonal

	| cochera requestDate |
	cochera := Cochera new.
	requestDate := July/1/2024.
	
	cochera requestAt: requestDate for: 'pedro' dueTo: Reunion new.
	cochera requestAt: requestDate for: 'vini' dueTo: UsoPersonal new.
	cochera assignOn: requestDate.

	self assert: (cochera isAssignedTo: 'pedro' on: requestDate)! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:08:17'!
test05DosPersonasConLaMismaPrioridadSeAsignaAQuienHayaTenidoMenosPedidosEnLosUltimos30Dias

	| cochera |
	cochera := Cochera new.
	cochera requestAt: July/1/2024 for: 'pedro' dueTo: Clase new.
	cochera assignOn: July/1/2024.
	
	cochera requestAt: July/2/2024 for: 'pedro' dueTo: Reunion new.
	cochera requestAt: July/2/2024 for: 'vini' dueTo: Reunion new.
	cochera assignOn: July/2/2024.

	self assert: (cochera isAssignedTo: 'vini' on: July/2/2024)! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:08:21'!
test06CocheraNoPuedeRecibirPedidosSiYaTieneUnaAsignacionParaEseDia

	| cochera |
	cochera := Cochera new.
	cochera requestAt: July/1/2024 for: 'pedro' dueTo: Clase new.
	cochera assignOn: July/1/2024.
	
	self should: [cochera requestAt: July/1/2024 for: 'pedro' dueTo: 'Reunion']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:error | 
		self assert: error messageText equals: 'Ya se cerro el dia']
	

! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 18:56:13'!
test07CocheraNoTieneAsignacionesSiNadieLaPidio

	| cochera |
	cochera := Cochera new.
	
	cochera assignOn: July/1/2024.
	
	self deny: (cochera hasAssignmentsOn: July/1/2024)! !

!CocheraTest methodsFor: 'tests' stamp: 'pfu 11/21/2024 19:08:36'!
test08SiHayDosRequestsDeLaMismaPersonaParaElMismoDiaSeTomaElUltimoQueSeHizo

	| cochera |
	cochera := Cochera new.
	cochera requestAt: July/1/2024 for: 'pedro' dueTo: Reunion new.
	cochera requestAt: July/1/2024 for: 'pedro' dueTo: Clase new. "piso la request anterior"
	cochera requestAt: July/1/2024 for: 'vini' dueTo: Reunion new..

	cochera assignOn: July/1/2024.
	
	self assert: (cochera isAssignedTo: 'vini' on: July/1/2024)! !


!classDefinition: #Cochera category: #Cochera!
Object subclass: #Cochera
	instanceVariableNames: 'requests assignments'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!Cochera methodsFor: 'initialization' stamp: 'pfu 11/21/2024 17:24:09'!
initialize
	requests := OrderedCollection new.
	assignments := OrderedCollection new.! !


!Cochera methodsFor: 'requests' stamp: 'pfu 11/21/2024 18:34:50'!
amountOfAssignmentsFrom: aRequester on: anAssignmentDate
	| selectedAssignments |
	selectedAssignments := assignments select: [:aRequest | aRequest isFor: aRequester before: (anAssignmentDate previous: 30*day)].
	
	^ selectedAssignments size
! !

!Cochera methodsFor: 'requests' stamp: 'pfu 11/21/2024 18:56:00'!
assertDateHasNotBeenAssigned: aRequestDate
	(self hasAssignmentsOn: aRequestDate) ifTrue: [self error: 'Ya se cerro el dia']! !

!Cochera methodsFor: 'requests' stamp: 'pfu 11/21/2024 18:23:40'!
doesRequester: aRequester haveLessRequestsThanRequesterFrom: aRequest on: anAssignmentDate  
	^(self amountOfAssignmentsFrom: aRequester on: anAssignmentDate) < (aRequest requestsFromRequesterForCochera: self on: anAssignmentDate)! !

!Cochera methodsFor: 'requests' stamp: 'pfu 11/21/2024 19:04:07'!
requestAt: aRequestDate for: aRequester dueTo: aReason 
	self assertDateHasNotBeenAssigned: aRequestDate.
	
	requests removeAllSuchThat: [:aRequest | aRequest isFor: aRequester on: aRequestDate].
	
	requests add: (CocheraRequest at: aRequestDate for: aRequester dueTo: aReason).! !


!Cochera methodsFor: 'assignment' stamp: 'pfu 11/21/2024 19:40:31'!
assignOn: aDateToAssign
	(self hasRequestsOn: aDateToAssign) ifTrue: [self assignRequestsFrom: aDateToAssign]
	! !

!Cochera methodsFor: 'assignment' stamp: 'pfu 11/21/2024 19:42:19'!
assignRequestsFrom: aDateToAssign 
	| requestsForAssignment finalRequest |
	requestsForAssignment := requests select: [:aRequest | aRequest isOn: aDateToAssign].
	finalRequest := self requestToAssignFrom: requestsForAssignment on: aDateToAssign.
	assignments add: finalRequest.! !

!Cochera methodsFor: 'assignment' stamp: 'pfu 11/21/2024 19:38:34'!
requestToAssignFrom: requestsForAssignment on: aDateToAssign

	^ requestsForAssignment 
		inject: requestsForAssignment first 
		into: [:maxPriorityRequest :aRequest | 
				(aRequest hasMorePriorityThan: maxPriorityRequest forCochera: self on: aDateToAssign) 
				ifTrue: [aRequest] ifFalse: [maxPriorityRequest].
			]! !


!Cochera methodsFor: 'testing' stamp: 'pfu 11/21/2024 18:03:23'!
hasAssignmentsOn: aDate
	^ assignments anySatisfy: [:aRequest | aRequest isOn: aDate].! !

!Cochera methodsFor: 'testing' stamp: 'pfu 11/21/2024 19:41:06'!
hasRequestsOn: aDate 
	^ requests anySatisfy: [:aRequest | aRequest isOn: aDate].! !

!Cochera methodsFor: 'testing' stamp: 'pfu 11/21/2024 17:26:59'!
isAssignedTo: aRequester on: anAssignmentDate
	^assignments anySatisfy: [:anAssignedRequest | anAssignedRequest isFor: aRequester on: anAssignmentDate]
	! !


!classDefinition: #CocheraRequest category: #Cochera!
Object subclass: #CocheraRequest
	instanceVariableNames: 'requestDate requester reason'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!CocheraRequest methodsFor: 'initialization' stamp: 'pfu 11/21/2024 17:14:57'!
initializeAt: aRequestDate for: aRequester dueTo: aReason 
	requestDate := aRequestDate.
	requester := aRequester.
	reason := aReason.! !


!CocheraRequest methodsFor: 'testing' stamp: 'pfu 11/21/2024 19:19:11'!
isDueTo: aReason
	^ reason isSameReasonAs: aReason! !

!CocheraRequest methodsFor: 'testing' stamp: 'pfu 11/21/2024 18:36:17'!
isFor: aRequester before: aPotentialPastDate 
	^ aRequester = requester and: [aPotentialPastDate < requestDate ]! !

!CocheraRequest methodsFor: 'testing' stamp: 'pfu 11/21/2024 17:31:44'!
isFor: aRequester on: anAssignmentDate 
	^ aRequester = requester and: [anAssignmentDate = requestDate]! !

!CocheraRequest methodsFor: 'testing' stamp: 'pfu 11/21/2024 17:25:39'!
isOn: aDateToAssign 
	^ requestDate = aDateToAssign.! !

!CocheraRequest methodsFor: 'testing' stamp: 'pfu 11/21/2024 19:29:17'!
reasonHasLessPriorityThan: aReason 
	^ reason hasLessPriorityThan: aReason.! !


!CocheraRequest methodsFor: 'priority' stamp: 'pfu 11/21/2024 19:28:46'!
hasMorePriorityThan: aRequest forCochera: aCochera on: aDate
	(aRequest isDueTo: reason) ifTrue: [^aCochera doesRequester: requester haveLessRequestsThanRequesterFrom: aRequest on: aDate]. 
	
	^ aRequest reasonHasLessPriorityThan: reason.! !

!CocheraRequest methodsFor: 'priority' stamp: 'pfu 11/21/2024 18:18:20'!
requestsFromRequesterForCochera: aCochera on: anAssignmentDate 
	^ aCochera amountOfAssignmentsFrom: requester on: anAssignmentDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CocheraRequest class' category: #Cochera!
CocheraRequest class
	instanceVariableNames: ''!

!CocheraRequest class methodsFor: 'instance creation' stamp: 'pfu 11/21/2024 17:14:43'!
at: aRequestDate for: aRequester dueTo: aReason
	^ self new initializeAt: aRequestDate for: aRequester dueTo: aReason! !


!classDefinition: #Reason category: #Cochera!
Object subclass: #Reason
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!Reason methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:11'!
isSameReasonAs: aReason
	self subclassResponsibility ! !

!Reason methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:33'!
isSameReasonAsClase
	^ false! !

!Reason methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:59'!
isSameReasonAsReunion
	^ false! !

!Reason methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:47'!
isSameReasonAsUsoPersonal
	^ false! !


!Reason methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:11:26'!
hasLessPriorityThan: aReason

	self subclassResponsibility! !


!classDefinition: #Clase category: #Cochera!
Reason subclass: #Clase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!Clase methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:33'!
isSameReasonAs: aReason
	^ aReason isSameReasonAsClase ! !

!Clase methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:33'!
isSameReasonAsClase
	^ true! !


!Clase methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:24:53'!
hasLessPriorityThan: aReason
	^ aReason hasMorePriorityThanClase! !

!Clase methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:25:13'!
hasMorePriorityThanClase
	^ false! !

!Clase methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:25:35'!
hasMorePriorityThanReunion
	^ false! !

!Clase methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:25:20'!
hasMorePriorityThanUsoPersonal
	^ true! !


!classDefinition: #Reunion category: #Cochera!
Reason subclass: #Reunion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!Reunion methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:59'!
isSameReasonAs: aReason
	^ aReason isSameReasonAsReunion ! !

!Reunion methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:59'!
isSameReasonAsReunion
	^ true! !


!Reunion methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:29:29'!
hasLessPriorityThan: aReason
	^ aReason hasMorePriorityThanReunion! !

!Reunion methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:26:20'!
hasMorePriorityThanClase
	^ true! !

!Reunion methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:25:51'!
hasMorePriorityThanReunion
	^ false! !

!Reunion methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:26:17'!
hasMorePriorityThanUsoPersonal
	^ true! !


!classDefinition: #UsoPersonal category: #Cochera!
Reason subclass: #UsoPersonal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cochera'!

!UsoPersonal methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:47'!
isSameReasonAs: aReason
	^ aReason isSameReasonAsUsoPersonal! !

!UsoPersonal methodsFor: 'same priority' stamp: 'pfu 11/21/2024 19:19:47'!
isSameReasonAsUsoPersonal
	^ true! !


!UsoPersonal methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:29:44'!
hasLessPriorityThan: aReason
	^ aReason hasMorePriorityThanUsoPersonal! !

!UsoPersonal methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:26:31'!
hasMorePriorityThanClase
	^ false! !

!UsoPersonal methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:25:55'!
hasMorePriorityThanReunion
	^ false! !

!UsoPersonal methodsFor: 'more / less priority' stamp: 'pfu 11/21/2024 19:26:33'!
hasMorePriorityThanUsoPersonal
	^ false! !
