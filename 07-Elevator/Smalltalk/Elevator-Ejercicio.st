!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorEmergency class' category: #'Elevator-Ejercicio'!
ElevatorEmergency class
	instanceVariableNames: ''!

!ElevatorEmergency class methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 20:58:48'!
cabinError
	^ElevatorEmergency new signal: 'Sensor de cabina desincronizado'! !

!ElevatorEmergency class methodsFor: 'as yet unclassified' stamp: 'rb 10/4/2017 20:59:28'!
doorError
	^ElevatorEmergency new signal: 'Sensor de puerta desincronizado'! !


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

!ElevatorTest methodsFor: 'tests 1' stamp: 'rb 10/5/2017 00:57:28'!
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

!ElevatorController methodsFor: 'comparing' stamp: 'rb 10/3/2017 16:51:44'!
cabinFloorNumber

	^elevatorStatus floorNumber.! !

!ElevatorController methodsFor: 'comparing' stamp: 'f.o.} 10/2/2017 19:54:47'!
elevatorDoorIsClosed
	^(self elevatorDoorIsOpened) not.! !

!ElevatorController methodsFor: 'comparing' stamp: 'rb 10/3/2017 16:43:32'!
elevatorDoorIsOpened
	^elevatorStatus elevatorDoorIsOpened.! !

!ElevatorController methodsFor: 'comparing' stamp: 'rb 10/3/2017 13:10:06'!
isCabinMoving

	^(self isCabinStopped) not.! !

!ElevatorController methodsFor: 'comparing' stamp: 'rb 10/3/2017 16:45:05'!
isCabinStopped

	^elevatorStatus isCabinStopped.! !

!ElevatorController methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:29:50'!
isCabinWaitingForPeople

	^elevatorStatus isCabinWaitingForPeople.! !

!ElevatorController methodsFor: 'comparing' stamp: 'rb 10/3/2017 16:45:13'!
isIdle
	
	^elevatorStatus isIdle.! !

!ElevatorController methodsFor: 'comparing' stamp: 'f.o.} 10/2/2017 19:55:57'!
isWorking

	^(self isIdle) not.! !


!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/3/2017 16:51:14'!
cabinDoorClosed

	elevatorStatus := elevatorStatus cabinDoorClosed.! !

!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/3/2017 16:51:29'!
cabinDoorOpened

	elevatorStatus := elevatorStatus cabinDoorOpened.! !

!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/3/2017 16:51:51'!
cabinOnFloor: aFloor

	elevatorStatus := elevatorStatus cabinOnFloor: aFloor.! !

!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/4/2017 10:09:53'!
closeCabinDoor
	elevatorStatus := elevatorStatus closeCabinDoor.! !

!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/3/2017 16:52:02'!
goUpPushedFromFloor: aFloor
	
	elevatorStatus := elevatorStatus goUpPushedFromFloor: aFloor.! !

!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/3/2017 16:45:34'!
openCabinDoor
	elevatorStatus := elevatorStatus openCabinDoor.! !

!ElevatorController methodsFor: 'controller order' stamp: 'rb 10/4/2017 10:06:54'!
waitForPeopleTimedOut
	elevatorStatus := elevatorStatus waitForPeopleTimedOut ! !


!ElevatorController methodsFor: 'initialization' stamp: 'rb 10/3/2017 16:54:06'!
initialize
	elevatorStatus := ElevatorOpened initialize.! !


!ElevatorController methodsFor: 'status' stamp: 'rb 10/3/2017 16:44:25'!
isCabinDoorClosed

	^elevatorStatus isClosed.! !

!ElevatorController methodsFor: 'status' stamp: 'rb 10/3/2017 16:44:36'!
isCabinDoorClosing

	^elevatorStatus isClosing.! !

!ElevatorController methodsFor: 'status' stamp: 'rb 10/3/2017 16:44:45'!
isCabinDoorOpened

	^elevatorStatus isOpened.! !

!ElevatorController methodsFor: 'status' stamp: 'rb 10/3/2017 16:44:56'!
isCabinDoorOpening

	^elevatorStatus isOpening.! !


!classDefinition: #ElevatorStatus category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:06:26'!
elevatorDoorIsOpened
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:06:32'!
floorNumber
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:06:43'!
isCabinStopped
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:29:38'!
isCabinWaitingForPeople
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:16:09'!
isClosed
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:16:06'!
isClosing
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:06:46'!
isIdle
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:06:49'!
isOpened
	^false! !

!ElevatorStatus methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:16:12'!
isOpening
	^false! !


!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:06:04'!
cabinDoorClosed
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:06:08'!
cabinDoorOpened
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:06:15'!
cabinOnFloor: aFloor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/4/2017 10:09:38'!
closeCabinDoor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:06:37'!
goUpPushedFromFloor: aFloor
	self subclassResponsibility ! !

!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:26:01'!
openCabinDoor! !

!ElevatorStatus methodsFor: 'controller order' stamp: 'rb 10/4/2017 10:04:38'!
waitForPeopleTimedOut
	self subclassResponsibility ! !


