﻿Функция  ОпределитьКоличествоСотрудников() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Сотрудники.Представление КАК Представление
	|ИЗ
	|	Справочник.Сотрудники КАК Сотрудники
	|ГДЕ
	|	Сотрудники.ЭтоГруппа = ЛОЖЬ";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	КоличествоСотрудников = 0;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		КоличествоСотрудников = КоличествоСотрудников + 1;
	КонецЦикла;
	
	Возврат КоличествоСотрудников;	
	
КонецФункции

Процедура ЗаполнитьСписокСотрудниковНаСервере (ТабличнаяЧасть,СсылкаНаФорму) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НачисленияСотрудников.Сотрудник КАК ФИО,
	|	НачисленияСотрудников.Сумма КАК Сумма
	|ИЗ
	|	РегистрСведений.НачисленияСотрудников КАК НачисленияСотрудников";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		Для Каждого ТекущаяСтрока ИЗ ТабличнаяЧасть Цикл
			Если ТекущаяСтрока.ФИО = ВыборкаДетальныеЗаписи.ФИО Тогда
				Флаг = Истина;
				Прервать;
			КонецЕсли;	
		КонецЦикла;
		
		Если НЕ Флаг = Истина Тогда
			НоваяСтрока = ТабличнаяЧасть.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока,ВыборкаДетальныеЗаписи);
			СсылкаНаФорму.ОбновитьОтображениеДанных ();
		КонецЕсли;
		
	КонецЦикла;   
	
КонецПроцедуры

Функция ПроверкаКоллизийТабличнойЧасти (ТабличнаяЧасть) Экспорт
	
	ПроверяемаяТабличнаяЧасть = ТабличнаяЧасть;
	
	// если перем. равна одному, то это нормально
	// так как обьект находит сам себя.
	КоличествоКоллизий = 0;
	Для Каждого СтрокаПроверяемой ИЗ ПроверяемаяТабличнаяЧасть Цикл
		КоличествоКоллизий = 0;
		Для Каждого СтрокаТабличнойЧасти ИЗ ТабличнаяЧасть Цикл
			
			Если СтрокаТабличнойЧасти.ФИО = СтрокаПроверяемой.ФИО Тогда		
				КоличествоКоллизий = КоличествоКоллизий + 1;
			КонецЕсли;
			
			Если КоличествоКоллизий > 1 Тогда
				// тогда можно просто завершить цикл, но в теории можно доработать программу
				// и она будет выводить наименования, и позицию совпадающих элементов.
				Возврат Истина;
			КонецЕсли;
			
		КонецЦикла;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции


