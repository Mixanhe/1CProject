﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные;
	РаботаСДокументами.РассчетСуммы(СтрокаТабличнойЧасти);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные;
	РаботаСДокументами.РассчетСуммы(СтрокаТабличнойЧасти);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСуммаПриИзменении(Элемент)
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные;
	РаботаСДокументами.РассчетСуммы(СтрокаТабличнойЧасти);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные;
	
	СтрокаТабличнойЧасти.Цена = РаботаСоСправочниками.ОтпускнаяЦена(Объект.Дата,СтрокаТабличнойЧасти.Номенклатура);
	
	РаботаСДокументами.РассчетСуммы(СтрокаТабличнойЧасти);
	
КонецПроцедуры
