B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.01
@EndOfDesignText@
#IgnoreWarnings:19,2,12,2
'Needed libraries : ManamPersianDate

Private Sub Class_Globals
	Private strAnd As String
	Private units() As String
	Private dahgan() As String
	Private sadghan() As String
	Private steps() As String
	Private curr_lang As String
	Private ad, bc As String
	Private lbltoday_time As Label
End Sub

Public Sub Initialize
	curr_lang	=	"fa"
End Sub

Public Sub setLanguage(Language As String)
	
	curr_lang	=	Language
	
	If curr_lang = "en" Then
		units = Array As String("zero", "One", "two", "three", "four", "fiv", "six", "seven", "eight", "nine","ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventh", "eighteen", "nineteen")
		dahgan = Array As String("", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")
		sadghan = Array As String("", "a hundred", "two hundred", "three hundred", "four hundred", "five hundred", "six hundred", "seven hundred", "eight hundred", "nine hundred")
		steps = Array As String("thousand", "million", "billion", "trillion", "cadillion", "quinteelion","sexstyle", "spriteleon", "ecotourion", "noniLion", "decillion")
		strAnd = " and "
	
	Else If curr_lang = "tr" Then
		units = Array As String("sıfır", "bir", "İki", "üç", "dört", "beş", "altı", "yedi", "sekiz", "dokuz","on", "on bir", "oniki", "on üç", "on dört", "onbeş", "on altı", "on yedi", "onsekiz", "on dokuz")
		dahgan = Array As String("", "", "yirmi", "otuz", "kırk", "elli", "altmış", "yetmiş", "seksen", "doksan")
		sadghan = Array As String("", "Yüz", "İki yüz", "Üç yüz", "Dört yüz", "Beş yüz", "Altı yüz", "Yedi yüz", "Sekiz yüz", "Dokuz yüz")
		steps = Array As String("bin", "milyon", "milyar", "trilyon", "cadillion", "quinteelion","sexstyle", "spriteleon", "ecotourion", "noniLion", "decillion")
		strAnd = " ve "
	
	Else If curr_lang = "ar" Then
		units = Array As String("صفر", "واحد", "اثنان", "ثلاثة", "أربعة", "خمسة", "ستة", "سبعة", "ثمانية", "ليس","عشرة", "أحد عشر", "اثنا عشر", "ثلاثة عشر", "أربعة عشر", "خمسة عشر", "ست عشرة", "سبعة عشر", "ثمانية عشر", "تسعة عشر")
		dahgan = Array As String("", "", "عشرون", "ثلاثون", "أربعون", "خمسون", "ستون", "سبعون", "ثمانون", "تسعون")
		sadghan = Array As String("", "مائة", "مائتان", "ثلاثمائة", "اربع مئة", "خمسمائة", "ستمائة", "سبعمائة", "ثمانمائة", "تسعمائة")
		steps = Array As String("ألف", "مليون", "مليار", "تريليون", "كادليون", "خماسية","sexstyle", "spriteleon", "ecotourion", "noniLion", "decillion")
		strAnd = " ve "
		
	Else
		units = Array As String("صفر", "یک", "دو", "سه", "چهار", "پنج", "شش", "هفت", "هشت", "نه","ده", "یازده", "دوازده", "سیزده", "چهارده", "پانزده", "شانزده", "هفده", "هجده", "نوزده")
		dahgan = Array As String("", "", "بیست", "سی", "چهل", "پنجاه", "شصت", "هفتاد", "هشتاد", "نود")
		sadghan = Array As String("", "یکصد", "دویست", "سیصد", "چهارصد", "پانصد", "ششصد", "هفتصد", "هشتصد", "نهصد")
		steps = Array As String("هزار", "میلیون", "میلیارد", "تریلیون", "کادریلیون", "کوینتریلیون","سکستریلیون", "سپتریلیون", "اکتریلیون", "نونیلیون", "دسیلیون")
		strAnd = " و "
		
	End If
	
End Sub

'Get elapse time from now
'Example : a minute ago
Public Sub GetTimeAgo(Time As Object) As String
	
	If IsNumber(Time) = False Then
	
		Dim p(),sDate(),sTime() As String
		p = Regex.Split(" ",Time)
		
		Dim s As String
		s = Time
		If s.IndexOf("-") > -1 Then
			sDate = Regex.Split("-",p(0))
			sTime = Regex.Split(":",p(1))
		Else if s.IndexOf("/") > -1 Then
			sDate = Regex.Split("/",p(0))
			sTime = Regex.Split(":",p(1))
		Else if s.IndexOf("\") > -1 Then
			sDate = Regex.Split("\",p(0))
			sTime = Regex.Split(":",p(1))
		End If
		
		Time = SetDateAndTime(sDate(0),sDate(1),sDate(2),sTime(0),sTime(1),sTime(2))
		
	End If
	
	Dim diff As Long
	diff = DateTime.Now - Time

	Dim seconds,minutes,days,years,hours As Double
	seconds = Abs(diff) / 1000
	minutes = seconds / 60
	hours = minutes / 60
	days = hours / 24
	years = days / 365

	Dim words As String

	If seconds < 45 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = "لحظاتی قبل"
		Else
			words = "Moments ago"
		End If
		
	Else if seconds < 90 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = "یک دقیقه قبل"
		Else
			words = "A minute ago"
		End If
		
	Else if (minutes < 45) Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = Round(minutes) & " دقیقه قبل"
		Else
			words = Round(minutes) & " minute ago"
		End If
		
	Else if minutes < 90 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = "یک ساعت قبل"
		Else
			words = "An hour ago"
		End If
		
	Else if hours < 24 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = Round(hours) & " ساعت قبل"
		Else
			words = Round(hours) & " hour ago"
		End If
		
	Else if hours < 42 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = "یک روز قبل"
		Else
			words = "A day ago"
		End If
		
	Else if days < 30 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = Round(days) & " روز قبل"
		Else
			words = Round(days) & " day ago"
		End If
		
	Else if days < 45 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = "یک ماه قبل"
		Else
			words = "One month ago"
		End If
		
	Else if days < 365 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = Round(days / 30) & " ماه قبل"
		Else
			words = Round(days / 30) & " month ago"
		End If
		
	Else if years < 1.5 Then
		If curr_lang = "" Or curr_lang = "fa" Then
			words = "یک سال قبل"
		Else
			words = "A year ago"
		End If
		
	Else
		If curr_lang = "" Or curr_lang = "fa" Then
			words = Round(years) & " سال قبل"
		Else
			words = Round(years) & " year ago"
		End If
		
	End If

	If curr_lang = "fa" Or curr_lang = "" Then
		words	=	TranslateNumber(words,True)
	End If
	
	Return words

End Sub

Sub ConvertByteToUnit(Bytes As Long) As String
	
	Dim unit() As String
	unit	=	Array As String("B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB")
	
	Dim pow As Long
	
	If Bytes > 0 Then
		pow	=	Floor(Logarithm(Bytes,1024))
	Else
		pow	=	0
	End If
	
	Return Round(Bytes / Power(1024, pow)) & " " & unit(pow)
	
End Sub

Public Sub ShortenNumber(Value As Float) As String
	
	Dim unitprefix As String
  
	If Value >= 1000000.0 Then

		Value = Value / 1000000.0
		unitprefix ="M"

	Else If Value >= 1000.0 Then
        
		Value = Value / 1000.0
		unitprefix = "k"
  
	End If
  
	Return NumberFormat( Value ,1,2) & unitprefix
	
End Sub

Public Sub FormatPrice(Price As Double) As String
	Return NumberFormat(Price,0,0)
End Sub

Public Sub FormatPrice2(Price As Double,ToPersianNumber As Boolean) As String
	
	Dim res As String
	res	=	NumberFormat(Price,0,0)

	If ToPersianNumber Then
		res	=	TranslateNumber(res,True)
	End If

	Return res
	
End Sub

Public Sub Number2Word(Number As String) As String

	Dim i As Int
	i = Number

	If i < 20 Then Return units(Number)

	If i < 100 Then
		If i Mod 10 > 0 Then
			Return dahgan(i / 10) & strAnd & Number2Word(i Mod 10)
		Else
			Return dahgan(i / 10)
		End If
	End If
	
	If i < 1000 Then

		If (i Mod 100 > 0) Then
			Return sadghan(i / 100) & strAnd & Number2Word(i Mod 100)
		Else
			Return sadghan(i / 100)
		End If
	
	End If
	
	If i < 1000000 Then
		If  i Mod 1000 > 0 Then
			Return Number2Word(i / 1000) & stepsString(steps(0)) & strAnd & Number2Word(i Mod 1000)
		Else
			Return Number2Word(i / 1000) & stepsString(steps(0))
		End If
	
	End If
	
	If i < 1000000000 Then

		If i Mod 1000000 > 0 Then
			Return Number2Word(i / 1000000) & stepsString(steps(1)) & strAnd & Number2Word(i Mod 1000000)
		Else
			Return Number2Word(i / 1000000) & stepsString(steps(1))
		End If
	
	End If
	
	If i Mod 1000000000 > 0 Then
		Return Number2Word(i / 1000000000) & stepsString(steps(2)) & strAnd & Number2Word(i Mod 1000000000)
	Else
		Return Number2Word(i / 1000000000) & stepsString(steps(2))
	End If
	
End Sub

Public Sub GetMonthSymbolTitle(Month As Int) As String
	
	Select Month
		Case 1
			Return "قوچ"
		Case 2
			Return "گاو نر"
		Case 3
			Return "دوقولوها"
		Case 4
			Return "خرچنگ"
		Case 5
			Return "شیر"
		Case 6
			Return "فرشته"
		Case 7
			Return "ترازو"
		Case 8
			Return "عقرب"
		Case 9
			Return "اسب"
		Case 10
			Return "بز"
		Case 11
			Return "مرد و دلو"
		Case 12
			Return "ماهی"
	End Select
	
End Sub

'for persian numbers,set ToPersian to true and for english set to false
Public Sub TranslateNumber(Numbers As String,ToPersian As Boolean) As String
	
	Dim res As String
	
	If ToPersian Then
		res	= Numbers.Replace( "0" , "۰" ).Replace( "1" , "۱" ).Replace( "2" , "۲" ).Replace( "3" , "۳" ).Replace( "4" , "۴" ).Replace( "5" , "۵" ).Replace( "6" , "۶" ).Replace( "7" , "۷" ).Replace( "8" , "۸" ).Replace( "9" , "۹" )
	Else
		res	= Numbers.Replace( "۰","0" ).Replace( "۱","1" ).Replace( "۲" , "2" ).Replace( "۳" ,"3" ).Replace( "۴" , "4" ).Replace( "۵" , "5").Replace( "۶" , "6" ).Replace( "۷" , "7" ).Replace( "۸" , "8" ).Replace("۹" , "9")
		res	= res.Replace( "٠","0" ).Replace( "١","1" ).Replace( "٢" , "2" ).Replace( "٣" ,"3" ).Replace( "٤" , "4" ).Replace("٥","5").Replace( "۵" , "5").Replace( "٦" , "6" ).Replace( "٧" , "7" ).Replace( "٨" , "8" ).Replace("٩" , "9")
	End If
	
	Return res
	
End Sub

'example 12 بهمن 1397
Public Sub GetReadableDate(Date As String,WithoutDay As Boolean) As String
 
	Dim res(),month2,perDate() As String
	
	Dim pp() As String
	
	pp = Regex.Split(" ",Date)
	
	Try
		
		If pp(0).IndexOf("-") > -1 Then
			res = Regex.Split("-",pp(0))
		Else
			res = Regex.Split("/",pp(0))
		End If
		
		month2 = res(1)
		
		perDate = Regex.Split("/",GregorianToPersian(res(0),month2,res(2),"/",False))
		
		month2	=	GetPersianMonthName(perDate(1))
		
		If WithoutDay = False Then
			Return TranslateNumber(perDate(2) & " " & month2 & " " & perDate(0),True)
		Else
			Return month2 & " " & perDate(0)
		End If
		
	Catch
		Return Date
	End Try
	
End Sub

'date argument should be yyyy-mm-dd (you can change - character)
Public Sub ParseDate(Date As String,Separator As String) As Int()
	
	Dim temp() As String
	temp	=	Regex.Split(Separator,Date)
	
	Return	Array As Int(temp(0),temp(1),temp(2))
	
End Sub

'time argument should be hh:mm:ss (you can change - character)
Public Sub ParseTime(Time As String) As Int()
	
	Dim temp() As String
	temp	=	Regex.Split(":",Time)
	
	If temp.Length = 3 Then
		Return	Array As Int(temp(0),temp(1),temp(2))
	Else
		Return	Array As Int(temp(0),temp(1))
	End If
	
End Sub

Public Sub GetCountryCallingCodeFromIso(IsoCode As String) As String
	
	Dim country2phone As Map
	country2phone.Initialize
	country2phone.put("AF", "93")
	country2phone.put("AL", "355")
	country2phone.put("DZ", "213")
	country2phone.put("AD", "376")
	country2phone.put("AO", "244")
	country2phone.put("AG", "1268")
	country2phone.put("AR", "54")
	country2phone.put("AM", "374")
	country2phone.put("AU", "61")
	country2phone.put("AT", "43")
	country2phone.put("AZ", "994")
	country2phone.put("BS", "1242")
	country2phone.put("BH", "973")
	country2phone.put("BD", "880")
	country2phone.put("BB", "1246")
	country2phone.put("BY", "375")
	country2phone.put("BE", "32")
	country2phone.put("BZ", "501")
	country2phone.put("BJ", "229")
	country2phone.put("BT", "975")
	country2phone.put("BO", "591")
	country2phone.put("BA", "387")
	country2phone.put("BW", "267")
	country2phone.put("BR", "55")
	country2phone.put("BN", "673")
	country2phone.put("BG", "359")
	country2phone.put("BF", "226")
	country2phone.put("BI", "257")
	country2phone.put("KH", "855")
	country2phone.put("CM", "237")
	country2phone.put("CA", "1")
	country2phone.put("CV", "238")
	country2phone.put("CF", "236")
	country2phone.put("TD", "235")
	country2phone.put("CL", "56")
	country2phone.put("CN", "86")
	country2phone.put("CO", "57")
	country2phone.put("KM", "269")
	country2phone.put("CD", "243")
	country2phone.put("CG", "242")
	country2phone.put("CR", "506")
	country2phone.put("CI", "225")
	country2phone.put("HR", "385")
	country2phone.put("CU", "53")
	country2phone.put("CY", "357")
	country2phone.put("CZ", "420")
	country2phone.put("DK", "45")
	country2phone.put("DJ", "253")
	country2phone.put("DM", "1767")
	country2phone.put("DO", "1")
	country2phone.put("EC", "593")
	country2phone.put("EG", "20")
	country2phone.put("SV", "503")
	country2phone.put("GQ", "240")
	country2phone.put("ER", "291")
	country2phone.put("EE", "372")
	country2phone.put("ET", "251")
	country2phone.put("FJ", "679")
	country2phone.put("FI", "358")
	country2phone.put("FR", "33")
	country2phone.put("GA", "241")
	country2phone.put("GM", "220")
	country2phone.put("GE", "995")
	country2phone.put("DE", "49")
	country2phone.put("GH", "233")
	country2phone.put("GR", "30")
	country2phone.put("GD", "1473")
	country2phone.put("GT", "502")
	country2phone.put("GN", "224")
	country2phone.put("GW", "245")
	country2phone.put("GY", "592")
	country2phone.put("HT", "509")
	country2phone.put("HN", "504")
	country2phone.put("HU", "36")
	country2phone.put("IS", "354")
	country2phone.put("IN", "91")
	country2phone.put("ID", "62")
	country2phone.put("IR", "98")
	country2phone.put("IQ", "964")
	country2phone.put("IE", "353")
	country2phone.put("IL", "972")
	country2phone.put("IT", "39")
	country2phone.put("JM", "1876")
	country2phone.put("JP", "81")
	country2phone.put("JO", "962")
	country2phone.put("KZ", "7")
	country2phone.put("KE", "254")
	country2phone.put("KI", "686")
	country2phone.put("KP", "850")
	country2phone.put("KR", "82")
	country2phone.put("KW", "965")
	country2phone.put("KG", "996")
	country2phone.put("LA", "856")
	country2phone.put("LV", "371")
	country2phone.put("LB", "961")
	country2phone.put("LS", "266")
	country2phone.put("LR", "231")
	country2phone.put("LY", "218")
	country2phone.put("LI", "423")
	country2phone.put("LT", "370")
	country2phone.put("LU", "352")
	country2phone.put("MK", "389")
	country2phone.put("MG", "261")
	country2phone.put("MW", "265")
	country2phone.put("MY", "60")
	country2phone.put("MV", "960")
	country2phone.put("ML", "223")
	country2phone.put("MT", "356")
	country2phone.put("MH", "692")
	country2phone.put("MR", "222")
	country2phone.put("MU", "230")
	country2phone.put("MX", "52")
	country2phone.put("FM", "691")
	country2phone.put("MD", "373")
	country2phone.put("MC", "377")
	country2phone.put("MN", "976")
	country2phone.put("ME", "382")
	country2phone.put("MA", "212")
	country2phone.put("MZ", "258")
	country2phone.put("MM", "95")
	country2phone.put("NA", "264")
	country2phone.put("NR", "674")
	country2phone.put("NP", "977")
	country2phone.put("NL", "31")
	country2phone.put("NZ", "64")
	country2phone.put("NI", "505")
	country2phone.put("NE", "227")
	country2phone.put("NG", "234")
	country2phone.put("NO", "47")
	country2phone.put("OM", "968")
	country2phone.put("PK", "92")
	country2phone.put("PW", "680")
	country2phone.put("PA", "507")
	country2phone.put("PG", "675")
	country2phone.put("PY", "595")
	country2phone.put("PE", "51")
	country2phone.put("PH", "63")
	country2phone.put("PL", "48")
	country2phone.put("PT", "351")
	country2phone.put("QA", "974")
	country2phone.put("RO", "40")
	country2phone.put("RU", "7")
	country2phone.put("RW", "250")
	country2phone.put("KN", "1869")
	country2phone.put("LC", "1758")
	country2phone.put("VC", "1784")
	country2phone.put("WS", "685")
	country2phone.put("SM", "378")
	country2phone.put("ST", "239")
	country2phone.put("SA", "966")
	country2phone.put("SN", "221")
	country2phone.put("RS", "381")
	country2phone.put("SC", "248")
	country2phone.put("SL", "232")
	country2phone.put("SG", "65")
	country2phone.put("SK", "421")
	country2phone.put("SI", "386")
	country2phone.put("SB", "677")
	country2phone.put("SO", "252")
	country2phone.put("ZA", "27")
	country2phone.put("ES", "34")
	country2phone.put("LK", "94")
	country2phone.put("SD", "249")
	country2phone.put("SR", "597")
	country2phone.put("SZ", "268")
	country2phone.put("SE", "46")
	country2phone.put("CH", "41")
	country2phone.put("SY", "963")
	country2phone.put("TJ", "992")
	country2phone.put("TZ", "255")
	country2phone.put("TH", "66")
	country2phone.put("TL", "670")
	country2phone.put("TG", "228")
	country2phone.put("TO", "676")
	country2phone.put("TT", "1868")
	country2phone.put("TN", "216")
	country2phone.put("TR", "90")
	country2phone.put("TM", "993")
	country2phone.put("TV", "688")
	country2phone.put("UG", "256")
	country2phone.put("UA", "380")
	country2phone.put("AE", "971")
	country2phone.put("GB", "44")
	country2phone.put("US", "1")
	country2phone.put("UY", "598")
	country2phone.put("UZ", "998")
	country2phone.put("VU", "678")
	country2phone.put("VA", "379")
	country2phone.put("VE", "58")
	country2phone.put("VN", "84")
	country2phone.put("YE", "967")
	country2phone.put("ZM", "260")
	country2phone.put("ZW", "263")
	country2phone.put("GE", "995")
	country2phone.put("TW", "886")
	country2phone.put("AZ", "37497")
	country2phone.put("CY", "90392")
	country2phone.put("MD", "373533")
	country2phone.put("SO", "252")
	country2phone.put("GE", "995")
	country2phone.put("CX", "61")
	country2phone.put("CC", "61")
	country2phone.put("NF", "672")
	country2phone.put("NC", "687")
	country2phone.put("PF", "689")
	country2phone.put("YT", "262")
	country2phone.put("GP", "590")
	country2phone.put("GP", "590")
	country2phone.put("PM", "508")
	country2phone.put("WF", "681")
	country2phone.put("CK", "682")
	country2phone.put("NU", "683")
	country2phone.put("TK", "690")
	country2phone.put("GG", "44")
	country2phone.put("IM", "44")
	country2phone.put("JE", "44")
	country2phone.put("AI", "1264")
	country2phone.put("BM", "1441")
	country2phone.put("IO", "246")
	country2phone.put("", "357")
	country2phone.put("VG", "1284")
	country2phone.put("KY", "1345")
	country2phone.put("FK", "500")
	country2phone.put("GI", "350")
	country2phone.put("MS", "1664")
	country2phone.put("SH", "290")
	country2phone.put("TC", "1649")
	country2phone.put("MP", "1670")
	country2phone.put("PR", "1")
	country2phone.put("AS", "1684")
	country2phone.put("GU", "1671")
	country2phone.put("VI", "1340")
	country2phone.put("HK", "852")
	country2phone.put("MO", "853")
	country2phone.put("FO", "298")
	country2phone.put("GL", "299")
	country2phone.put("GF", "594")
	country2phone.put("GP", "590")
	country2phone.put("MQ", "596")
	country2phone.put("RE", "262")
	country2phone.put("AX", "35818")
	country2phone.put("AW", "297")
	country2phone.put("AN", "599")
	country2phone.put("SJ", "47")
	country2phone.put("AC", "247")
	country2phone.put("TA", "290")
	country2phone.put("CS", "381")
	country2phone.put("PS", "970")
	country2phone.put("EH", "212")
	
	If country2phone.ContainsKey(IsoCode.ToUpperCase) Then
		Return country2phone.Get(IsoCode.ToUpperCase)
	Else
		Return ""
	End If
	
End Sub

Public Sub GetWeeknameNumber(Name As String) As Int
	
	Select Name.ToLowerCase
		
		Case "saturday"
			Return 0
		
		Case "sunday"
			Return 1
			
		Case "monday"
			Return 2
			
		Case "tuesday"
			Return 3
			
		Case "wednesday"
			Return 4
			
		Case "thursday"
			Return 5
			
		Case "friday"
			Return 6
			
	End Select
	
End Sub

#Region Get Month Names
Public Sub GetPersianMonthName(sMonth As Int) As String
	
	Dim month2 As String
	
	Select Case sMonth
		Case 1
			month2 = "فروردین"
		Case 2
			month2 = "اردیبهشت"
		Case 3
			month2 = "خرداد"
		Case 4
			month2 = "تیر"
		Case 5
			month2 = "مرداد"
		Case 6
			month2 = "شهریور"
		Case 7
			month2 = "مهر"
		Case 8
			month2 = "آبان"
		Case 9
			month2 = "آذر"
		Case 10
			month2 = "دی"
		Case 11
			month2 = "بهمن"
		Case 12
			month2 = "اسفند"
	End Select
	
	Return month2
	
End Sub

Public Sub GetIslamicMonthName(sMonth As Int) As String
	
	Dim month2 As String
	
	Select Case sMonth
'		Case 1
'			month2 = "مُحَرَّم"
'		Case 2
'			month2 = "صَفَر"
'		Case 3
'			month2 = "رَبِيع ٱلْأَوَّل"
'		Case 4
'			month2 = "ربيع الثاني"
'		Case 5
'			month2 = "جُمَادَىٰ ٱلْأُولَىٰ"
'		Case 6
'			month2 = "جُمَادَىٰ ٱلْآخِرَة"
'		Case 7
'			month2 = "رَجَب"
'		Case 8
'			month2 = "شَعْبَان"
'		Case 9
'			month2 = "رَمَضَان"
'		Case 10
'			month2 = "شَوَّال"
'		Case 11
'			month2 = "ذُو ٱلْقَعْدَة"
'		Case 12
'			month2 = "ذُو ٱلْحِجَّة"
		Case 1
			month2 = "محرّم"
		Case 2
			month2 = "صفر"
		Case 3
			month2 = "ربیع الاوّل"
		Case 4
			month2 = "ربیع الثانی"
		Case 5
			month2 = "جمادی الاوّلٰ"
		Case 6
			month2 = "جمادی الآخر"
		Case 7
			month2 = "رجب"
		Case 8
			month2 = "شعبان"
		Case 9
			month2 = "رمضان"
		Case 10
			month2 = "شوّال"
		Case 11
			month2 = "ذوالقعده"
		Case 12
			month2 = "ذوالحجه"
	End Select
	
	Return month2
	
End Sub

Public Sub GetGregorianMonthName(sMonth As Int) As String
	
	Dim month2 As String
	
	Select Case sMonth
		Case 1
			month2 = "January"
		Case 2
			month2 = "February"
		Case 3
			month2 = "March"
		Case 4
			month2 = "April"
		Case 5
			month2 = "May"
		Case 6
			month2 = "June"
		Case 7
			month2 = "July"
		Case 8
			month2 = "August"
		Case 9
			month2 = "September"
		Case 10
			month2 = "October"
		Case 11
			month2 = "November"
		Case 12
			month2 = "December"
	End Select
	
	Return month2
	
End Sub

Public Sub GetHijriMonthName(sMonth As Int) As String
	
	Dim month2 As String
	
	Select Case sMonth
		Case 1
			month2 = "محرم"
		Case 2
			month2 = "صفر"
		Case 3
			month2 = "ربیع‌الاول"
		Case 4
			month2 = "ربیع‌الثانی"
		Case 5
			month2 = "جمادی‌الاول"
		Case 6
			month2 = "جمادی‌الثانی"
		Case 7
			month2 = "رجب"
		Case 8
			month2 = "شعبان"
		Case 9
			month2 = "رمضان"
		Case 10
			month2 = "شوال"
		Case 11
			month2 = "ذیقعده"
		Case 12
			month2 = "ذیحجه"
	End Select
	
	Return month2
	
End Sub
#End Region

'get time from datetime value
Public Sub GetTime(sDateTime As String) As String

	If sDateTime.Length = 0 Or sDateTime = "null" Then Return sDateTime
	
	sDateTime	=	sDateTime.Replace("-","/")
	
	Dim p(),sDate(),sTime() As String
	p = Regex.Split(" ",sDateTime)
	sDate = Regex.Split("/",p(0))
	sTime = Regex.Split(":",p(1))
	
	Dim ln As Long
	ln = SetDateAndTime(sDate(0),sDate(1),sDate(2),sTime(0),sTime(1),sTime(2))
	
	Dim pm As String
	If DateTime.GetHour(ln) > 11 Then
		pm = " PM"
	Else
		pm = " AM"
	End If
	
	Dim rs As String
	rs = DateTime.GetHour(ln) & ":" & DateTime.GetMinute(ln)& ":" & DateTime.GetSecond(ln) & pm
	
	If curr_lang = "fa" Then
		Return TranslateNumber(rs,True)
	Else
		Return rs
	End If
	
End Sub

Public Sub TruncateLabelContent(Text As String,Length As Int) As String
	If Text.Length > Length Then
		Return Text.SubString2(0,Length) & "..."
	Else
		Return Text
	End If
End Sub

Public Sub EnglishNumberToPersian(Str As String) As String
	Return TranslateNumber(Str,True)
End Sub

Public Sub GetWeekName(WeekDay As Int) As String
	
	If curr_lang = "fa" Then
		
		Select WeekDay
			Case 1
				Return "یکشنبه"
			Case 2
				Return "دوشنبه"
			Case 3
				Return "سه شنبه"
			Case 4
				Return "چهار شنبه"
			Case 5
				Return "پنج شنبه"
			Case 6
				Return "جمعه"
			Case 7
				Return "شنبه"
		End Select
	
	Else
		Select WeekDay
			Case 1
				Return "Sunday"
			Case 2
				Return "Monday"
			Case 3
				Return "Tuesday"
			Case 4
				Return "Wednesday"
			Case 5
				Return "Thursday"
			Case 6
				Return "Friday"
			Case 7
				Return "Saturday"
		End Select
		
	End If
	
End Sub

'Converts ticks value to unix time.
Public Sub TicksToUnixTime(Ticks As Long) As Long
	Return Ticks / DateTime.TicksPerSecond
End Sub

'Converts unix time to ticks value.
Public Sub UnixTimeToTicks(UnixTime As Long) As Long
	Return UnixTime * DateTime.TicksPerSecond
End Sub

Public Sub GetDateTimeFromTick(Tick As Long) As String
	DateTime.DateFormat	=	"yyyy/MM/dd"
	DateTime.TimeFormat	=	"HH:mm:ss"
	Return DateTime.Date(Tick) & " " & DateTime.Time(Tick)
End Sub

Sub ConvertToTimeFormat(ms As Int) As String
	Dim seconds, minutes As Int
	seconds = Round(ms / 1000)
	minutes = Floor(seconds / 60)
	seconds = seconds Mod 60
	Return NumberFormat(minutes, 1, 0) & ":" & NumberFormat(seconds, 2, 0) 'ex: 3:05
End Sub

Sub ConvertMillisecondsToString(t As Long,DaySeprator As String,HourSeprator As String,MinuteSeprator As String,SecondSeprator As String) As String
	
	Try
		
		Dim DayS,HourS, MinuteS, SecondS As Int
		DayS = Floor(t/DateTime.TicksPerDay)
		HourS =  t/DateTime.TicksPerHour
		HourS = Floor(HourS Mod 24)
		MinuteS = t/DateTime.TicksPerMinute
		MinuteS = Floor(MinuteS Mod 60)
		SecondS = t/DateTime.TicksPerSecond
		SecondS = Floor(SecondS Mod 60)
		
		Dim sDay As String
		If DayS > 0 Then
			sDay = $"$1.0{DayS}${DaySeprator}"$
		End If
		
		Dim sHour As String
		If HourS > 0 Then
			sHour = $"$1.0{HourS}${HourSeprator}"$
		End If
		
		Dim sMinute As String
		If MinuteS > 0 Then
			sMinute = $"$2.0{MinuteS}${MinuteSeprator}"$
		End If
		
		Dim sSecond As String
		If SecondS > 0 Then
			sSecond = $"$2.0{SecondS}${SecondSeprator}"$
		End If
		
		Dim res As String
		res = $"${sDay}${sHour}${sMinute}${sSecond}"$
		
		If res.EndsWith(":") Then
			res = res.SubString2(0,res.Length-1)
		End If
		
		Return res
		
	Catch
		Return ""
	End Try
	
End Sub

#Region Convert date to persian,greigorian,islamic
'if you set Trye to ResultAsArray,result is array of int (year,month,day)
Public Sub PersianToGregorian(jY As Object, jM As Object, jD As Object,Seprator As String,ResultAsArray As Boolean) As Object
 	
	#if b4i
	Dim NativeMe As NativeObject = Me
	Dim mRes As Object = NativeMe.RunMethod("PersianToGregorian:",Array(ToString(jY,jM,jD)))
	Dim res() As Long = Spliter(mRes)
	
	If ResultAsArray Then
		Return Array As Object(res(0),res(1),res(2))
	Else
		Return res(0) & Seprator & res(1) & Seprator & res(2)
	End If
	#else
	
	Dim gy,gm,gd As Int
	
	If	jY	>	979 Then
		gy		=	1600
		jY		=	jY - 979
	Else
		gy	=	621
	End If
 	
	Dim days As Int
	Dim t,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12 As Int
	
	t	= 	(365 * jY)

	t2	= 	jY / 33
	
	#if b4i
	t3	=	Bit.FMod(jY,33)
	#else
	t3	=	jY Mod 33
	#end if
	
	t4	= 	jM-7
	
	t5	= 	jM-1
	
	t6	= 	t4 * 30
	
	t7	= 	IIf(jM < 7 ,t5 * 31,t6 + 186)
	
	t8	= 	t3 + 3
	
	days = t +	(t2 * 8) +(t8 / 4) + 78 + jD + t7
	
	t9		= days / 146097
	gy		= gy + 400 * t9
	
	days 	= days Mod 146097
	
	If(days > 36524) Then
		t10 = days / 36524
		gy = gy + 100 * t10
		days = days + 1
		days = days Mod 36524
		If days >= 365 Then days = days + 1
	End If
 
	t11 	= days / 1461
	gy		= gy + 4 * t11
	days 	= days Mod 1461
	
	If days > 365 Then
		Dim temp As Int
		temp	= days - 1
		t12		= temp / 365
		gy		= gy + t12
		days	= (days-1) Mod 365
	End If
	
	gd	=	days + 1
	
	Dim b() As Int
	b	=	Array As Int(0,31,IIf((gy Mod 4==0 And gy Mod 100 <> 0) Or (gy Mod 400==0),29,28),31,30,31,30,31,31,30,31,30,31)
	
	For i = 0 To b.Length - 1
		
		gm = i
		
		Dim v As Int
		v = b(i)
		
		If gd <= v Then Exit
		
		gd = gd - v
		
	Next
 
	If ResultAsArray Then
		Return Array As Object(gy,gm,gd)
	Else
		Return gy & Seprator & gm & Seprator & gd
	End If
	#End If
	
End Sub

Public Sub PersianToToHijriIslamic(Year As Int,Month As Int,Day As Int,Seprator As String,ResultAsArray As Boolean) As Object
	
	Dim date() As Object
	date	=	PersianToGregorian(Year,Month,Day,"",True)
	
	Return GregorianToHijriIslamic(date(0),date(1),date(2),Seprator,ResultAsArray)
	
End Sub

Public Sub GregorianToHijriIslamic(Year As Int,Month As Int,Day As Int,Seprator As String,ResultAsArray As Boolean) As Object
	
	#if b4a
		#if date
		Dim m As ManamPerianDateUltimate
		Dim output As String = m.GregorianToIslamicDate(Year,Month,Day)
	
		Dim ResSpliter() As String = Regex.Split("/",output)
		ResSpliter(0) = TranslateNumber(ResSpliter(0),False)
		ResSpliter(1) = TranslateNumber(ResSpliter(1),False)
		ResSpliter(2) = TranslateNumber(ResSpliter(2),False)
		
		If ResultAsArray Then
			Return Array As Object(ResSpliter(0),ResSpliter(1),ResSpliter(2))
		Else
			Return ResSpliter(0) & Seprator & ResSpliter(1) & Seprator & ResSpliter(2)
		End If
		#end if
	#End If
	
	#if b4i
	#if debug
	If ResultAsArray Then
		Return Array As Long(1440,1,1)
	Else
		Return "1440/1/1"
	End If
	#End If
	Dim NativeMe As NativeObject = Me
	Dim mResult As Object = NativeMe.RunMethod("getIslamicDate:::", Array(Year,Month,Day))
	Dim Result As String = mResult
	Dim ResSpliter() As String = Regex.Split("/",Result)
	
	If ResultAsArray Then
		Return Array As Long(ResSpliter(0),ResSpliter(1),ResSpliter(2))
	Else
		Return ResSpliter(0) & Seprator & ResSpliter(1) & Seprator & ResSpliter(2)
	End If
	#end if
	
End Sub

'date format have to be yyyy/mm/dd
Public Sub GregorianToPersian2(Date As String,Seprator As String,ResultAsArray As Boolean) As Object
	
	Date = TranslateNumber(Date,False)
	Date	=	Date.Replace("-","/")
	
	Dim res() As String
	res	=	Regex.Split(" ",Date)
	
	If Date.IndexOf("-") > -1 Then
		res =	Regex.Split("-",res(0))
	Else
		res =	Regex.Split("/",res(0))
	End If

	Return GregorianToPersian(res(0),res(1),res(2),Seprator,ResultAsArray)
	
End Sub

'If you set 0 to Year,Month and Day,it return current persian date
'if you set Trye to ResultAsArray,result is array of int (year,month,day)
Public Sub GregorianToPersian(DateYear As Int,DateMonth As Int,DateDay As Int,Seprator As String,ResultAsArray As Boolean) As Object

	#if b4a
	Dim manam As ManamPersianDate
	Dim output As String
	output	=	manam.GregorianToPersian(DateYear,DateMonth,DateDay)
	output = TranslateNumber(output,False)
	Dim ResSpliter() As String = Regex.Split("/",output)
		
	If ResultAsArray Then
		Return Array As Object(ResSpliter(0),ResSpliter(1),ResSpliter(2))
	Else
		Return ResSpliter(0) & Seprator & ResSpliter(1) & Seprator & ResSpliter(2)
	End If
	#else
	
	Dim Calendar3 As Amir_Calendar
	Calendar3.Initialize
	Calendar3.From	=	Calendar3.CIGregorian
	Calendar3.To	=	Calendar3.CIPersian
	Calendar3.Format("yyyy/MM/dd","yyyy/MM/dd")
	Try
		Dim mRes As Object = Calendar3.Build(DateYear & "/" & DateMonth & "/" & DateDay)
		Dim r() As Long = Spliter(mRes)
		
		If ResultAsArray Then
			Return Array As Object(r(0),r(1),r(2))
		Else
			Return r(0) & Seprator & r(1) & Seprator & r(2)
		End If
	Catch
	
	End Try
	#end if
	
End Sub

Public Sub HijriToGregorian(Year As Int,Month As Int,Day As Int,Seprator As String,ResultAsArray As Boolean) As Object
	
End Sub

Public Sub HijriToPersian(Year As Int,Month As Int,Day As Int,Seprator As String,ResultAsArray As Boolean) As Object
	
End Sub
#End Region

#Region Private Functions
#if b4i
#if release
#If OBJC
- (NSString *) getIslamicDate : (long) year: (long) month: (long) day {

// Create a Gregorian Calendar
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

// Set up components of a Gregorian date
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];

gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;

// Create the date
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];

// Then create an Islamic calendar
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];

// And grab those date components for the same date
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];

   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
    return dates;
}
#End If
#end if
#end if

