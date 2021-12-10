B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.3
@EndOfDesignText@
#if b4i
#DesignerProperty: Key: fontname, DisplayName: FontName, FieldType: String, Description: Font name exist in dir asset ,DefaultValue:
#DesignerProperty: Key: headerfontcolor, DisplayName: HeaderTextColor, FieldType: Color, Description: Set color for header textcolor,DefaultValue: #FFFFFFFF
#DesignerProperty: Key: headerbgcolor, DisplayName: HeaderBackColor, FieldType: Color, Description: Set color for header background color,DefaultValue: #FF555555
#DesignerProperty: Key: headerfontsize, DisplayName: HeaderTextSize, FieldType: Int, Description: Set font size for header text,DefaultValue: 14
#DesignerProperty: Key: itemfontcolor, DisplayName: DaysTextColor, FieldType: Color, Description: Set color for days textcolor,DefaultValue: #FF000000
#DesignerProperty: Key: itembgcolor, DisplayName: DaysBackColor, FieldType: Color, Description: Set color for days background color,DefaultValue: #FFF8F8F8
#DesignerProperty: Key: itemgridcolor, DisplayName: DaysGridColor, FieldType: Color, Description: Set grid color for days,DefaultValue: #FFFFFFFF
#DesignerProperty: Key: itemgridcorner, DisplayName: DaysGridCorner, FieldType: Int, Description: Add corner for day item,DefaultValue: 1
#DesignerProperty: Key: itemfontsize, DisplayName: DaysTextSize, FieldType: Int, Description: Set font size for days text,DefaultValue: 14
#DesignerProperty: Key: selectedday, DisplayName: SelectedDayBackColor, FieldType: Color, Description: Set background color for selected day with user,DefaultValue: #FFB7B7B7
#DesignerProperty: Key: selecteddaytextcolor, DisplayName: SelectedDayTextColor, FieldType: Color, Description: Set text color for selected day with user,DefaultValue: #FF2C2C2C
#DesignerProperty: Key: selecteddayisbold, DisplayName: SelectedDayBold, FieldType: Boolean, Description: Bold the selected day with user,DefaultValue: True
#DesignerProperty: Key: fridaycolor, DisplayName: Friday TextColor, FieldType: Color, change all friday textcolor,DefaultValue: #FFB71A1A
#DesignerProperty: Key: short_days, DisplayName: ShowShortDayName, FieldType: Boolean, Description: Show S instead of sunday,DefaultValue: True
#Event: SelectedDate(Value As Date)

'Custom View class 
Private Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As WeakRef
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private Days(7) As String : Days = Array As String("شنبه","یکشنبه","دوشنبه","سه شنبه","چهارشنبه","پنج شنبه","جمعه")
	Private DayLabels(41) As Label
	Private Properties As Map
	Private CurrentMonth,CurrentYear,CurrentDay As String
	Private Base As Panel
	Private lblpreview As Label
	Private Page1 As Page
	Private dialog As CustomLayoutDialog
	Private pPicker As Panel
	Private picker2 As Picker
	Type Date(Year As Int,Month As Int,Day As Int)
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	
	mEventName = EventName
	mCallBack = Callback
	Page1.Initialize("")
	
End Sub

Private Sub AddYearPickerView
	
	pPicker.Initialize("")
	pPicker.SetLayoutAnimated(1,1,0,0,300dip,200dip)

	picker2.Initialize("picker")

	Dim years As List
	years.Initialize

	Dim j As Int
	Dim current_index_year As Int
	
	For i = 1350 To 1500
		
		j =	j + 1
		years.Add(i)
		
		If i = CurrentYear Then
			current_index_year	=	j-1
		End If
		
	Next
	
	picker2.SetItems(0,years)
	picker2.SelectRow(0,current_index_year,True)
	pPicker.AddView(picker2,0,0,pPicker.Width,pPicker.Height)
	
End Sub

Public Sub DesignerCreateView (sBase As Panel, lbl As Label, Props As Map)
	
	mBase.Value = sBase
	Base = sBase
	Properties	=	Props
	
	Dim Date(),StartDay As String
	Dim CurrDate As Long

	CurrDate		=	DateUtils.SetDate(DateTime.GetYear(DateTime.Now),DateTime.GetMonth(DateTime.Now),DateTime.GetDayOfMonth(DateTime.Now))
	Date			=	Julian2Persian(DateTime.GetYear(CurrDate),DateTime.GetMonth(CurrDate),DateTime.GetDayOfMonth(CurrDate))
	
	StartDay		=	GetStartDayOfWeek(Date(0),Date(1))
	
	CurrentDay		=	Date(2)
	CurrentMonth	=	Date(1)
	CurrentYear		=	Date(0)
	
	ShowDays(StartDay,Date(1),Date(2))
	
	AddYearPickerView
	
End Sub

