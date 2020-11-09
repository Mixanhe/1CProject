﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	Движения.ОстаткиМатериалов.Записывать = Истина;
	Для Каждого ТекСтрокаТовары Из Товары Цикл
		Движение = Движения.ОстаткиМатериалов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Склад = Склад;
		Движение.Количество = ТекСтрокаТовары.Количество;
	КонецЦикла;
	
	#Область КонтроляОстатков
	Движения.Записать();
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОстаткиМатериаловОстатки.Номенклатура КАК Номенклатура,
	|	ОстаткиМатериаловОстатки.Склад КАК Склад,
	|	-ОстаткиМатериаловОстатки.КоличествоОстаток КАК Количество
	|ИЗ
	|	РегистрНакопления.ОстаткиМатериалов.Остатки(
	|			,
	|			Номенклатура В
	|				(ВЫБРАТЬ
	|					РеализацияТоваровИУслугТовары.Номенклатура КАК Номенклатура
	|				ИЗ
	|					Документ.РеализацияТоваровИУслуг.Товары КАК РеализацияТоваровИУслугТовары
	|				ГДЕ
	|					РеализацияТоваровИУслугТовары.Ссылка = &Ссылка)) КАК ОстаткиМатериаловОстатки
	|ГДЕ
	|	ОстаткиМатериаловОстатки.КоличествоОстаток < 0";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Отказ = Истина;
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			
			Сообщить("Не хватает позиций товара " + ВыборкаДетальныеЗаписи.Номенклатура + " в количестве " + ВыборкаДетальныеЗаписи.Количество + " на складе "  + ВыборкаДетальныеЗаписи.Склад);
			
		КонецЦикла;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область РасчетСебестоимость
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Движения.СебестоимостьНоменклатуры.Записывать = Истина;
	Движения.Продажи.Записывать = Истина;
	
	Запрос2 = Новый Запрос;
	Запрос2.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РеализацияТоваровИУслугТовары.Номенклатура КАК Номенклатура,
	|	СУММА(РеализацияТоваровИУслугТовары.Количество) КАК Количество,
	|	СУММА(РеализацияТоваровИУслугТовары.Сумма) КАК Сумма
	|ИЗ
	|	Документ.РеализацияТоваровИУслуг.Товары КАК РеализацияТоваровИУслугТовары
	|ГДЕ
	|	РеализацияТоваровИУслугТовары.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	РеализацияТоваровИУслугТовары.Номенклатура";
	
	Запрос2.УстановитьПараметр("Ссылка",Ссылка);
	
	МассивНоменклатуры = Запрос2.Выполнить().Выгрузить();
	
	СебестоимостьДокумента = 0;
	
	Для Каждого ЭлементМассива ИЗ МассивНоменклатуры Цикл	
		
		// теперь задача самая простая (какжеяошибался)(02.11.2020 НАЧАЛ). Записать данные в регистр по товарам.
		// попадалово, теперь нужно обработать такую ситуацию, что вдруг пользователь 
		// захочет ввести данные по разному, допустим в разных строках будет один и тот же товар
		// поэтому движения будут сформированы не совсем корректно, теперь мне предстоит расчитывать все строки
		// для корректной записи движений регистра. Задача состоит в том, чтобы получить количество
		// и номенклатуру, а так же все правильно это записать.
		
		// Регистр накопления СебестоимостьНоменклатуры ПРИХОД
		Движение = Движения.СебестоимостьНоменклатуры.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Номенклатура = ЭлементМассива.Номенклатура;
		Движение.Количество = ЭлементМассива.Количество;
		Движение.Сумма = ЭлементМассива.Сумма / ЭлементМассива.Количество;
		
		// Регистр накопления Продажи Обороты
		Движение = Движения.Продажи.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ЭлементМассива.Номенклатура;
		Движение.Количество = ЭлементМассива.Количество;
		Движение.Сумма = ЭлементМассива.Сумма;
		Движение.Себестоимость = ЭлементМассива.Сумма / ЭлементМассива.Количество;
		
		СебестоимостьДокумента = СебестоимостьДокумента + (ЭлементМассива.Сумма / ЭлементМассива.Количество);
		
	КонецЦикла;
	
	#КонецОбласти
	
	#Область ЗаписиВРегистрБухгалтерии
	// регистр Бухгалтерии Расчетный
	Движения.Расчетный.Записывать = Истина;
	
	// 1  проводка 
	Проводка = Движения.Расчетный.Добавить();
	Проводка.Период = Дата;
	Проводка.СчетДт = ПланыСчетов.Основной.РасчетыСПокупателямиИЗаказчиками;
	Проводка.СчетКт = ПланыСчетов.Основной.Товары;
	Проводка.Сумма =  Товары.Итог("Сумма");
	
	// 2 проводка
	Проводка = Движения.Расчетный.Добавить();
	Проводка.Период = Дата;
	Проводка.СчетДт = ПланыСчетов.Основной.Продажи;
	Проводка.СчетКт = ПланыСчетов.Основной.Товары;
	Проводка.Сумма = СебестоимостьДокумента;
	
	
	#КонецОбласти
	
	
КонецПроцедуры