Private Sub stepsString(step2 As String) As String
	Return " " & step2 & " "
End Sub
#End Region

Public Sub SetDateAndTime(Years As Int, Months As Int, Days As Int, Hours As Int, Minutes As Int, Seconds As Int) As Long
	Dim df = DateTime.DateFormat, tf = DateTime.TimeFormat As String
	DateTime.DateFormat = "GGyyyyMMdd"
	DateTime.TimeFormat = "HHmmss"
	Dim d As String = Format(Abs(Years), 4) & Format(Months, 2) & Format(Days, 2)
	d = GetEra(Years < 0) & d
	Dim t As String = Format(Hours, 2) & Format(Minutes, 2) & Format(Seconds, 2)
	Try
		Dim ticks As Long = DateTime.DateTimeParse(d, t)
	Catch
		DateTime.DateFormat = df
		DateTime.TimeFormat = tf
		Log("Error: Invalid value: " & d & " " & t)
		Return "invalid date" + 1 'hack to throw an error
	End Try
	DateTime.DateFormat = df
	DateTime.TimeFormat = tf
	Return ticks
End Sub

Private Sub Format(Value As Int, Length As Int) As String
	Return NumberFormat2(Value, Length, 0, 0, False)
End Sub

Private Sub GetEra(Negative As Boolean) As String
	Dim df As String = DateTime.DateFormat
	If Negative Then
		If bc <> "" Then Return bc
		DateTime.DateFormat = "GG"
		bc = DateTime.Date(-137628808000000)
		DateTime.DateFormat = df
		Return bc
	Else
		If ad <> "" Then Return ad
		DateTime.DateFormat = "GG"
		ad = DateTime.Date(0)
		DateTime.DateFormat = df
		Return ad
	End If
