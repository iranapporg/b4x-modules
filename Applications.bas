B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
#IgnoreWarnings: 12
Private Sub Process_Globals

End Sub

Sub LabelName As String
	
	#if b4a
	Return Application.LabelName
	#else
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleDisplayName"))
	Return name
	#End If
	
End Sub

Sub VersionCode As String
	
	#if b4a
	Return Application.VersionCode
	#else
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleShortVersionString"))
	Dim temp As String
	temp = name
	Return temp.Replace(".","")
	#End If
	
End Sub

Sub VersionName As String
	
	#if b4a
	Return Application.VersionName
	#else
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleShortVersionString"))
	Return name
	#End If
	
End Sub

Sub DeviceID As String
	
	#if b4a
	Dim id2 As String
	Dim p As Phone
	id2	=	p.GetSettings("android_id")
	Return id2
	#else
	Dim ph As Phone
	Dim name As String
	
	If ph.KeyChainGet("imei") = "" Then
	' get device unique identifier
		Dim Device1 As NativeObject
		Device1 = Device1.Initialize("UIDevice").RunMethod("currentDevice", Null)
		name = Device1.GetField("identifierForVendor").AsString
		ph.KeyChainPut("imei",name)
	Else
		name	=	ph.KeyChainGet("imei")
	End If
	
	Return name
	#End If

End Sub

Sub PackageName As String
	
	#if b4a
	Return Application.PackageName
	#else
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleIdentifier"))
	Return name
	#End If
	
End Sub

Sub OSName As String
	
	#if b4a
	Return "android"
	#else
	Return "ios"
	#End If
	
End Sub

Sub OsVersion As String
	
	#if b4i
	Return Main.App.OSVersion
	#else
	Dim p As Phone
	Return p.SdkVersion
	#End If
	
End Sub

Sub ExitApp
	
	#if b4i
	Dim No As NativeObject = Me
	No.RunMethod("ExitApplication",Null)
	#if OBJC
	- (void) ExitApplication {

	UIApplication *app = [UIApplication sharedApplication]; 
	[app performSelector:@selector(suspend)]; 
	 [NSThread sleepForTimeInterval:2.0];
	exit(0);

	}
	#End if
	#Else
	ExitApplication
	#end if
	
End Sub

#if b4i
Sub ExitApplication
	ExitApp
End Sub
#end if