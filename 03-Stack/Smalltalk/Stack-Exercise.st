!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/15/2017 10:09:57'!
initialize
	top := BaseStack new.! !

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:15:45'!
isEmpty
	^top isEmpty

	! !

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:33:01'!
pop
	| previousTop |
	previousTop := self top.
	top := self stackObjectAtTop previousStackElement.
	^previousTop.

	! !

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/15/2017 10:10:16'!
push: anObject
	top := ElementStack with: anObject after: self stackObjectAtTop.

	! !

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:36:08'!
size
	^top index.! !

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:33:30'!
stackObjectAtTop
	^top
	! !

!OOStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:32:11'!
top
	^top stackValue.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #ObjectStack category: #'Stack-Exercise'!
Object subclass: #ObjectStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ObjectStack methodsFor: 'Element operations' stamp: 'rb 9/15/2017 10:14:36'!
index
	self subclassResponsibility ! !

!ObjectStack methodsFor: 'Element operations' stamp: 'rb 9/15/2017 10:15:07'!
previousStackElement
	self subclassResponsibility ! !

!ObjectStack methodsFor: 'Element operations' stamp: 'rb 9/15/2017 10:15:10'!
stackValue
	self subclassResponsibility ! !


!ObjectStack methodsFor: 'Stack operations' stamp: 'rb 9/15/2017 10:14:42'!
isEmpty
	self subclassResponsibility ! !


!classDefinition: #BaseStack category: #'Stack-Exercise'!
ObjectStack subclass: #BaseStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStack methodsFor: 'Element operations' stamp: 'rb 9/14/2017 18:35:42'!
index
	^0! !

!BaseStack methodsFor: 'Element operations' stamp: 'rb 9/15/2017 10:13:24'!
previousStackElement
	self error: OOStack stackEmptyErrorDescription! !

!BaseStack methodsFor: 'Element operations' stamp: 'rb 9/15/2017 10:13:34'!
stackValue
	self error: OOStack stackEmptyErrorDescription! !


!BaseStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:09:49'!
isEmpty
	^true! !


!classDefinition: #ElementStack category: #'Stack-Exercise'!
ObjectStack subclass: #ElementStack
	instanceVariableNames: 'value previousStackElement index'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementStack methodsFor: 'Element operations' stamp: 'rb 9/14/2017 18:35:33'!
index
	^index! !

!ElementStack methodsFor: 'Element operations' stamp: 'rb 9/14/2017 18:35:58'!
initializeWith: anObject after: aStackObject
	value := anObject.
	previousStackElement := aStackObject.
	index := aStackObject index + 1.! !

!ElementStack methodsFor: 'Element operations' stamp: 'rb 9/14/2017 18:26:32'!
previousStackElement
	^previousStackElement! !

!ElementStack methodsFor: 'Element operations' stamp: 'rb 9/14/2017 18:29:22'!
stackValue
	^value! !


!ElementStack methodsFor: 'Stack operations' stamp: 'rb 9/14/2017 18:17:35'!
isEmpty
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementStack class' category: #'Stack-Exercise'!
ElementStack class
	instanceVariableNames: ''!

!ElementStack class methodsFor: 'as yet unclassified' stamp: 'rb 9/14/2017 18:22:17'!
with: anObject after: aStackObject
	^self new initializeWith: anObject after: aStackObject! !
