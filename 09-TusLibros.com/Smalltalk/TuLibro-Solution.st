!classDefinition: #TuLibroTests category: #'TuLibro-Solution'!
TestCase subclass: #TuLibroTests
	instanceVariableNames: 'aCart catalogWithElements emptyCatalog cartWithEmptyCatalog cashier cartWithElements aValidCard anInvalidCard anInvoice anExpiredCard merchant aBook rest dataLogin merchantRest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/26/2017 16:40:40'!
testR01RestLoginAnUserWithCartEmpty

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	self assert: (rest listCart: idCart ) isEmpty 
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 16:09:18'!
testR02RestCantLoginAnUserWithInvalidID
	
	self should: [rest createCartWithClientId: 2 password: 1.] 
			raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
					self assert: anError messageText = Rest invalidUser.
					self assert: rest listCarts isEmpty.
			].
		
		self should: [rest listPurchasesId:   2 withPassword: 1.] 
			raise: Error 
		 withExceptionDo: [:anError |
					self assert: anError messageText = Rest invalidUser.
					self assert: rest listCarts isEmpty.
			].
	
	
	
	

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'KF 6/26/2017 23:32:41'!
testR03RestCantLoginAnUserWithWrongPassword

	self should: [rest createCartWithClientId: 1 password: 2.] 
			raise: Error 
		 withExceptionDo: [:anError |
					self assert: anError messageText = Rest invalidUser.
					self assert: rest listCarts isEmpty.
			].
	
	
	
	

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/26/2017 16:45:00'!
testR04RestCanAddBookISBNToCart

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	
	self assert: ((rest listCart: idCart ) contents: 1).
	self assert: (rest listCart: idCart ) elements  = 1.
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/26/2017 16:46:06'!
testR05RestRaiseErrorWhenISBNIsInvalid

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	self should: [rest addToCard: idCart isbn: 0 withQuantity: 1.]  
		raise:  Error
	 withExceptionDo: [:anError | 
				anError messageText  = Cart invalidISBN.
					self assert: (rest listCart: idCart ) elements  = 0.
		].
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/26/2017 16:45:49'!
testR06RestRaiseErrorWhenISBNIsNotInCatalog

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	self should: [rest addToCard: idCart isbn: 10 withQuantity: 1.]  
		raise:  Error
	 withExceptionDo: [:anError | 
				self assert: (anError messageText  = 'No pertenece al catalogo').
					self assert: (rest listCart: idCart ) elements  = 0.
		].
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:32:13'!
testR07RestReturnCheckoutWithCorrectID

	| idCart  idCart2 |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	idCart2 := rest createCartWithClientId: 1 password: 1.	
	rest addToCard: idCart isbn: 1 withQuantity: 1.

	rest addToCard: idCart2 isbn: 1 withQuantity: 1.	

	self assert: (rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin') = 1 .
	self assert: (rest checkout: idCart2 withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin') = 2	.! !

!TuLibroTests methodsFor: 'rest' stamp: 'F.O. 11/2/2017 15:15:39'!
testR08RestCheckoutOfElementWithInvalidCardIsNotATransaction

	| idCart  bag |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	
	bag:= Bag new.
	bag add:1.
	
	anInvoice := Invoice withElements: bag withTotal: 1.
	
	self should: [rest checkout: idCart withNumberCard: 12345679301 withExpirationDate: Date today withNameHolder: 'kevin'] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].
				
	self should: [rest checkout: idCart withNumberCard: 12345679301 withExpirationDate: (Date - 60 days) today withNameHolder: 'kevin'] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].
				
	self should: [rest checkout: idCart withNumberCard: 12345679301 withExpirationDate: (Date today) withNameHolder: ''] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].! !

