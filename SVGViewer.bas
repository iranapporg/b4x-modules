B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
#DesignerProperty: Key: filename, DisplayName: svg filename .svg, FieldType: String, DefaultValue: 

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private rainbow As SVG
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Color = Colors.Transparent
	mBase.SetColorAndBorder(Colors.Transparent,0,0,0)
    Tag = mBase.Tag
    mBase.Tag = Me 
	rainbow.Initialize(File.DirAssets, Props.Get("filename"))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

	Dim img As ImageView
	img.Initialize("")
	img.Color	=	Colors.Transparent
	img.ContentMode = img.MODE_FILL
	mBase.AddView(img,0,0,mBase.Width,mBase.Height)
	img.Bitmap = rainbow.Export(img.Width, img.Height)
	
End Sub