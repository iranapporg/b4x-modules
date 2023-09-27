B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Private Sub Class_Globals
	Private ht As HttpJob
	Private xui As XUI
	Private BaseUrl As String = "https://www.app.amozesh.org/users/"
	Type Output(Status As Boolean,Result As Object)
End Sub

Public Sub Initialize
	ht.Initialize("ht",Me)
End Sub

Private Sub SetHeader
	
	If File.Exists(xui.DefaultFolder,"apino_token") Then
		ht.GetRequest.SetHeader("key",File.ReadString(xui.DefaultFolder,"apino_token"))
	Else
		ht.GetRequest.SetHeader("key","DaVqSYF6VuquWjiL1YSBLnbUeQsa4KEJ")
	End If
	
End Sub

Public Sub IsLogin As Boolean
	Return File.Exists(xui.DefaultFolder,"apino_token")
End Sub

Public Sub Login(Mobile As String) As ResumableSub
	
	ht.PostString(BaseUrl & "login","mobile=" & Mobile)
	SetHeader
	
	Wait For JobDone(Job As HttpJob)
		Return GetResult(Job)
		
End Sub

Public Sub Confirm(Token As String,Mobile As String,Code As String,FullName As String,Inviter As String) As ResumableSub
	
	Dim app_id As String = Applications.PackageName
	
	ht.PostString(BaseUrl & "confirm",$"token=${Token}&mobile=${Mobile}&full_name=${FullName}&code=${Code}&inviter=${Inviter}&app_id=${app_id}&browser=${JSON.Map2Json(DeviceInfo)}"$)
	SetHeader
	Wait For JobDone(Job As HttpJob)
		Return GetResult(Job)
		
End Sub

Private Sub GetResult(Job As HttpJob) As Output
	
	Dim o As Output
	o.Initialize
	If Job.Success = False Then
		o.Status = False
		Return o
	End If
		
	Dim rs As Map = JSON.Json2Map(Job.GetString)
	o.Status = rs.Get("status")
	o.Result = rs.Get("result")
		
	Return o
	
End Sub

Private Sub DeviceInfo As Map
	
	Dim m As Map
	m.Initialize
	m.Put("device_id",Applications.DeviceID)
	m.Put("app_name",Applications.LabelName)
	m.Put("os_name",Applications.OSName)
	m.Put("os_version",Applications.OsVersion)
	m.Put("version_code",Applications.VersionCode)
	m.Put("version_name",Applications.VersionName)
	
	#if b4i
	Dim Devices As NativeObject
	Devices = Devices.Initialize("UIDevice").RunMethod("currentDevice", Null)
	m.Put("name",Devices.GetField("name").AsString)
	m.Put("model",Devices.GetField("model").AsString)
	m.Put("sys_name",Devices.GetField("systemName").AsString)
	#end if
	
	Return m
	
End Sub