!TuLibroTests methodsFor: 'rest' stamp: 'F.O. 11/2/2017 15:15:16'!
testR09RestCheckoutWithInvalidCardIsNotATransactionEver

	| idCart  bag |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1000.
	
	bag:= Bag new.
	bag add:1.
	
	anInvoice := Invoice withElements: bag withTotal: 1.
	
	self should: [rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin'] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].
			! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:36:56'!
testR10RestOnlyKnowCartsRelatedToID
	
	self should: [rest listCart: 1 ] 
			raise: Error 
		 withExceptionDo: [:anError |
					self assert: anError messageText = Rest invalidCart.
			].
	
	
	
	

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:39:57'!
testR11RestCartsFromSameIdAreDifferentCarts

	| idCart  idCart2 |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	idCart2 := rest createCartWithClientId: 1 password: 1.
	
	
	self deny:  (idCart  = idCart2).
	self deny: ((rest listCart: idCart)  = (rest listCart: idCart2 ))! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:36:01'!
testR12ARestCartIsEqualToSelf

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.	
	
	self assert: ((rest listCart: idCart)  = (rest listCart: idCart ))! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:49:57'!
testR13RestCartCanBeCheckedOutOnlyOneTime

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	rest addToCard: idCart isbn: 1 withQuantity: 1.

	self assert: (rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin') = 1 .
	self should: [rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin'] 
			raise: Error 
			withExceptionDo: [:anError | 
				self assert: (anError  messageText = Rest invalidCart).
				self assert:( rest transactions size = 1)
				]
! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:38:14'!
testR14RestInitializeIDWithoutPurchases

	self assert: (rest listPurchasesId: 1 withPassword: 1) isEmpty .

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:39:44'!
testR15RestCartsFromDifferentIdAreDifferentCarts

	| idCart  idCart2 |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	idCart2 := rest createCartWithClientId: 2 password: 2.
	
	
	self deny:  (idCart  = idCart2).
	self deny: ((rest listCart: idCart)  = (rest listCart: idCart2 ))! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:40:28'!
testR16RestCheckoutFromValidCartCountLikeAPurchase

	| idCart idCart2 |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	idCart2 := rest createCartWithClientId: 1 password: 1.	
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	rest addToCard: idCart2 isbn: 1 withQuantity: 1.	

	rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin' .
	rest checkout: idCart2 withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin'.

	self assert: (rest listPurchasesId: 1 withPassword: 1) size = 2 .

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:40:50'!
testR17RestCartAreValidWith30minutesTransaction

	| idCart |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest time: ((DateAndTime now) + 31 minutes ).
	
	self should: [rest addToCard: idCart isbn: 1 withQuantity: 1.]  
			raise: Error 
			 withExceptionDo: [:anError |
				self assert: (anError messageText = Rest timeExpired).
				self toDo: 'Falta testear que no se hayan agregado elementos sin romper encapsulamiento'
	]
	
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:42:36'!
testR18RestCartWithTransactionsIsValid

	| idCart |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest time: ((DateAndTime now) + 15 minutes ).
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	rest time: (rest time + 16 minutes ).	
	self shouldnt: [rest addToCard: idCart isbn: 1 withQuantity: 1.]  raise: Error
			
	
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'RB 6/27/2017 17:42:15'!
testR19RestCartInUseIsValid

	| idCart |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest time: ((DateAndTime now) + 15 minutes ).
	rest listCart: idCart .
	rest time: (rest time + 16 minutes ).	
	self shouldnt: [rest addToCard: idCart isbn: 1 withQuantity: 1.]  raise: Error
			
	
	! !


!TuLibroTests methodsFor: 'card' stamp: 'F.O. 11/2/2017 14:56:05'!
testCard01AValidCardIsNotExpired
	self deny:
		((CreditCard
			withNumber: 123456789913
			withName: 'kevin'
			withExpirationMonth: Date today + 1 days) isExpiredOn: Date today).! !

!TuLibroTests methodsFor: 'card' stamp: 'F.O. 11/2/2017 14:56:05'!
testCard02AValidCardWithAYearDifferenceIsNotExpired
	self deny:
		((CreditCard
			withNumber: 123456789913
			withName: 'kevin'
			withExpirationMonth: Date today + 380 days) isExpiredOn: Date today).! !

!TuLibroTests methodsFor: 'card' stamp: 'F.O. 11/2/2017 14:56:05'!
testCard03AnInvalidCardWithAYearDifferenceIsExpired
	self assert:
		((CreditCard
			withNumber: 123456789913
			withName: 'kevin'
			withExpirationMonth: Date today - 367 days) isExpiredOn: Date today).! !

!TuLibroTests methodsFor: 'card' stamp: 'F.O. 11/2/2017 14:56:05'!
testCard04AnInvalidCardWithAMonthDifferenceIsExpired
	self assert:
		((CreditCard
			withNumber: 123456789913
			withName: 'kevin'
			withExpirationMonth: Date today - 32 days) isExpiredOn: Date today).! !

!TuLibroTests methodsFor: 'card' stamp: 'F.O. 11/2/2017 14:56:05'!
testCard05AValidCardNameCantBeEmpty
	self
		should: [
			CreditCard
				withNumber: 123456789101
				withName: ''
				withExpirationMonth: Date today ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidName ].! !

!TuLibroTests methodsFor: 'card' stamp: 'F.O. 11/2/2017 14:56:05'!
testCard06AValidCardLengthIsAlways12
	self
		should: [
			CreditCard
				withNumber: 1234567891
				withName: 'ker'
				withExpirationMonth: Date today ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumber ].! !


!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:45:47'!
testCashier01ACheckoutReturnAnInvoice
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice! !

!TuLibroTests methodsFor: 'cashier' stamp: 'F.O. 11/2/2017 13:37:19'!
testCashier02ACashierRaiseAnErrorIfCardIsInvalid
	merchant addValidCard: anExpiredCard.
	cashier _ self
		cashierWithCart: cartWithElements
		withCard: anExpiredCard
		withBook: aBook.
	self
		should: [
			cashier
				checkOutOnDate: Date today
				withMerchant: merchant ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard expiredError.
			self assert: aBook isEmpty ].! !

!TuLibroTests methodsFor: 'cashier' stamp: 'F.O. 11/2/2017 13:37:19'!
testCashier03ACashierRaiseAnErrorIfCardWithoutBalance
	merchant
		addValidCard: aValidCard
		withAmount: 0.
	cashier _ self
		cashierWithCart: cartWithElements
		withCard: aValidCard
		withBook: aBook.
	self
		should: [
			cashier
				checkOutOnDate: Date today
				withMerchant: merchant ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard withoutBalance.
			self assert: aBook isEmpty ].! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:46:14'!
testCashier04ACashierCheckoutReturnAnInvoice
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice.
	self deny: aBook isEmpty ! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:46:25'!
testCashier05ACashierRaiseAnErrorIfMPisOutOfService

	merchant putOutService.
	merchant addValidCard: aValidCard withAmount: 0.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self should: [cashier checkOutOnDate: (Date today) withMerchant: merchant ]  
		 raise: Error 
		 withExceptionDo: [:anError | self assert: anError messageText = MerchantProcesorMock outService .
								self assert: aBook isEmpty.
						]! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:46:39'!
testCashier06ACashierCheckoutReturnAnInvoceWithCartElements
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) elements = anInvoice elements! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:46:50'!
testCashier07ACashierCheckoutReturnAnInvoiceTotal
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) total = anInvoice total! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:47:01'!
testCashier08ACashierCheckoutReturnAnInvoiceWithRightTotalValue
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self deny: (cashier checkOutOnDate: Date today withMerchant: merchant ) total = 1! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:47:12'!
testCashier09ACashierBookAfterACheckoutIsNotEmpty
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice.
	self deny: aBook isEmpty.
	self assert: (aBook includes: anInvoice).! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:47:21'!
testCashier10ACashierBookHasCorrectInvoices
	
	merchant addValidCard: aValidCard.
	
	cartWithElements := Cart withCatalog: catalogWithElements .
	cartWithElements add: 1 quantity: 100.
	
	anInvoice := Invoice withElements: (cartWithElements products ) withTotal: 100.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice.
	self deny: aBook isEmpty.
	self assert: (aBook includes: anInvoice).! !

!TuLibroTests methodsFor: 'cashier' stamp: 'RB 6/26/2017 15:47:31'!
testCashier11ACashierInvalidCheckoutIsNotRegisteredInBook
	
	merchant addValidCard: aValidCard withAmount: 50.
	
	cartWithElements := Cart withCatalog: catalogWithElements .
	cartWithElements add: 1 quantity: 100.
	
	
	
	self should: [cashier checkOutOnDate: Date today withMerchant: merchant ] 
		raise: Error withExceptionDo: [:anError | 
				self assert: aBook isEmpty.
			]
	
! !


!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:11:03'!
test01ACartIsInitializeEmpty
	self assert: aCart isEmpty.! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:11:24'!
test02ACartWithElementsIsNotEmpty
	aCart add: 1.
	self deny: aCart isEmpty.! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:11:56'!
test03ACartKnowsWhenHasOneElement
	aCart add: 1.
	self assert: aCart elements = 1! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:12:27'!
test04ACartKnowsWhenHasAnyElementQuantity
	aCart add: 1.
	aCart add: 2.
	self assert: aCart elements = 2! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:13:02'!
test05ACartWithAQuantityOfOneElementCountsGood
	aCart add: 1 quantity: 2.
	aCart add: 2.
	self assert: aCart elements = 3! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:13:42'!
test06ACartKnowWhenHasOneContent
	aCart add: 1 quantity: 2.
	self assert: (aCart contents: 1)! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:14:07'!
test07ACartKnowHowManyContentsHas
	aCart add: 1 quantity: 2.
	self deny: (aCart contents: 2)! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:16:00'!
test08ACartKnowWhenAContentGotTwoElements
	aCart add: 1 quantity: 2.
	self assert: (aCart quantityOf: 1 ) = 2! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:16:25'!
test09ACartKnowHowManyElementsGotFromAContent

	aCart add: 1 quantity: 1.
	self assert: (aCart quantityOf: 1 ) = 1! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:17:10'!
test10ACartCantAddThingsThatAreNotInTheCatalog

	self should: [cartWithEmptyCatalog add: 1] 
		raise: Error 
		withExceptionDo: [:anError |
								anError messageText = 'No pertenece al catalogo'.
								self assert: cartWithEmptyCatalog isEmpty .
							 ].! !


!TuLibroTests methodsFor: 'merchant' stamp: 'F.O. 11/2/2017 13:37:18'!
testM01AMerchantCantDebitAnExpiredCard
	self
		should: [
			merchant
				debit: 100
				withCard: anExpiredCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			anError messageText = CreditCard expiredError ].! !

!TuLibroTests methodsFor: 'merchant' stamp: 'RB 6/26/2017 15:49:31'!
testM02AMerchantDebitAValidCard
	
	merchant addValidCard: aValidCard.
	
	self shouldnt: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 ! !

!TuLibroTests methodsFor: 'merchant' stamp: 'F.O. 11/2/2017 13:37:19'!
testM03AMerchantCantDebitACardWithoutAddHer
	self
		should: [
			merchant
				debit: 100
				withCard: aValidCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidCard ].! !

!TuLibroTests methodsFor: 'merchant' stamp: 'F.O. 11/2/2017 13:37:18'!
testM04AMerchantCantDebitAnAmountThatACardHasnt
	merchant
		addValidCard: aValidCard
		withAmount: 50.
	self
		should: [
			merchant
				debit: 100
				withCard: aValidCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard withoutBalance ].! !

!TuLibroTests methodsFor: 'merchant' stamp: 'RB 6/26/2017 15:50:16'!
testM05AMerchantProccesorCantDebitIfItIsOutOfService

		
		merchant putOutService.
		
		self should: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: (anError messageText = MerchantProcesorMock outService )]! !


