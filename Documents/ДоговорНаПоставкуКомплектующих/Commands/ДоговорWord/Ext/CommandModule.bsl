﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПечатьНаСервере(ПараметрКоманды);
	
КонецПроцедуры

&НаСервере
Процедура ПечатьНаСервере(СсылкаНаДокумент)
	
	Макет = Документы.РеализацияТоваровИУслуг.ПолучитьМакет("ДоговорWord");
	
КонецПроцедуры 
