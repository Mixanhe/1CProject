﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	// регистр НачисленияСотрудников
	Движения.НачисленияСотрудников.Записывать = Истина;
	Для Каждого ТекСтрокаСотрудники Из Сотрудники Цикл
		
		Движение = Движения.НачисленияСотрудников.Добавить();
		Движение.Сотрудник = ТекСтрокаСотрудники.СсылкаНаСотрудника;
		Движение.Оклад = ТекСтрокаСотрудники.Оклад;
		Движение.Премия = ТекСтрокаСотрудники.Премия;
	КонецЦикла;

КонецПроцедуры