!TuLibroTests methodsFor: 'setUp' stamp: 'kf 6/18/2017 11:36:06'!
cashierWithCart: aCart withCard: aCard withBook: aBook 
	^ Cashier withCart: aCart withCard: aCard withBook: aBook ! !

!TuLibroTests methodsFor: 'setUp' stamp: 'F.O. 11/2/2017 15:02:35'!
setUp
	catalogWithElements _ Dictionary new.
	catalogWithElements at: 1 put: 1.
	catalogWithElements at: 2 put: 1.
	emptyCatalog _ Dictionary new.
	aCart _ Cart withCatalog: catalogWithElements.
	cartWithEmptyCatalog _ Cart withCatalog: emptyCatalog.
	cartWithElements _ Cart withCatalog: catalogWithElements.
	cartWithElements add: 1.
	cartWithElements add: 2.
	cashier _ Cashier new.
	aValidCard _ CreditCard
		withNumber: 123456789101
		withName: 'kevin'
		withExpirationMonth: Date today + 1 days.
	anExpiredCard _ CreditCard
		withNumber: 213456789101
		withName: 'kevin'
		withExpirationMonth: Date today - 60 days.
	anInvoice _ Invoice
		withElements: cartWithElements products
		withTotal: 2.
	merchant _ MerchantProcesorMock withDate: Date today.
	aBook _ OrderedCollection new.
	dataLogin _ Dictionary new.
	dataLogin
		at: 1
		put: 1.
	dataLogin
		at: 2
		put: 2.
	merchantRest _ MerchantProcesorMock withDate: Date today.
	merchantRest
		addValidCard:
			(CreditCard
				withNumber: 123456789301
				withName: 'kevin'
				withExpirationMonth: Date today)
		withAmount: 100.
	rest _ Rest
		withCatalog: catalogWithElements
		withDataLogin: dataLogin
		withTime: DateAndTime now
		withMerchant: merchantRest
		withBook: aBook.! !


