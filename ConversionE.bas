B4i=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=4.01
@EndOfDesignText@
#IgnoreWarnings:19,2,12,2

Private Sub Class_Globals
	Private strAnd As String
	Private units() As String
	Private dahgan() As String
	Private sadghan() As String
	Private steps() As String
	Private curr_lang As String
	Private ad, bc As String
End Sub

Public Sub Initialize
	curr_lang	=	"fa"
End Sub

Public Sub setLanguage(Language As String)
	
	curr_lang	=	Language
	
	units = Array As String("zero", "One", "two", "three", "four", "fiv", "six", "seven", "eight", "nine","ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventh", "eighteen", "nineteen")
	dahgan = Array As String("", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")
	sadghan = Array As String("", "a hundred", "two hundred", "three hundred", "four hundred", "five hundred", "six hundred", "seven hundred", "eight hundred", "nine hundred")
	steps = Array As String("thousand", "million", "billion", "trillion", "cadillion", "quinteelion","sexstyle", "spriteleon", "ecotourion", "noniLion", "decillion")
	strAnd = " and "
	
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
		words = "Moments ago"
		
	Else if seconds < 90 Then
		words = "A minute ago"
		
	Else if (minutes < 45) Then
		words = Round(minutes) & " minute ago"
		
	Else if minutes < 90 Then
		words = "An hour ago"
		
	Else if hours < 24 Then
		words = Round(hours) & " hour ago"
		
	Else if hours < 42 Then
		words = "A day ago"
		
	Else if days < 30 Then
		words = Round(days) & " day ago"
		
	Else if days < 45 Then
		words = "One month ago"
		
	Else if days < 365 Then
		words = Round(days / 30) & " month ago"
		
	Else if years < 1.5 Then
		words = "A year ago"
		
	Else
		words = Round(years) & " year ago"
		
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

Sub ConvertMillisecondsToString(t As Long,DaySeprator As String,HourSeprator As String,MinuteSeprator As String,SecondSeprator As String) As String
	
	Try
		
		Dim DayS,HourS, MinuteS, SecondS As Int
		DayS = t / DateTime.TicksPerDay
		HourS = t / DateTime.TicksPerHour
		MinuteS = (t Mod DateTime.TicksPerHour) / DateTime.TicksPerMinute
		SecondS = (t Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
		
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
	Dim Calendar2 As Amir_Calendar
	Calendar2.Initialize
	Calendar2.From=Calendar2.CIPersian
	Calendar2.To=Calendar2.CIGregorian
	Calendar2.Format("yyyy/MM/dd","")
	Dim r() As String
	r = Regex.Split("/",Calendar2.Build(jY & "/" & jM & "/" & jD))
	If ResultAsArray Then
		Return Array As Object(r(0),r(1),r(2))
	Else
		Return r(0) & Seprator & r(1) & Seprator & r(2)
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
	
	t7	= 	IIF(jM < 7 ,t5 * 31,t6 + 186)
	
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
	b	=	Array As Int(0,31,IIF((gy Mod 4==0 And gy Mod 100 <> 0) Or (gy Mod 400==0),29,28),31,30,31,30,31,31,30,31,30,31)
	
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
		Dim manam As ManamPersianDate
		Dim output As String
		output	=	manam.GregorianToPersian(Year,Month,Day)
		Dim ResSpliter() As String = Regex.Split("/",output)
		
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
	Dim ResSpliter() As String = Regex.Split("/",output)
		
	If ResultAsArray Then
		Return Array As Object(ResSpliter(0),ResSpliter(1),ResSpliter(2))
	Else
		Return ResSpliter(0) & Seprator & ResSpliter(1) & Seprator & ResSpliter(2)
	End If
	#else
	Dim Calendar2 As Amir_Calendar
	Calendar2.Initialize
	Calendar2.From=Calendar2.CIGregorian
	Calendar2.To=Calendar2.CIPersian
	Calendar2.Format("yyyy/MM/dd","")
	Dim r() As Long
	r = Calendar2.Build2(DateYear,DateMonth,DateDay)
	
	If ResultAsArray Then
		Return Array As Object(r(0),r(1),r(2))
	Else
		Return r(0) & Seprator & r(1) & Seprator & r(2)
	End If
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