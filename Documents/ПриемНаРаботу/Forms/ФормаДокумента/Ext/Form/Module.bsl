﻿
&НаСервере
Процедура ДобавитьСотрудникаВБазуНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСотрудникаВБазу(Команда)
	
	ФормаВвода = ПолучитьФорму("Справочник.Сотрудники.Форма.ФормаЭлемента");
	ФормаВвода.Открыть();
	
	ДобавитьСотрудникаВБазуНаСервере();
	
КонецПроцедуры