End Sub

Public Sub RemoveArabicCharacter(Text As String) As String
	
	Text	=	Text.Replace("ك","ک")
	Text	=	Text.Replace("ي","ی")

	Return Text
	
End Sub

Sub Bitmap2Base64(Bitmap As Bitmap) As String
	
	Dim su As StringUtils
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	Bitmap.WriteToStream(out, 100, "JPEG")
	Return su.EncodeBase64(out.ToBytesArray)
	
End Sub

#if b4i
'Public Sub GregorianToIslamic (Year As Long,Month As Long,Day As Long) As Long()
'	Dim NativeMe As NativeObject = Me
'	Dim mResult As Object = NativeMe.RunMethod("GregorianToIslamicDate:::", Array(Year,Month,Day))
'	Return Spliter(mResult)
'End Sub

'Public Sub IslamicToGregorian (Year As Long,Month As Long,Day As Long) As Long()
'	Dim NativeMe As NativeObject = Me
'	Dim mResult As Object = NativeMe.RunMethod("IslamicToGregorian:::", Array(Year,Month,Day))
'	Return Spliter(mResult)
'End Sub

'Public Sub IslamicToPersian (Year As Long,Month As Long,Day As Long) As Long()
'	Dim NativeMe As NativeObject = Me
'	Dim mResult As Object = NativeMe.RunMethod("IslamicToPersian:::", Array(Year,Month,Day))
'	Return Spliter(mResult)
'End Sub