'Set day to 0 for dont show day in calendar
'Please send shamsi date
Public Sub SetDate(Year As Int,Month As Int,Day As Int)
	
	CurrentDay		=	Day
	CurrentMonth	=	Month
	CurrentYear		=	Year
	
	Dim StartDay As String
	StartDay		=	GetStartDayOfWeek(Year,Month)
	
	ShowDays(StartDay,Month,Day)
	
End Sub

Private Sub GetStartDayOfWeek(Year As Int,Month As Int) As Int
	
	If Month < 7 Then
		Return ((3 * Month) + 1 + GetFirstCurrentYear(Year)) Mod 7
	Else
		Return ((2 * Month) + 1 + GetFirstCurrentYear(Year)) Mod 7
	End If
	
End Sub

Private Sub SelectDay(lb As Label,First As Boolean)
	
	If First = False Then
		For i = 0 To DayLabels.Length - 1
				
			Dim lbl As Label
			lbl	=	DayLabels(i)
			
			If lbl.IsInitialized Then
				
				lbl.TextColor		=	Properties.Get("itemfontcolor")
				lbl.Color			=	Properties.Get("itembgcolor")
				
				If Properties.Get("fontname") <> "" Then
					lbl.Font			=	Font.CreateNew2(Properties.Get("fontname"),Properties.Get("itemfontsize"))
				Else
					lbl.Font			=	Font.CreateNew(Properties.Get("itemfontsize"))
				End If
				
				If lbl.Tag = 0 Then
					lbl.TextColor		=	Properties.Get("fridaycolor")
				End If
				
			End If
			
		Next
		
	End If
	
	lb.Color		=	Properties.Get("selectedday")
	lb.TextColor	=	Properties.Get("selecteddaytextcolor")
				
	If Properties.Get("selecteddayisbold") = True Then
		lb.Font			=	Font.CreateNewBold(Properties.Get("itemfontsize"))
	End If

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
End Sub

#IgnoreWarnings: 12
Private Sub GetBase As Panel
	Return mBase.Value
End Sub

Private Sub Julian2Persian(Year As Int,Month As Int,Day As Int) As String()

	#if b4i
	Dim Calendar2 As Amir_Calendar
	Calendar2.Initialize
	Calendar2.From=Calendar2.CIGregorian
	Calendar2.To=Calendar2.CIPersian
	Calendar2.Format("yyyy/MM/dd","")
	Dim r() As Long
	r = Calendar2.Build2(Year,Month,Day)
	Return Array As String(r(0),r(1),r(2))
	#end if
	
End Sub

Private Sub GetMonthEndDay(sMonth As String) As Int
	
	If sMonth	> 6 Then
		Return 30
	Else
		Return 31
	End If
	
End Sub

Private Sub lblday_Click
	
	Dim lb As Label
	lb	=	Sender
	
	CurrentDay	=	lb.Text
	
	SelectDay(lb,False)
	
	If SubExists(mCallBack,mEventName & "_selecteddate",1) Then
		Dim date2 As Date
		date2.Initialize
		date2.Year	=	CurrentYear
		date2.Month	=	CurrentMonth
		date2.Day	=	lb.Text
		CallSubDelayed2(mCallBack,mEventName & "_selecteddate",date2)
	End If
	
End Sub