!TuLibroTests methodsFor: 'toDo' stamp: 'kf 6/25/2017 11:10:59'!
toDo: aString 
! !


!classDefinition: #Cart category: #'TuLibro-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'elements catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!Cart methodsFor: 'initialization' stamp: 'kf 6/13/2017 20:04:38'!
initialize
	elements := Bag new.! !

!Cart methodsFor: 'initialization' stamp: 'kf 6/15/2017 19:18:12'!
withCatalog: anOrderedCollection 
	catalog := anOrderedCollection.
	elements := Bag new.
	! !


!Cart methodsFor: 'adding' stamp: 'kf 6/15/2017 19:18:49'!
add: anElement
	self add: anElement quantity: 1.
! !

!Cart methodsFor: 'adding' stamp: 'F.O. 11/2/2017 15:09:35'!
add: anElement quantity: aQuantity 
	self assert: aQuantity isInteger description: [self error: 'Invalid isbn'].
	self assert:  aQuantity  > 0 description: [self error: 'Invalid isbn'].
	
	self assert: (catalog includesKey: anElement) description: [self error: 'No pertenece al catalogo'].
	
	elements add: anElement withOccurrences: aQuantity.
	! !


!Cart methodsFor: 'accessing' stamp: 'kf 6/13/2017 23:30:06'!
catalog
	^ catalog ! !

