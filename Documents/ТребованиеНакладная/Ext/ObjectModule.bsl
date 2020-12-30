﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	Если СкладОтправитель = СкладПолучатель Тогда
		Сообщить("Проведение документа невозможно, склад отправитель не может совпадать со складом получателя.");
		Отказ = Истина;
		Возврат;
	КонецЕсли;	
	
	Движения.ОстаткиМатериалов.Записывать = Истина;
	Движения.ОстаткиМатериалов.Записывать = Истина;
	 	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТребованиеНакладнаяНоменклатура.Наименование КАК Наименование,
		|	СУММА(ТребованиеНакладнаяНоменклатура.Количество) КАК Количество
		|ИЗ
		|	Документ.ТребованиеНакладная.Номенклатура КАК ТребованиеНакладнаяНоменклатура
		|ГДЕ
		|	ТребованиеНакладнаяНоменклатура.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	ТребованиеНакладнаяНоменклатура.Наименование";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		// регистр ОстаткиМатериалов Расход
		Движение = Движения.ОстаткиМатериалов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Номенклатура = ВыборкаДетальныеЗаписи.Наименование;
		Движение.Склад = СкладОтправитель;
		Движение.Количество = ВыборкаДетальныеЗаписи.Количество;
		
		// регистр ОстаткиМатериалов Приход
		Движение = Движения.ОстаткиМатериалов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Номенклатура = ВыборкаДетальныеЗаписи.Наименование;
		Движение.Склад = СкладПолучатель;
		Движение.Количество = ВыборкаДетальныеЗаписи.Количество;
		
	КонецЦикла;
	
	Движения.Записать();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОстаткиМатериаловОстатки.Номенклатура КАК Номенклатура,
	|	ОстаткиМатериаловОстатки.Склад КАК Склад,
	|	ЕСТЬNULL(-ОстаткиМатериаловОстатки.КоличествоОстаток, 0) КАК КоличествоОстаток,
	|	ОстаткиМатериаловОстатки.Номенклатура.Представление КАК НоменклатураПредставление,
	|	ОстаткиМатериаловОстатки.Склад.Представление КАК СкладПредставление
	|ИЗ
	|	РегистрНакопления.ОстаткиМатериалов.Остатки КАК ОстаткиМатериаловОстатки
	|ГДЕ
	|	ОстаткиМатериаловОстатки.Склад = &Склад
	|	И ОстаткиМатериаловОстатки.КоличествоОстаток < 0";
	
	Запрос.УстановитьПараметр("Склад", СкладОтправитель);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	// ДАЕМ ЗВЕЗДЮЛЕЙ Юзеру за то, что двигает несуществующие материалы
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Отказ = Истина;
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Сообщить("Передача невозможна, не хватает позиций по номенклатуре " + ВыборкаДетальныеЗаписи.НоменклатураПредставление + " на складе " + ВыборкаДетальныеЗаписи.СкладПредставление + " в количестве " + ВыборкаДетальныеЗаписи.КоличествоОстаток);
		КонецЦикла;
			
	КонецЕсли;
	
КонецПроцедуры