Private Sub ToString2(Results() As Long) As String
	Return ToString(Results(0),Results(1),Results(2))
End Sub

Private Sub ToString(Year As Long,Month As Long,Day As Long) As String
	Return Year&"/"&Month&"/"&Day
End Sub

Private Sub Spliter (Result As String) As Long()
	Dim ResSpliter() As String = Regex.Split("/",Result)
	Return Array As Long(ResSpliter(0),ResSpliter(1),ResSpliter(2))
End Sub
#End If

#If OBJC
- (NSString *) GregorianToIslamicDate : (long) year: (long) month: (long) day {
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];
   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
	  return dates;
}

- (NSString *) IslamicToGregorian : (long) year: (long) month: (long) day {
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];
   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
	  return dates;
}

- (NSString *) IslamicToPersian : (long) year: (long) month: (long) day {
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];
   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
	  return dates;
}

- (NSString *) PersianToGregorian : (NSString *) Persiandate {
NSDateFormatter *df = [[NSDateFormatter alloc] init];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
df.dateStyle = NSDateFormatterMediumStyle;
df.dateFormat = @"yyyy/MM/dd";
NSString *stringDate =Persiandate;

NSDate *date = [df dateFromString:stringDate];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSString *stringDateConverted = [df stringFromDate:date];
return stringDateConverted;
}