!Cart methodsFor: 'accessing' stamp: 'kf 6/13/2017 23:07:58'!
contents: anElement
		^ elements includes: anElement .! !

!Cart methodsFor: 'accessing' stamp: 'kf 6/13/2017 20:09:40'!
elements
	^ elements size ! !

!Cart methodsFor: 'accessing' stamp: 'kf 6/11/2017 19:59:44'!
isEmpty
	^ elements isEmpty .! !

!Cart methodsFor: 'accessing' stamp: 'kf 6/25/2017 12:11:37'!
products 
	^ elements! !

!Cart methodsFor: 'accessing' stamp: 'kf 6/13/2017 20:10:23'!
quantityOf: anElement
	^ elements occurrencesOf: anElement 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TuLibro-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'class initialization' stamp: 'kf 6/13/2017 22:37:17'!
withCatalog: anOrderedCollection 
	^ self new withCatalog: anOrderedCollection ! !


!Cart class methodsFor: 'exceptions' stamp: 'kf 6/25/2017 11:35:02'!
invalidISBN
	^ 'invalid isbn'! !


!classDefinition: #Cashier category: #'TuLibro-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card book'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!Cashier methodsFor: 'checkout' stamp: 'F.O. 11/2/2017 13:37:19'!
checkOutOnDate: aDate withMerchant: aMerchantProcesor
	| cost invoice |
	self
		assert: (card isExpiredOn: aDate) not
		description: [ self error: CreditCard expiredError ].
	cost _ self cost.
	self
		debit: aMerchantProcesor
		withAmount: cost.
	invoice _ Invoice
		withElements: cart products
		withTotal: cost.
	book add: invoice.
	^ invoice.! !

!Cashier methodsFor: 'checkout' stamp: 'kf 6/18/2017 12:48:12'!
debit: aMerchantProcesor withAmount: amountToDebit

	 aMerchantProcesor debit: amountToDebit withCard: card 
