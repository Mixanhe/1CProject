﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	// регистр ЗаработнаяПлата
	Движения.ЗаработнаяПлата.Записывать = Истина;
	Движение = Движения.ЗаработнаяПлата.Добавить();
	Движение.Сторно = Ложь;
	Движение.ВидРасчета = ПланыВидовРасчета.НачисленияСотрудникам.Невыход;
	Движение.ПериодДействияНачало = ДатаНачала;
	Движение.ПериодДействияКонец = КонецДня(ДатаОкончания);
	Движение.ПериодРегистрации = Дата;
	Движение.Сотрудник = ФИО;
	
КонецПроцедуры