Private Sub ShowDays(StartDay As Int,TodayMonth As Int,TodayDay As Int)
	
	Dim width,Left,Top As Int
	width	=	Base.Width / Days.Length
	
	Base.RemoveAllViews
	
	Top	=	0
	
	lblpreview.Initialize("lblpreview")
	lblpreview.TextColor	=	0xFF3C3C3C
	lblpreview.Font			=	Font.CreateNew(14)
	lblpreview.TextAlignment	=	lblpreview.ALIGNMENT_CENTER
	Base.AddView(lblpreview,0,0,Base.Width,50dip)
	
	Dim lblprev As Label
	lblprev.Initialize("lblprev")
	lblprev.Text		=	Chr(0xE5CB)
	lblprev.TextColor	=	0xFF3C3C3C
	lblprev.Font		=	Font.CreateMaterialIcons(20)
	lblprev.TextAlignment	=	lblprev.ALIGNMENT_CENTER
	Base.AddView(lblprev,0,0,Base.Width/4,50dip)
	
	Dim lblnext As Label
	lblnext.Initialize("lblnext")
	lblnext.Text		=	Chr(0xE5CC)
	lblnext.TextColor	=	0xFF3C3C3C
	lblnext.Font		=	Font.CreateMaterialIcons(20)
	lblnext.TextAlignment	=	lblnext.ALIGNMENT_CENTER
	Base.AddView(lblnext,Base.Width - (Base.Width/4),0,Base.Width/4,50dip)
	
	Top	=	Top	+	50dip
	
	#region Add Header
	For i = 6 To 0 Step -1
		
		Dim lb As Label
		lb.Initialize("")
		lb.TextColor		=	Properties.Get("headerfontcolor")
		lb.Font				=	Font.CreateNew(12)
		
		If Properties.Get("short_days") = True Then
			lb.Text				=	Days(i).SubString2(0,1)
		Else
			lb.Text				=	Days(i)
		End If
		
		lb.Color			=	Properties.Get("headerbgcolor")
		
		If Properties.Get("fontname") <> "" Then
			lb.Font			=	Font.CreateNew2(Properties.Get("fontname"),Properties.Get("headerfontsize"))
		Else
			lb.Font			=	Font.CreateNew(Properties.Get("headerfontsize"))
		End If
	
		lb.TextAlignment	=	lb.ALIGNMENT_CENTER
		Base.AddView(lb,Left,Top,width,width)
		
		Left	=	Left	+	width
		
	Next
	#end region
	
	Top		=	Top + width + 5dip
	
	#region Add Divider
	Dim lb As Label
	lb.Initialize("")
	lb.Color	=	0xFFF1F1F1
	Base.AddView(lb,0,Top,Base.Width,1dip)
	#end region
	
	Top 	=	Top + 1dip
	
	Dim height,tempLeft As Int
	height	=	Base.Height / 8.5
	
	Left	=	Left - width
	tempLeft	=	Left
	Left	=	Left	- (width * StartDay)
	
	For i = 1 To 31
			
		If i > GetMonthEndDay(TodayMonth) Then Continue
		
		Dim lb As Label
		lb.Initialize("lblday")
		lb.TextColor		=	Properties.Get("itemfontcolor")
		lb.Color			=	Properties.Get("itembgcolor")
		lb.SetBorder(1,Properties.Get("itemgridcolor"),Properties.Get("itemgridcorner"))
		
		If Properties.Get("fontname") <> "" Then
			lb.Font			=	Font.CreateNew2(Properties.Get("fontname"),Properties.Get("itemfontsize"))
		Else
			lb.Font			=	Font.CreateNew(Properties.Get("itemfontsize"))
		End If
		
		lb.Text				=	i
		lb.TextAlignment	=	lb.ALIGNMENT_CENTER
		Base.AddView(lb,Left,Top,width,height)
		
		Left	=	Left	-	width
		
		If i	=	TodayDay Then
			
			SelectDay(lb,True)
			
		End If
		
		Dim friday_n As Int
		friday_n	=	i	+	StartDay
		
		If friday_n Mod 7 = 0 Then
			lb.TextColor	=	Properties.Get("fridaycolor")
			lb.Tag			=	0
			Left	=	tempLeft
			Top		=	Top	+	height
		End If
		
		DayLabels(i-1)	=	lb
		
	Next
	
	lblpreview.Text	=	GetMonthName(TodayMonth) & " " & CurrentYear
	
End Sub

Private Sub GetFirstCurrentYear(Year As Int) As Int
	
	Dim x As Int=Year-1396
	Dim y As Int=6+x
  
	Do While (y>6)
		y=y-7
	Loop
	Return y

End Sub

Public Sub GetCurrentMonth As Int
	Return CurrentMonth
End Sub

Public Sub GetCurrentyear As Int
	Return CurrentYear
End Sub

Public Sub GetCurrentDay As Int
	Return CurrentDay
End Sub

#IgnoreWarnings: 2
Public Sub GetMonthName(Month As Int) As String
	
	Select Month
		Case 1
			Return "فروردین"
		Case 2
			Return "ادریبهشت"
		Case 3
			Return "خرداد"
		Case 4
			Return "تیر"
		Case 5
			Return "مرداد"
		Case 6
			Return "شهریور"
		Case 7
			Return "مهر"
		Case 8
			Return "آبان"
		Case 9
			Return "آذر"
		Case 10
			Return "دی"
		Case 11
			Return "بهمن"
		Case 12
			Return "اسفند"
	End Select
	
End Sub

Public Sub getDate As Date
	
	Dim date2 As Date
	date2.Initialize
	date2.Year	=	CurrentYear
	date2.Month	=	CurrentMonth
	date2.Day	=	CurrentDay
	
	Return date2
	
End Sub

Private Sub lblprev_Click
	
	If CurrentMonth - 1 = 0 Then
		CurrentMonth	=	13
		CurrentYear	=	CurrentYear	- 1	
	End If
	
	CurrentMonth	=	CurrentMonth - 1
	
	SetDate(CurrentYear,CurrentMonth,CurrentDay)
	
End Sub

Private Sub lblnext_Click
	
	If CurrentMonth + 1 = 13 Then
		CurrentMonth	=	0
		CurrentYear	=	CurrentYear	+ 1	
	End If
	
	CurrentMonth	=	CurrentMonth + 1
	
	SetDate(CurrentYear,CurrentMonth,CurrentDay)
	
End Sub

Private Sub lblpreview_Click
	
	dialog.Initialize(pPicker)
	Wait For (dialog.ShowAsync("انتخاب سال","تایید","بیخیال","",False)) Dialog_Result(Result As Int)
		If Result = dialog.RESULT_POSITIVE Then
			SetDate(picker2.GetSelectedItem(0),CurrentMonth,CurrentDay)
		End If
	
End Sub
#end if