! !

!Cashier methodsFor: 'checkout' stamp: 'F.O. 11/2/2017 13:35:54'!
isCartEmpty

	cart isEmpty  ifTrue: [	self error: 'No me pases un cart vacio'.]! !


!Cashier methodsFor: 'accessing' stamp: 'F.O. 11/2/2017 15:10:22'!
cost
	|catalog cost|

	self isCartEmpty.
	
	catalog := cart catalog.
	cost := 0.
	(cart products) do:[:element | 
								cost := cost + (catalog at: element)
							 ].

	^ cost.
! !


!Cashier methodsFor: 'initialization' stamp: 'kf 6/18/2017 11:46:55'!
withCart: aCart withCard: aCard withBook: aBook 
	cart := aCart.
	card := aCard.
	book := aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TuLibro-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'class initialization' stamp: 'kf 6/18/2017 11:39:26'!
withCart: aCart withCard: aCard withBook: anUndefinedObject 
	^ self new withCart: aCart withCard: aCard withBook: anUndefinedObject ! !


!classDefinition: #CreditCard category: #'TuLibro-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber cardHolder expirationMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!CreditCard methodsFor: 'accessing' stamp: 'kf 6/18/2017 11:19:47'!
cardNumber
	^ cardNumber ! !

!CreditCard methodsFor: 'accessing' stamp: 'F.O. 11/2/2017 14:56:33'!
isExpired

|actualMonthYear|
	
	actualMonthYear := Month month: (Date today monthIndex ) year:  (Date today yearNumber ).
	(expirationMonth yearNumber < actualMonthYear yearNumber) ifTrue: [^true].
	((expirationMonth monthIndex < actualMonthYear monthIndex ) and: [expirationMonth yearNumber = actualMonthYear yearNumber]) ifTrue: [^true].

^false! !

!CreditCard methodsFor: 'accessing' stamp: 'F.O. 11/2/2017 14:56:40'!
isExpiredOn: aDate
	
	(expirationMonth yearNumber < aDate yearNumber) ifTrue: [^true].
	((expirationMonth monthIndex < aDate monthIndex ) and: [expirationMonth yearNumber = aDate yearNumber]) ifTrue: [^true].
	^false! !


!CreditCard methodsFor: 'initialization' stamp: 'F.O. 11/2/2017 14:57:48'!
withNumber: acardNumber withName: acardHolder withExpirationMonth: amonthOfYear
	cardNumber _ acardNumber.
	cardHolder _ acardHolder.
	expirationMonth _ amonthOfYear.! !


!CreditCard methodsFor: 'comparing' stamp: 'kf 6/18/2017 11:07:57'!
= aCard

	(aCard isKindOf: self class) ifFalse: [^false].
	^ cardNumber = aCard cardNumber! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TuLibro-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'F.O. 11/2/2017 14:56:05'!
withNumber: cardNumber withName: cardHolder withExpirationMonth: monthYear
	self
		assert: cardHolder isEmpty not
		description: [ self error: CreditCard invalidName ].
	self
		assert: cardNumber decimalDigitLength = 12
		description: [ self error: CreditCard invalidNumber ].
	^ self new
		withNumber: cardNumber
		withName: cardHolder
		withExpirationMonth: monthYear.! !


!CreditCard class methodsFor: 'exceptions' stamp: 'RB 6/27/2017 17:26:19'!
expiredError
	^ 'La tarjeta expiro'.! !

!CreditCard class methodsFor: 'exceptions' stamp: 'kf 6/18/2017 12:49:53'!
invalidCard
	^ 'Tarjeta invalida' ! !

!CreditCard class methodsFor: 'exceptions' stamp: 'kf 6/22/2017 19:22:26'!
invalidName
	^ 'Nombre invalido'! !

!CreditCard class methodsFor: 'exceptions' stamp: 'kf 6/22/2017 19:26:36'!
invalidNumber
	^ 'invalid number'! !

!CreditCard class methodsFor: 'exceptions' stamp: 'kf 6/18/2017 12:50:30'!
withoutBalance
	^ 'Sin Saldo'! !


