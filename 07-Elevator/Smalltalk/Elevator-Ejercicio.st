!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'f.o.} 10/2/2017 18:42:55'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'elevatorStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:51:14'!
cabinDoorClosed

	elevatorStatus := elevatorStatus cabinDoorClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:51:29'!
cabinDoorOpened

	elevatorStatus := elevatorStatus cabinDoorOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:51:44'!
cabinFloorNumber

	^elevatorStatus floorNumber.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:51:51'!
cabinOnFloor: aFloor

	elevatorStatus := elevatorStatus cabinOnFloor: aFloor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:09:53'!
closeCabinDoor
	elevatorStatus := elevatorStatus closeCabinDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'f.o.} 10/2/2017 19:54:47'!
elevatorDoorIsClosed
	^(self elevatorDoorIsOpened) not.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:43:32'!
elevatorDoorIsOpened
	^elevatorStatus elevatorDoorIsOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:52:02'!
goUpPushedFromFloor: aFloor
	
	elevatorStatus := elevatorStatus goUpPushedFromFloor: aFloor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:54:06'!
initialize
	elevatorStatus := ElevatorOpened initialize.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:44:25'!
isCabinDoorClosed

	^elevatorStatus isClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:44:36'!
isCabinDoorClosing

	^elevatorStatus isClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:44:45'!
isCabinDoorOpened

	^elevatorStatus isOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:44:56'!
isCabinDoorOpening

	^elevatorStatus isOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 13:10:06'!
isCabinMoving

	^(self isCabinStopped) not.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:45:05'!
isCabinStopped

	^elevatorStatus isCabinStopped.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:29:50'!
isCabinWaitingForPeople

	^elevatorStatus isCabinWaitingForPeople.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:45:13'!
isIdle
	
	^elevatorStatus isIdle.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'f.o.} 10/2/2017 19:55:57'!
isWorking

	^(self isIdle) not.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:45:34'!
openCabinDoor
	elevatorStatus := elevatorStatus openCabinDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:06:54'!
waitForPeopleTimedOut
	elevatorStatus := elevatorStatus waitForPeopleTimedOut ! !


!classDefinition: #ElevatorStatus category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:04'!
cabinDoorClosed
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:08'!
cabinDoorOpened
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:15'!
cabinOnFloor: aFloor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:09:38'!
closeCabinDoor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:26'!
elevatorDoorIsOpened
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:32'!
floorNumber
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:37'!
goUpPushedFromFloor: aFloor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:05:58'!
initializeWithFloor: aFloor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:47:33'!
initializeWithFloor: aFloor andQueue: aQueue
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:43'!
isCabinStopped
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:29:38'!
isCabinWaitingForPeople
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:16:09'!
isClosed
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:16:06'!
isClosing
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:46'!
isIdle
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:06:49'!
isOpened
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:16:12'!
isOpening
	^false! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:26:01'!
openCabinDoor! !

!ElevatorStatus methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:04:38'!
waitForPeopleTimedOut
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorStatus class' category: #'Elevator-Ejercicio'!
ElevatorStatus class
	instanceVariableNames: ''!

!ElevatorStatus class methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:05:48'!
initialize
	^self new initializeWithFloor: 0! !


!classDefinition: #ElevatorClosed category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorClosed
	instanceVariableNames: 'floor queue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:17'!
cabinDoorClosed! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:17'!
cabinDoorOpened! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:20:41'!
cabinOnFloor: aFloor
	^ElevatorOpening new initializeWithFloor: aFloor.! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:22:48'!
closeCabinDoor! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:17'!
floorNumber
	^floor! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 18:00:42'!
goUpPushedFromFloor: aFloor
	queue add: aFloor.
	^ElevatorClosing new initializeWithFloor: floor andQueue: queue.! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:49:34'!
initializeWithFloor: aFloor
	floor := aFloor.
	queue := Bag new.! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:05:22'!
initializeWithFloor: aFloor andQueue: aQueue
	floor := aFloor.
	queue := aQueue ! !

!ElevatorClosed methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:16:53'!
isClosed
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorClosed class' category: #'Elevator-Ejercicio'!
ElevatorClosed class
	instanceVariableNames: ''!

