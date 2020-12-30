
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПечатьНаСервере(ПараметрКоманды);
	
КонецПроцедуры

&НаСервере
Процедура ПечатьНаСервере(СссылкаНаДокумент)
	
	Макет = Документы.ДоговорНаПоставкуКомплектующих.ПолучитьМакет("ПростойWord");
	Word = Макет.Получить();
	
	Word.Application.Visible = Ложь;
	
	Doc = Word.Application.Documents(1);
	Doc.Activate();
	
	Word.Bookmarks("НомерДокумента").Select();
	Word.Application.Selection.TypeText(СссылкаНаДокумент.Номер);
	
	Word.Bookmarks("ДатаДокумента").Select();
	Word.Application.Selection.TypeText(СссылкаНаДокумент.Дата);

	
	
	Word.Application.Visible = Истина;
	
КонецПроцедуры 