!classDefinition: #Invoice category: #'TuLibro-Solution'!
Object subclass: #Invoice
	instanceVariableNames: 'elements total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!Invoice methodsFor: 'accessing' stamp: 'kf 6/25/2017 12:14:18'!
elements
	^ elements ! !

!Invoice methodsFor: 'accessing' stamp: 'kf 6/25/2017 12:22:00'!
total
	^ total! !


!Invoice methodsFor: 'initialization' stamp: 'kf 6/25/2017 12:23:43'!
withElements: aBag withTotal: aTotal 
	elements := aBag.
	total := aTotal .! !


!Invoice methodsFor: 'comparing' stamp: 'kf 6/25/2017 12:17:36'!
= anInvoice

	^ elements  = anInvoice elements .! !

!Invoice methodsFor: 'comparing' stamp: 'kf 6/15/2017 19:38:05'!
isInvoice
	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Invoice class' category: #'TuLibro-Solution'!
Invoice class
	instanceVariableNames: 'elements'!

!Invoice class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 12:13:38'!
withElements: aBag 
	^ self new withElements: aBag .! !

!Invoice class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 12:23:18'!
withElements: aBag withTotal: aTotal
	^ self new withElements: aBag withTotal: aTotal! !


!classDefinition: #MerchantProcesorMock category: #'TuLibro-Solution'!
Object subclass: #MerchantProcesorMock
	instanceVariableNames: 'card today amount outService'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!MerchantProcesorMock methodsFor: 'add' stamp: 'kf 6/18/2017 16:48:37'!
addValidCard: aCard
	card := aCard.
	amount := 1000000000000.! !

!MerchantProcesorMock methodsFor: 'add' stamp: 'kf 6/18/2017 16:48:34'!
addValidCard: aCard withAmount: anAmount 
	card := aCard .
	amount := anAmount.! !


!MerchantProcesorMock methodsFor: 'debit' stamp: 'F.O. 11/2/2017 13:37:19'!
debit: amountToDebit withCard: aCard
	self
		assert: outService not
		description: [ self error: MerchantProcesorMock outService ].
	self
		assert: (aCard isExpiredOn: today) not
		description: [ self error: CreditCard expiredError ].
	self
		assert: card = aCard
		description: [ self error: CreditCard invalidCard ].
	self
		assert: amountToDebit < amount
		description: [ self error: CreditCard withoutBalance ].
	^ true.! !


!MerchantProcesorMock methodsFor: 'initialization' stamp: 'kf 6/18/2017 16:48:44'!
withDate: aDate 
	today := aDate.
	outService  := false.! !


!MerchantProcesorMock methodsFor: 'serviceStatus' stamp: 'kf 6/18/2017 13:04:15'!
putOutService
	outService := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorMock class' category: #'TuLibro-Solution'!
MerchantProcesorMock class
	instanceVariableNames: ''!

!MerchantProcesorMock class methodsFor: 'class initialization' stamp: 'kf 6/18/2017 11:17:35'!
withDate: aDate 
	^ self new withDate: aDate.! !


!MerchantProcesorMock class methodsFor: 'exceptions' stamp: 'kf 6/18/2017 13:03:33'!
outService
	^ 'Sin servicio'! !


!classDefinition: #Rest category: #'TuLibro-Solution'!
Object subclass: #Rest
	instanceVariableNames: 'catalog carts dataLogin time book merchant transactions cartsCheckout usersCarts actionsCarts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro-Solution'!

!Rest methodsFor: 'configuration' stamp: 'KF 6/27/2017 00:54:24'!
addToCard: cartId isbn: isbn withQuantity: aQuantity 
	
	| cart |
	cart:= self listCart: cartId.
	cart add: isbn quantity: aQuantity .
	^ true.! !

!Rest methodsFor: 'configuration' stamp: 'KF 6/27/2017 00:51:59'!
createCartWithClientId: clientId password: password 

	self validateUser: clientId withPassword: password.
	
	carts addLast: (Cart withCatalog: catalog).
	(usersCarts at: clientId  ifAbsentPut: [OrderedCollection new .]) add: (carts size).
	self updateTimeCart: (carts size).
	
	^ carts size.! !

