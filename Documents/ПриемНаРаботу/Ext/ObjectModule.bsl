﻿
Процедура ОбработкаПроведения(Отказ, Режим)                                                      

	// регистр НачисленияСотрудников
	Движения.НачисленияСотрудников.Записывать = Истина;
	Движение = Движения.НачисленияСотрудников.Добавить();
	Движение.Сотрудник = ФИО;
	Движение.Оклад = Оклад;
	Движение.Премия = Премия;

КонецПроцедуры