!ElevatorClosed class methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:17'!
initialize
	^self new initializeWithFloor: 0! !


!classDefinition: #ElevatorClosing category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorClosing
	instanceVariableNames: 'floor queue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:19:46'!
cabinDoorClosed
	^ElevatorClosed new initializeWithFloor: floor.! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:54:03'!
cabinDoorOpened
	^ElevatorOpened new initializeWithFloor: floor andQueue: queue.! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:01:48'!
cabinOnFloor: aFloor
	floor := aFloor! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:14:22'!
elevatorDoorIsOpened
	^true! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:04:45'!
floorNumber
	^floor! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:57:57'!
goUpPushedFromFloor: aFloor! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:49:41'!
initializeWithFloor: aFloor
	floor := aFloor.
	queue := Bag new.! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:47:23'!
initializeWithFloor: aFloor andQueue: aQueue
	floor := aFloor.
	queue := aQueue.! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:01:48'!
isCabinStopped
	^true! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:16:39'!
isClosing
	^true! !

!ElevatorClosing methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:26:50'!
openCabinDoor
	^ElevatorOpening new initializeWithFloor: floor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorClosing class' category: #'Elevator-Ejercicio'!
ElevatorClosing class
	instanceVariableNames: ''!

!ElevatorClosing class methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:03:31'!
initialize
	^self new initializeWithFloor: 0! !


!classDefinition: #ElevatorOpened category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorOpened
	instanceVariableNames: 'floor queue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:11:59'!
cabinDoorClosed! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:52:24'!
cabinDoorOpened! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:54:43'!
cabinOnFloor: aFloor
	floor := aFloor! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:10:04'!
closeCabinDoor
	^ElevatorClosing new initializeWithFloor: floor andQueue: queue! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:14:04'!
elevatorDoorIsOpened
	^true! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:04:37'!
floorNumber
	^floor! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:05:10'!
goUpPushedFromFloor: aFloor
	^ElevatorClosing new initializeWithFloor: aFloor.! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:49:48'!
initializeWithFloor: aFloor
	floor := aFloor.
	queue := Bag new.! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:52:58'!
initializeWithFloor: aFloor andQueue: aQueue
	floor := aFloor.
	queue := aQueue.! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:59:01'!
isCabinStopped
	^true! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:31:59'!
isCabinWaitingForPeople
	^true! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:48:19'!
isIdle
	^queue isEmpty! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 16:58:03'!
isOpened
	^true! !

!ElevatorOpened methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:07:39'!
waitForPeopleTimedOut
	^ElevatorClosing new initializeWithFloor: floor andQueue: queue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorOpened class' category: #'Elevator-Ejercicio'!
ElevatorOpened class
	instanceVariableNames: ''!

!ElevatorOpened class methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:03:19'!
initialize
	^self new initializeWithFloor: 0! !


!classDefinition: #ElevatorOpening category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorOpening
	instanceVariableNames: 'floor queue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:57'!
cabinDoorClosed! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:52:30'!
cabinDoorOpened
	^ElevatorOpened new initializeWithFloor: floor andQueue: queue.! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:57'!
cabinOnFloor: aFloor
	floor := aFloor! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:23:09'!
closeCabinDoor! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:57'!
floorNumber
	^floor! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 18:00:59'!
goUpPushedFromFloor: aFloor
	queue add: aFloor.
	^ElevatorClosing new initializeWithFloor: floor andQueue: queue! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:49:52'!
initializeWithFloor: aFloor
	floor := aFloor.
	queue := Bag new.! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 10:05:43'!
initializeWithFloor: aFloor andQueue: aQueue
	floor := aFloor.
	queue := aQueue.! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:57'!
isCabinStopped
	^true! !

!ElevatorOpening methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:16:23'!
isOpening
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorOpening class' category: #'Elevator-Ejercicio'!
ElevatorOpening class
	instanceVariableNames: ''!

!ElevatorOpening class methodsFor: 'as yet unclassified' stamp: 'rb 10/3/2017 17:12:57'!
initialize
	^self new initializeWithFloor: 0! !

ElevatorStatus initialize!
ElevatorClosed initialize!
ElevatorClosing initialize!
ElevatorOpened initialize!
ElevatorOpening initialize!