!ElevatorStatus methodsFor: 'initialization' stamp: 'rb 10/3/2017 17:05:58'!
initializeWithFloor: aFloor
	self subclassResponsibility ! !


!classDefinition: #ElevatorClosed category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorClosed
	instanceVariableNames: 'floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorClosed methodsFor: 'comparing' stamp: 'rb 10/5/2017 10:43:39'!
floorNumber
	^floor floorValue.! !

!ElevatorClosed methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:16:53'!
isClosed
	^true! !


!ElevatorClosed methodsFor: 'controller order' stamp: 'rb 10/4/2017 21:00:16'!
cabinDoorClosed
	^ElevatorEmergency doorError .! !

!ElevatorClosed methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:12:17'!
cabinDoorOpened! !

!ElevatorClosed methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:35:47'!
cabinOnFloor: aFloor
	(floor checkNextFloor: aFloor) ifTrue:[
		^ElevatorOpening new initializeWithFloor: (floor nextFloor).].
	^ElevatorEmergency cabinError.! !

!ElevatorClosed methodsFor: 'controller order' stamp: 'rb 10/4/2017 10:22:48'!
closeCabinDoor! !

!ElevatorClosed methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:26:00'!
goUpPushedFromFloor: aFloor
	floor nextFloorValue: aFloor.
	^ElevatorClosing new initializeWithFloor: floor.! !


!ElevatorClosed methodsFor: 'initialization' stamp: 'rb 10/5/2017 09:58:38'!
initializeWithFloor: aFloor.
	floor := aFloor.! !


!classDefinition: #ElevatorClosing category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorClosing
	instanceVariableNames: 'floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorClosing methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:14:22'!
elevatorDoorIsOpened
	^true! !

!ElevatorClosing methodsFor: 'comparing' stamp: 'rb 10/5/2017 10:43:43'!
floorNumber
	^floor floorValue.! !

!ElevatorClosing methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:01:48'!
isCabinStopped
	^true! !

!ElevatorClosing methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:16:39'!
isClosing
	^true! !


!ElevatorClosing methodsFor: 'controller order' stamp: 'rb 10/5/2017 09:58:52'!
cabinDoorClosed
	^ElevatorClosed new initializeWithFloor: floor.! !

!ElevatorClosing methodsFor: 'controller order' stamp: 'rb 10/5/2017 09:58:56'!
cabinDoorOpened
	^ElevatorOpened new initializeWithFloor: floor.! !

!ElevatorClosing methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:38:18'!
cabinOnFloor: aFloor
	(floor checkNextFloor: aFloor) ifTrue:[
		^ElevatorOpening new initializeWithFloor: (floor nextFloor).].
	^ElevatorEmergency cabinError.! !

!ElevatorClosing methodsFor: 'controller order' stamp: 'rb 10/3/2017 17:57:57'!
goUpPushedFromFloor: aFloor! !

!ElevatorClosing methodsFor: 'controller order' stamp: 'rb 10/5/2017 09:59:33'!
openCabinDoor
	^ElevatorOpening new initializeWithFloor: floor.! !


!ElevatorClosing methodsFor: 'initialization' stamp: 'rb 10/5/2017 09:59:25'!
initializeWithFloor: aFloor
	floor := aFloor.! !


!classDefinition: #ElevatorOpened category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorOpened
	instanceVariableNames: 'floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorOpened methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:14:04'!
elevatorDoorIsOpened
	^true! !

!ElevatorOpened methodsFor: 'comparing' stamp: 'rb 10/5/2017 10:43:46'!
floorNumber
	^floor floorValue.! !

!ElevatorOpened methodsFor: 'comparing' stamp: 'rb 10/3/2017 16:59:01'!
isCabinStopped
	^true! !

!ElevatorOpened methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:31:59'!
isCabinWaitingForPeople
	^true! !

!ElevatorOpened methodsFor: 'comparing' stamp: 'rb 10/5/2017 10:42:45'!
isIdle
	^(floor haveANextFloor) not.! !

!ElevatorOpened methodsFor: 'comparing' stamp: 'rb 10/3/2017 16:58:03'!
isOpened
	^true! !


!ElevatorOpened methodsFor: 'controller order' stamp: 'rb 10/4/2017 20:59:13'!
cabinDoorClosed
	^ElevatorEmergency doorError.! !

!ElevatorOpened methodsFor: 'controller order' stamp: 'rb 10/3/2017 16:52:24'!
cabinDoorOpened! !

!ElevatorOpened methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:26:31'!
cabinOnFloor: aFloor! !

!ElevatorOpened methodsFor: 'controller order' stamp: 'rb 10/5/2017 09:54:54'!
closeCabinDoor
	(self isIdle) ifFalse:[^ElevatorClosing new initializeWithFloor: floor].! !

!ElevatorOpened methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:26:35'!
goUpPushedFromFloor: aFloor
	floor nextFloorValue: aFloor.
	^ElevatorClosing new initializeWithFloor: floor.! !

