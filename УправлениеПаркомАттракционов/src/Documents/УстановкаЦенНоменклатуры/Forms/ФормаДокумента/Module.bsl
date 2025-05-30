
#Область ОбработчикиКомандФормы

&НаКлиенте
Асинх Процедура Загрузить(Команда)
	
	ТекстВопроса = НСтр("ru = 'В таблице уже введены цены. При загрузке из файла таблица будет очищена. Продолжить?'");
	
	Ответ = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыДиалога = Новый ПараметрыДиалогаПомещенияФайлов;
	ПараметрыДиалога.Фильтр = НСтр("ru = 'Файл Excel|*.xlsx'");
	
	РезультатПомещения = Ждать ПоместитьФайлНаСерверАсинх(,,, ПараметрыДиалога);
	
	Если РезультатПомещения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если РезультатПомещения.ПомещениеФайлаОтменено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АдресФайла", РезультатПомещения.Адрес);
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("Документ.УстановкаЦенНоменклатуры.Форма.ФормаЗагрузкиИзФайла", ПараметрыФормы,,,,, Оповещение);	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗагрузитьЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗагрузитьЦеныИзВременногоХранилища(Результат);
		
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьЦеныИзВременногоХранилища(Адрес)	
	Объект.ЦеныНоменклатуры.Загрузить(ПолучитьИзВременногоХранилища(Адрес));	
КонецПроцедуры

#КонецОбласти