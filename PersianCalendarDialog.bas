B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.3
@EndOfDesignText@
Private Sub Class_Globals
	Private dialog As CustomLayoutDialog
	Private base As Panel
	Private pr As PersianCalendar
End Sub

#if b4i
Public Sub Initialize(Page1 As Page)
	
End Sub
#else
Public Sub Initialize
	
End Sub
#end if

Private Sub PrepareDialog
	
	base.Initialize("")
	base.SetLayoutAnimated(1,1,0,0,GetDeviceLayoutValues.Width - 50dip,GetDeviceLayoutValues.Width)
	
	Dim lbl As Label
	lbl.Initialize("")
	
	Dim properties As Map
	properties.Initialize
	properties.Put("headerfontcolor",Colors.Black)
	properties.Put("headerbgcolor",Colors.White)
	properties.Put("headerfontsize",14)
	properties.Put("itemfontcolor",0xFF000000)
	properties.Put("itembgcolor",Colors.White)
	properties.Put("itemgridcolor",Colors.White)
	properties.Put("itemgridcorner",1)
	properties.Put("itemfontsize",14)
	properties.Put("selectedday",0xFFB7B7B7)
	properties.Put("selecteddaytextcolor",0xFF2C2C2C)
	properties.Put("selecteddayisbold",True)
	properties.Put("fridaycolor",0xFFB71A1A)
	properties.Put("short_days",True)
	
	#if b4i
	properties.Put("fontname",Font.DEFAULT.Name)
	#else
	properties.Put("fontname",Typeface.DEFAULT)
	#end if
	
	pr.Initialize(Me,"calendar")
	pr.DesignerCreateView(base,lbl,properties)
	
End Sub

#IgnoreWarnings: 12
Sub GetPersianCalendar As PersianCalendar
	Return pr
End Sub

Sub Show As ResumableSub
	
	dialog.Initialize(base)
	dialog.Style	=	dialog.STYLE_CUSTOM
	
	Dim ob As Object
	ob	=	dialog.ShowAsync("","تایید","انصراف","",True)
	
	Wait For (ob) Dialog_Result(Result As Int)
		If Result = dialog.RESULT_POSITIVE Then
			Return	pr.getDate
		Else
			Return	Null
		End If
	
End Sub