!ElevatorOpened methodsFor: 'controller order' stamp: 'rb 10/5/2017 09:56:49'!
waitForPeopleTimedOut
	^ElevatorClosing new initializeWithFloor: floor.! !


!ElevatorOpened methodsFor: 'initialization' stamp: 'rb 10/5/2017 09:56:08'!
initializeWithFloor: aFloor
	floor := aFloor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorOpened class' category: #'Elevator-Ejercicio'!
ElevatorOpened class
	instanceVariableNames: ''!

!ElevatorOpened class methodsFor: 'as yet unclassified' stamp: 'rb 10/5/2017 10:25:23'!
initialize
	^self new initializeWithFloor: (StackFloor new initializeWith: 0).! !


!classDefinition: #ElevatorOpening category: #'Elevator-Ejercicio'!
ElevatorStatus subclass: #ElevatorOpening
	instanceVariableNames: 'floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorOpening methodsFor: 'comparing' stamp: 'rb 10/5/2017 10:41:55'!
floorNumber
	^floor floorValue.! !

!ElevatorOpening methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:12:57'!
isCabinStopped
	^true! !

!ElevatorOpening methodsFor: 'comparing' stamp: 'rb 10/3/2017 17:16:23'!
isOpening
	^true! !


!ElevatorOpening methodsFor: 'controller order' stamp: 'rb 10/4/2017 21:00:55'!
cabinDoorClosed
	^ElevatorEmergency doorError .! !

!ElevatorOpening methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:00:07'!
cabinDoorOpened
	^ElevatorOpened new initializeWithFloor: floor.! !

!ElevatorOpening methodsFor: 'controller order' stamp: 'rb 10/4/2017 20:59:17'!
cabinOnFloor: aFloor
	^ElevatorEmergency cabinError.! !

!ElevatorOpening methodsFor: 'controller order' stamp: 'rb 10/4/2017 10:23:09'!
closeCabinDoor! !

!ElevatorOpening methodsFor: 'controller order' stamp: 'rb 10/5/2017 10:25:09'!
goUpPushedFromFloor: aFloor
	floor nextFloorValue: aFloor.
	^ElevatorClosing new initializeWithFloor: floor.! !


!ElevatorOpening methodsFor: 'initialization' stamp: 'rb 10/5/2017 10:00:54'!
initializeWithFloor: aFloor
	floor := aFloor.! !


!classDefinition: #NullFloor category: #'Elevator-Ejercicio'!
Object subclass: #NullFloor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!NullFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:35:24'!
floorValue
	^self! !

!NullFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:34:15'!
isAValidFloor
	^false! !


!classDefinition: #StackFloor category: #'Elevator-Ejercicio'!
Object subclass: #StackFloor
	instanceVariableNames: 'value nextFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!StackFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:32:06'!
checkNextFloor: aValue
	^ nextFloor floorValue = aValue.! !

!StackFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:24:12'!
floorValue
	^value.! !

!StackFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:33:57'!
haveANextFloor
	^ nextFloor isAValidFloor.! !

!StackFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:34:06'!
isAValidFloor
	^true! !

!StackFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:09:24'!
lastValueFromStack
	| actualFloor |
	actualFloor := self.
	[(actualFloor nextFloor class) = NullFloor] whileFalse:[
		actualFloor := actualFloor nextFloor].
	^actualFloor ! !

!StackFloor methodsFor: 'accesing' stamp: 'rb 10/5/2017 10:40:38'!
nextFloor
	^nextFloor.! !


!StackFloor methodsFor: 'adding' stamp: 'rb 10/5/2017 16:26:31'!
addNextFloor: aValue
	(aValue > value) 	ifTrue:[self goTo: aValue withSign: #+]
						ifFalse:[self goTo: aValue withSign: #-]	! !

!StackFloor methodsFor: 'adding' stamp: 'rb 10/5/2017 17:13:34'!
goTo: aValue withSign: aSign
	| previousValue |
	
	previousValue := (aValue adaptToFloat: -1 andSend: aSign) asInteger.
	(value = previousValue) ifTrue: [nextFloor := StackFloor new initializeWith: aValue] 
							ifFalse: [nextFloor := StackFloor new initializeWith: previousValue andGoTo: aValue].
							
						! !

!StackFloor methodsFor: 'adding' stamp: 'rb 10/5/2017 10:09:34'!
nextFloorValue: aValue
	(self lastValueFromStack) addNextFloor: aValue.! !


!StackFloor methodsFor: 'initialization' stamp: 'rb 10/5/2017 10:04:24'!
initializeWith: aValue
	value := aValue.
	nextFloor := NullFloor new.! !

!StackFloor methodsFor: 'initialization' stamp: 'rb 10/5/2017 10:22:20'!
initializeWith: aValue andGoTo: anotherValue
	value := aValue.
	nextFloor := NullFloor new.
	self addNextFloor: anotherValue.! !

ElevatorOpened initialize!