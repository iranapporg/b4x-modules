B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
#DesignerProperty: Key: duration, DisplayName: Animation duration, FieldType: Int,DefaultValue: 1
#DesignerProperty: Key: loop, DisplayName: Looping animation, FieldType: Boolean,DefaultValue: True
#DesignerProperty: Key: jsonfile, DisplayName: Json filename, FieldType: String,DefaultValue: 
#DesignerProperty: Key: dir, DisplayName: Json folder name (asset or Internal), FieldType: String, DefaultValue: Asset, List: Asset|App

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	#if b4a
	Private LAV As Hitex_LottieAnimationView
	#Else
	#if release
	Private LAV As iLottie
	#end if
	#End If
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	
	mBase.Color	=	Colors.Transparent
	mBase.SetColorAndBorder(0,0,0,0)
	
	Dim dir As String
	If Props.Get("dir") = "Asset" Then
		dir = File.DirAssets
	Else
		dir = xui.DefaultFolder
	End If

	#if b4a
	LAV.Initialize("LAV")
	mBase.AddView(LAV,0,0,-1,-1)
	LAV.Speed = Props.Get("duration")
	LAV.SetAnimation(dir,Props.Get("jsonfile"))
	LAV.SetLoop(Props.Get("loop")) 'repeat
	#else
	#if release
	LAV.Initialize("LAV",Me)
	LAV.AnimationFromFile(dir,Props.Get("jsonfile"))
	LAV.AnimationProgress = Props.Get("duration")
	LAV.ContentMode = LAV.ASPECT_FIT_CONTENT
	LAV.LoopAnimation = Props.Get("loop")
	mBase.AddView(LAV.AnimationView,0,0,-1,-1)
	#end if
	#End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub Play
	
	#if b4a
	LAV.PlayAnimation
	#else
	#if release
	LAV.Play
	#end if
	#End If
	
End Sub

Public Sub Pause
	
	#if b4a
	LAV.PauseAnimation
	#else
	#if release
	LAV.Pause
	#end if
	#End If
	
End Sub