!Rest methodsFor: 'configuration' stamp: 'KF 6/27/2017 00:24:20'!
time: aDateAndTime 
	time := aDateAndTime .! !

!Rest methodsFor: 'configuration' stamp: 'KF 6/27/2017 00:52:31'!
updateTimeCart: idCart 
	actionsCarts at: idCart put: time! !

!Rest methodsFor: 'configuration' stamp: 'KF 6/26/2017 23:32:49'!
validateUser: clientId withPassword: password 
	self assert: (dataLogin at: clientId  ifAbsent: [self error: Rest invalidUser ]) = password description: [self error: Rest invalidUser].! !


!Rest methodsFor: 'checkout' stamp: 'F.O. 11/2/2017 14:56:05'!
checkout: cartId withNumberCard: numberCard withExpirationDate: anExpirationDate withNameHolder: aNameHolder
	| aCart aCashier aCard |
	aCard _ CreditCard
		withNumber: numberCard
		withName: aNameHolder
		withExpirationMonth: anExpirationDate.
	aCart _ self listCart: cartId.
	aCashier _ Cashier
		withCart: aCart
		withCard: aCard
		withBook: book.
	transactions add:
		(aCashier
			checkOutOnDate: time
			withMerchant: merchant).
	cartsCheckout add: cartId.
	^ transactions size.! !


!Rest methodsFor: 'accessing' stamp: 'F.O. 11/2/2017 15:17:40'!
listCart: idCart

	(cartsCheckout includes: idCart  ) ifTrue: [self error: Rest invalidCart].
	(((actionsCarts at:idCart ifAbsent: [self error: Rest invalidCart] ) + 30 minutes) < time) ifTrue: [self error: Rest timeExpired].
	self updateTimeCart: idCart .	
	"[ ^carts at: idCart .] on: Error do: [self error: Rest invalidCart ]."
	^carts at: idCart ! !

!Rest methodsFor: 'accessing' stamp: 'KF 6/26/2017 23:00:44'!
listCarts
	^ carts ! !

!Rest methodsFor: 'accessing' stamp: 'RB 6/27/2017 16:09:09'!
listPurchasesId: clientId withPassword: password 
	self validateUser: clientId withPassword: password.
	^ usersCarts at: clientId ifAbsent: [^ OrderedCollection new.]. 
! !

!Rest methodsFor: 'accessing' stamp: 'KF 6/27/2017 00:50:53'!
time
	^time! !

!Rest methodsFor: 'accessing' stamp: 'kf 6/25/2017 12:42:31'!
transactions
	^ transactions ! !


!Rest methodsFor: 'initialization' stamp: 'KF 6/27/2017 00:25:35'!
withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate withMerchant: aMerchantProcesorMock withBook: aBook 
	catalog := aCatalog.
	dataLogin := aDictionary.
	carts  := OrderedCollection new.
	time := aDate.
	merchant := aMerchantProcesorMock.
	book  := aBook .
	transactions := OrderedCollection new.
	cartsCheckout := OrderedCollection new.
	usersCarts := Dictionary new.
	actionsCarts := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rest class' category: #'TuLibro-Solution'!
Rest class
	instanceVariableNames: ''!

!Rest class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 10:52:05'!
withCatalog: aCatalog 
	^ self new withCatalog: aCatalog .! !

!Rest class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 11:02:03'!
withCatalog: aCatalog withDataLogin: aDictionary 
	^self new withCatalog: aCatalog withDataLogin: aDictionary.! !

!Rest class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 11:41:42'!
withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate 
	^ self new withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate ! !

!Rest class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 11:57:49'!
withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate withMerchant: aMerchantProcesorMock withBook: anOrderedCollection 
	^ self new withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate withMerchant: aMerchantProcesorMock withBook: anOrderedCollection ! !


!Rest class methodsFor: 'exceptions' stamp: 'KF 6/25/2017 21:08:06'!
invalidCart
	^ 'invalid cart'! !

!Rest class methodsFor: 'exceptions' stamp: 'kf 6/25/2017 11:08:03'!
invalidUser
	^ 'Invalid user/password'! !

!Rest class methodsFor: 'exceptions' stamp: 'KF 6/27/2017 00:23:02'!
timeExpired
	^ 'time expired'! !
