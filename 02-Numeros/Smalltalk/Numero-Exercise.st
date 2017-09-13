!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !


!NumeroTest methodsFor: 'setup' stamp: 'HernanWilkinson 5/7/2016 20:56'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	four := Entero with: 4.
	five := Entero with: 5.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !


!Numero methodsFor: 'testing' stamp: 'rb 9/13/2017 01:39:40'!
checkDenominator! !

!Numero methodsFor: 'testing' stamp: 'rb 9/13/2017 01:39:36'!
checkNumerator! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'rb 9/13/2017 00:47:38'!
isOne
	
	^false! !

!Entero methodsFor: 'testing' stamp: 'rb 9/13/2017 00:47:43'!
isZero
	
	^false! !


!Entero methodsFor: 'comparing' stamp: 'rb 9/12/2017 20:03:43'!
= anObject

	^ anObject isEqualToInteger: self! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 00:48:15'!
* aMultiplier 
	
	^aMultiplier multiplyInteger: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:15:49'!
+ anAdder 
	
	^anAdder addInteger: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:50:40'!
/ aDivisor 
	
	^aDivisor divideInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:13:33'!
addFraction: aFraction

	^aFraction addInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:09:08'!
addInteger: anInteger

	^self class with: value + anInteger integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 01:01:27'!
addOne: aOne

	^self class with: value + 1! !

!Entero methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:50:11'!
divideFraction: aFraction

	^(aFraction numerator ) / (aFraction denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:47:34'!
divideInteger: anInteger

	^Fraccion with: anInteger over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 01:01:12'!
divideOne: aOne

	^Fraccion with: aOne over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/12/2017 20:09:58'!
isEqualToFraction: aFraction

	^ (self integerValue * aFraction denominator) = aFraction numerator integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/12/2017 20:04:34'!
isEqualToInteger: anInteger

	^ self integerValue = anInteger integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 00:48:23'!
multiplyFraction: aFraction

	^aFraction multiplyInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 00:48:01'!
multiplyInteger: anInteger

	^self class with: value * anInteger integerValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'rb 9/13/2017 00:57:41'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	(aValue = 0) ifTrue: [^Zero new].
	(aValue = 1) ifTrue: [^One new].
	
	^self new initalizeWith: aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'initialization' stamp: 'rb 9/13/2017 01:44:24'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator checkNumerator.
	aDenominator checkDenominator.
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'rb 9/12/2017 20:06:08'!
= anObject

	^ anObject isEqualToFraction: self! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !

!Fraccion methodsFor: 'comparing' stamp: 'rb 9/12/2017 20:14:57'!
isEqualToFraction: aFraction

	^ (self denominator * aFraction numerator) = (aFraction denominator * self numerator)! !

!Fraccion methodsFor: 'comparing' stamp: 'rb 9/12/2017 20:15:00'!
isEqualToInteger: anInteger

	^ self numerator integerValue = (self denominator * anInteger) integerValue ! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 00:48:37'!
* aMultiplier 
	
	^aMultiplier multiplyFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:26:03'!
+ anAdder 
	
	^anAdder addFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:50:55'!
/ aDivisor 
	
	^aDivisor divideFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:09:40'!
addFraction: aFraction

	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:10:59'!
addInteger: anIngeter

	| newNumerator |
	
	newNumerator := (denominator * anIngeter) + numerator.
	
	^newNumerator / denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 01:00:18'!
addOne: aOne

	| newNumerator |
	
	newNumerator := denominator + numerator.
	
	^newNumerator / denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:40:20'!
divideFraction: aFraction

	^( aFraction numerator * denominator ) / ( aFraction denominator  * numerator )! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'F.O. 9/12/2017 19:51:31'!
divideInteger: anInteger

	^( anInteger * denominator ) / ( numerator )! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 01:10:14'!
divideOne: aOne

	^Fraccion with: denominator over: numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 00:48:46'!
multiplyFraction: aFraction

	^(numerator * aFraction numerator) / (denominator * aFraction denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 9/13/2017 00:48:52'!
multiplyInteger: anInteger

	^(numerator * anInteger) / denominator! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'rb 9/13/2017 01:48:40'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
		
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue:[^numerator].
	
	^self new initializeWith: numerator over: denominator
	! !


!classDefinition: #One category: #'Numero-Exercise'!
Numero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:37:59'!
* aMultiplier 
	
	^aMultiplier! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:41:12'!
+ anAdder 
	
	^ anAdder addOne: self.! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:41:57'!
/ aDivisor
	
	^ aDivisor divideOne: self.! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:06:51'!
// aDivisor 
	
	^Entero with: 1 // aDivisor integerValue! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:56:01'!
= aNumber

	^aNumber integerValue = 1! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:43:29'!
addFraction: aFraction

	^aFraction addInteger: self! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:06:40'!
addInteger: anInteger

	^Entero with: 1 + anInteger integerValue! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:58:49'!
addOne: aOne

	^Entero with: 2! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:44:07'!
checkDenominator
	
	 self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:44:56'!
divideFraction: aFraction

	^aFraction! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:45:10'!
divideInteger: anInteger

	^anInteger! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:05:35'!
divideOne: aOne

	^self! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:05:45'!
greatestCommonDivisorWith: anEntero 
	
	^self! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:46:20'!
hash

	^1 hash! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:42:41'!
integerValue
	
	^ 1! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:46:55'!
isEqualToFraction: aFraction

	^ aFraction numerator = aFraction denominator.! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:47:30'!
isEqualToInteger: anInteger

	^ anInteger integerValue = 1! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:02:10'!
isOne

	^true! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:02:15'!
isZero
	
	^false! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:49:14'!
multiplyFraction: aFraction

	^aFraction! !

!One methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:49:26'!
multiplyInteger: anInteger

	^anInteger! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Numero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:05:06'!
* aMultiplicator

	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:51:11'!
+ anAdder

	^anAdder! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:05:00'!
/ aDivisor
	
	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:05:09'!
// aDivisor 
	
	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:56:32'!
= anObject

	^anObject integerValue = 0! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:53:17'!
addFraction: aFraction

	^aFraction! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:53:30'!
addInteger: anInteger

	^anInteger! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:43:11'!
checkDenominator

	self error: 'una fraccion no puede tener denominador cero'! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:43:00'!
checkNumerator

	self error: 'una fraccion no puede ser cero'! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:31:46'!
divideFraction: aFraction

	self error: Numero canNotDivideByZeroErrorDescription! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:31:53'!
divideInteger: anInteger

	self error: Numero canNotDivideByZeroErrorDescription! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:31:57'!
divideOne: aOne

	self error: Numero canNotDivideByZeroErrorDescription! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:54:55'!
greatestCommonDivisorWith: anEntero 
	
	^anEntero! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:55:04'!
hash

	^0 hash! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:55:12'!
integerValue

	^0! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:55:26'!
isEqualToFraction: aFraction

	^false! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:55:36'!
isEqualToInteger: anInteger

	^false! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:56:46'!
isOne

	^false! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 00:56:51'!
isZero
	
	^true! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:04:42'!
multiplyFraction: aFraction

	^self! !

!Zero methodsFor: 'as yet unclassified' stamp: 'rb 9/13/2017 01:04:39'!
multiplyInteger: anInteger

	^self! !