- (NSString *) GregorianToPersian : (NSString *) gdate {
NSDateFormatter *df = [[NSDateFormatter alloc] init];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
df.dateStyle = NSDateFormatterMediumStyle;
df.dateFormat = @"yyyy/MM/dd";
NSString *stringDate =gdate;

NSDate *date = [df dateFromString:stringDate];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
NSString *stringDateConverted = [df stringFromDate:date];
return stringDateConverted;
}
#End If

Sub IdentifyLanguage(text As String) As String
    
	Dim lang = "Unknown"

	Dim code As Int = Asc(text)

	Select True
		Case code >= 0x0000    And code <= 0x007F
			lang = "English /Basic Latin"
		Case code >= 0x0080    And code <= 0x00FF
			lang = "C1 Controls and Latin-1 Supplement"
		Case code >= 0x0100    And code <= 0x017F
			lang = "English / Latin Extended-A"
		Case code >= 0x0180    And code <= 0x024F
			lang = "English / Latin Extended-B"
		Case code >= 0x0250    And code <= 0x02AF
			lang = "IPA Extensions"
		Case code >= 0x02B0    And code <= 0x02FF
			lang = "Spacing Modifier Letters"
		Case code >= 0x0300    And code <= 0x036F
			lang = "Combining Diacritical Marks"
		Case code >= 0x0370    And code <= 0x03FF
			lang = "Greek/Coptic"
		Case code >= 0x0400    And code <= 0x04FF
			lang = "Cyrillic"
		Case code >= 0x0500    And code <= 0x052F
			lang = "Cyrillic Supplement"
		Case code >= 0x0530    And code <= 0x058F
			lang = "Armenian"
		Case code >= 0x0590    And code <= 0x05FF
			lang = "Hebrew"
		Case code >= 0x0600    And code <= 0x06FF
			lang = "Arabic / Urdu / Persian"
		Case code >= 0x0700    And code <= 0x074F
			lang = "Syriac"
		Case code >= 0x0750    And code <= 0x077F
			lang = "Undefined"
		Case code >= 0x0780    And code <= 0x07BF
			lang = "Thaana"
		Case code >= 0x07C0    And code <= 0x08FF
			lang = "Undefined"
		Case code >= 0x0900    And code <= 0x097F
			lang = "Hindi / Devanagari"
		Case code >= 0x0980    And code <= 0x09FF
			lang = "Bengali/Assamese"
		Case code >= 0x0A00    And code <= 0x0A7F
			lang = "Gurmukhi"
		Case code >= 0x0A80    And code <= 0x0AFF
			lang = "Gujarati"
		Case code >= 0x0B00    And code <= 0x0B7F
			lang = "Oriya"
		Case code >= 0x0B80    And code <= 0x0BFF
			lang = "Tamil"
		Case code >= 0x0C00    And code <= 0x0C7F
			lang = "Telugu"
		Case code >= 0x0C80    And code <= 0x0CFF
			lang = "Kannada"
		Case code >= 0x0D00    And code <= 0x0DFF
			lang = "Malayalam"
		Case code >= 0x0D80    And code <= 0x0DFF
			lang = "Sinhala"
		Case code >= 0x0E00    And code <= 0x0E7F
			lang = "Thai"
		Case code >= 0x0E80    And code <= 0x0EFF
			lang = "Lao"
		Case code >= 0x0F00    And code <= 0x0FFF
			lang = "Tibetan"
		Case code >= 0x1000    And code <= 0x109F
			lang = "Myanmar"
		Case code >= 0x10A0    And code <= 0x10FF
			lang = "Georgian"
		Case code >= 0x1100    And code <= 0x11FF
			lang = "Hangul Jamo"
		Case code >= 0x1200    And code <= 0x137F
			lang = "Ethiopic"
		Case code >= 0x1380    And code <= 0x139F
			lang = "Undefined"
		Case code >= 0x13A0    And code <= 0x13FF
			lang = "Cherokee"
		Case code >= 0x1400    And code <= 0x167F
			lang = "Unified Canadian Aboriginal Syllabics"
		Case code >= 0x1680    And code <= 0x169F
			lang = "Ogham"
		Case code >= 0x16A0    And code <= 0x16FF
			lang = "Runic"
		Case code >= 0x1700    And code <= 0x171F
			lang = "Tagalog"
		Case code >= 0x1720    And code <= 0x173F
			lang = "Hanunoo"
		Case code >= 0x1740    And code <= 0x175F
			lang = "Buhid"
		Case code >= 0x1760    And code <= 0x177F
			lang = "Tagbanwa"
		Case code >= 0x1780    And code <= 0x17FF
			lang = "Khmer"
		Case code >= 0x1800    And code <= 0x18AF
			lang = "Mongolian"
		Case code >= 0x18B0    And code <= 0x18FF
			lang = "Undefined"
		Case code >= 0x1900    And code <= 0x194F
			lang = "Limbu"
		Case code >= 0x1950    And code <= 0x197F
			lang = "Tai Le"
		Case code >= 0x1980    And code <= 0x19DF
			lang = "Undefined"
		Case code >= 0x19E0    And code <= 0x19FF
			lang = "Khmer Symbols"
		Case code >= 0x1A00    And code <= 0x1CFF
			lang = "Undefined"
		Case code >= 0x1D00    And code <= 0x1D7F
			lang = "Phonetic Extensions"
		Case code >= 0x1D80    And code <= 0x1DFF
			lang = "Undefined"
		Case code >= 0x1E00    And code <= 0x1EFF
			lang = "English / Latin Extended Additional"
		Case code >= 0x1F00    And code <= 0x1FFF
			lang = "Greek Extended"
		Case code >= 0x2000    And code <= 0x206F
			lang = "General Punctuation"
		Case code >= 0x2070    And code <= 0x209F
			lang = "Superscripts and Subscripts"
		Case code >= 0x20A0    And code <= 0x20CF
			lang = "Currency Symbols"
		Case code >= 0x20D0    And code <= 0x20FF
			lang = "Combining Diacritical Marks for Symbols"
		Case code >= 0x2100    And code <= 0x214F
			lang = "Letterlike Symbols"
		Case code >= 0x2150    And code <= 0x218F
			lang = "Number Forms"
		Case code >= 0x2190    And code <= 0x21FF
			lang = "Arrows"
		Case code >= 0x2200    And code <= 0x22FF
			lang = "Mathematical Operators"
		Case code >= 0x2300    And code <= 0x23FF
			lang = "Miscellaneous Technical"
		Case code >= 0x2400    And code <= 0x243F
			lang = "Control Pictures"
		Case code >= 0x2440    And code <= 0x245F
			lang = "Optical Character Recognition"
		Case code >= 0x2460    And code <= 0x24FF
			lang = "Enclosed Alphanumerics"
		Case code >= 0x2500    And code <= 0x257F
			lang = "Box Drawing"
		Case code >= 0x2580    And code <= 0x259F
			lang = "Block Elements"
		Case code >= 0x25A0    And code <= 0x25FF
			lang = "Geometric Shapes"
		Case code >= 0x2600    And code <= 0x26FF
			lang = "Miscellaneous Symbols"
		Case code >= 0x2700    And code <= 0x27BF
			lang = "Dingbats"
		Case code >= 0x27C0    And code <= 0x27EF
			lang = "Miscellaneous Mathematical Symbols-A"
		Case code >= 0x27F0    And code <= 0x27FF
			lang = "Supplemental Arrows-A"
		Case code >= 0x2800    And code <= 0x28FF
			lang = "Braille Patterns"
		Case code >= 0x2900    And code <= 0x297F
			lang = "Supplemental Arrows-B"
		Case code >= 0x2980    And code <= 0x29FF
			lang = "Miscellaneous Mathematical Symbols-B"
		Case code >= 0x2A00    And code <= 0x2AFF
			lang = "Supplemental Mathematical Operators"
		Case code >= 0x2B00    And code <= 0x2BFF
			lang = "Miscellaneous Symbols and Arrows"
		Case code >= 0x2C00    And code <= 0x2E7F
			lang = "Undefined"
		Case code >= 0x2E80    And code <= 0x2EFF
			lang = "CJK Radicals Supplement"
		Case code >= 0x2F00    And code <= 0x2FDF
			lang = "Kangxi Radicals"
		Case code >= 0x2FE0    And code <= 0x2EEF
			lang = "Undefined"
		Case code >= 0x2FF0    And code <= 0x2FFF
			lang = "Ideographic Description Characters"
		Case code >= 0x3000    And code <= 0x303F
			lang = "CJK Symbols and Punctuation"
		Case code >= 0x3040    And code <= 0x309F
			lang = "Hiragana"
		Case code >= 0x30A0    And code <= 0x30FF
			lang = "Katakana"
		Case code >= 0x3100    And code <= 0x312F
			lang = "Bopomofo"
		Case code >= 0x3130    And code <= 0x318F
			lang = "Hangul Compatibility Jamo"
		Case code >= 0x3190    And code <= 0x319F
			lang = "Kanbun (Kunten)"
		Case code >= 0x31A0    And code <= 0x31BF
			lang = "Bopomofo Extended"
		Case code >= 0x31C0    And code <= 0x31EF
			lang = "Undefined"
		Case code >= 0x31F0    And code <= 0x31FF
			lang = "Katakana Phonetic Extensions"
		Case code >= 0x3200    And code <= 0x32FF
			lang = "Enclosed CJK Letters and Months"
		Case code >= 0x3300    And code <= 0x33FF
			lang = "CJK Compatibility"
		Case code >= 0x3400    And code <= 0x4DBF
			lang = "CJK Unified Ideographs Extension A"
		Case code >= 0x4DC0    And code <= 0x4DFF
			lang = "Yijing Hexagram Symbols"
		Case code >= 0x4E00    And code <= 0x9FAF
			lang = "CJK Unified Ideographs"
		Case code >= 0x9FB0    And code <= 0x9FFF
			lang = "Undefined"
		Case code >= 0xA000    And code <= 0xA48F
			lang = "Yi Syllables"
		Case code >= 0xA490    And code <= 0xA4CF
			lang = "Yi Radicals"
		Case code >= 0xA4D0    And code <= 0xABFF
			lang = "Undefined"
		Case code >= 0xAC00    And code <= 0xD7AF
			lang = "Hangul Syllables"
		Case code >= 0xD7B0    And code <= 0xD7FF
			lang = "Undefined"
		Case code >= 0xD800    And code <= 0xDBFF
			lang = "High Surrogate Area"
		Case code >= 0xDC00    And code <= 0xDFFF
			lang = "Low Surrogate Area"
		Case code >= 0xE000    And code <= 0xF8FF
			lang = "Private Use Area"
		Case code >= 0xF900    And code <= 0xFAFF
			lang = "CJK Compatibility Ideographs"
		Case code >= 0xFB00    And code <= 0xFB4F
			lang = "Alphabetic Presentation Forms"
		Case code >= 0xFB50    And code <= 0xFDFF
			lang = "Arabic Presentation Forms-A"
		Case code >= 0xFE00    And code <= 0xFE0F
			lang = "Variation Selectors"
		Case code >= 0xFE10    And code <= 0xFE1F
			lang = "Undefined"
		Case code >= 0xFE20    And code <= 0xFE2F
			lang = "Combining Half Marks"
		Case code >= 0xFE30    And code <= 0xFE4F
			lang = "CJK Compatibility Forms"
		Case code >= 0xFE50    And code <= 0xFE6F
			lang = "Small Form Variants"
		Case code >= 0xFE70    And code <= 0xFEFF
			lang = "Arabic Presentation Forms-B"
		Case code >= 0xFF00    And code <= 0xFFEF
			lang = "Halfwidth and Fullwidth Forms"
		Case code >= 0xFFF0    And code <= 0xFFFF
			lang = "Specials"
		Case code >= 0x10000    And code <= 0x1007F
			lang = "Linear B Syllabary"
		Case code >= 0x10080    And code <= 0x100FF
			lang = "Linear B Ideograms"
		Case code >= 0x10100    And code <= 0x1013F
			lang = "Aegean Numbers"
		Case code >= 0x10140    And code <= 0x102FF
			lang = "Undefined"
		Case code >= 0x10300    And code <= 0x1032F
			lang = "Old Italic"
		Case code >= 0x10330    And code <= 0x1034F
			lang = "Gothic"
		Case code >= 0x10380    And code <= 0x1039F
			lang = "Ugaritic"
		Case code >= 0x10400    And code <= 0x1044F
			lang = "Deseret"
		Case code >= 0x10450    And code <= 0x1047F
			lang = "Shavian"
		Case code >= 0x10480    And code <= 0x104AF
			lang = "Osmanya"
		Case code >= 0x104B0    And code <= 0x107FF
			lang = "Undefined"
		Case code >= 0x10800    And code <= 0x1083F
			lang = "Cypriot Syllabary"
		Case code >= 0x10840    And code <= 0x1CFFF
			lang = "Undefined"
		Case code >= 0x1D000    And code <= 0x1D0FF
			lang = "Byzantine Musical Symbols"
		Case code >= 0x1D100    And code <= 0x1D1FF
			lang = "Musical Symbols"
		Case code >= 0x1D200    And code <= 0x1D2FF
			lang = "Undefined"
		Case code >= 0x1D300    And code <= 0x1D35F
			lang = "Tai Xuan Jing Symbols"
		Case code >= 0x1D360    And code <= 0x1D3FF
			lang = "Undefined"
		Case code >= 0x1D400    And code <= 0x1D7FF
			lang = "Mathematical Alphanumeric Symbols"
		Case code >= 0x1D800    And code <= 0x1FFFF
			lang = "Undefined"
		Case code >= 0x20000    And code <= 0x2A6DF
			lang = "CJK Unified Ideographs Extension B"
		Case code >= 0x2A6E0    And code <= 0x2F7FF
			lang = "Undefined"
		Case code >= 0x2F800    And code <= 0x2FA1F
			lang = "CJK Compatibility Ideographs Supplement"
		Case code >= 0x2FAB0    And code <= 0xDFFFF
			lang = "Unused"
		Case code >= 0xE0000    And code <= 0xE007F
			lang = "Tags"
		Case code >= 0xE0080    And code <= 0xE00FF
			lang = "Unused"
		Case code >= 0xE0100    And code <= 0xE01EF
			lang = "Variation Selectors Supplement"
		Case code >= 0xE01F0    And code <= 0xEFFFF
			lang = "Unused"
		Case code >= 0xF0000    And code <= 0xFFFFD
			lang = "Supplementary Private Use Area-A"
		Case code >= 0xFFFFE    And code <= 0xFFFFF
			lang = "Unused"
		Case code >= 0x100000    And code <= 0x10FFFD
			lang = "0xSupplementary Private Use Area0x-B"
	End Select

	Return lang
End Sub