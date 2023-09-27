B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.8
@EndOfDesignText@
#Event: Find(Loc As Location)

Private Sub Class_Globals
	Private lm As FusedLocationProvider
	Private m As String
	Private e As String
End Sub

#if b4a
'add below permission
'<code>AddPermission(android.permission.ACCESS_FINE_LOCATION)</code>
#end if
Public Sub Initialize(Event As String)
	
	e = Event
	
	lm.Initialize("Location")
	
End Sub

Public Sub CheckLocationSetting As Boolean
	Dim gps As GPS
	gps.Initialize("")
	Return gps.GPSEnabled
End Sub

Public Sub ShowLocationSetting
	Dim gps As GPS
	gps.Initialize("")
	StartActivity(gps.LocationSettingsIntent)
End Sub

Public Sub Start
	lm.Connect
End Sub

Public Sub Stop
	lm.Disconnect
End Sub

Private Sub Location_ConnectionSuccess
	
	#if b4a
	Dim LocationRequest1 As LocationRequest
	LocationRequest1.Initialize
	LocationRequest1.SetInterval(0)
	LocationRequest1.SetPriority(LocationRequest1.Priority.PRIORITY_HIGH_ACCURACY)
	LocationRequest1.SetSmallestDisplacement(0)
  
	Try
		Dim LocationSettingsRequestBuilder1 As LocationSettingsRequestBuilder
		LocationSettingsRequestBuilder1.Initialize
		LocationSettingsRequestBuilder1.AddLocationRequest(LocationRequest1)
		lm.CheckLocationSettings(LocationSettingsRequestBuilder1.Build)
		lm.RequestLocationUpdates(LocationRequest1)
	Catch
	End Try
	
	#end if
	
End Sub

Private Sub Location_LocationSettingsChecked (LocationSettingsResult1 As LocationSettingsResult)
	Log("check location service")
End Sub

Private Sub Location_ConnectionFailed(ConnectionResult1 As Int)
	Log("failed location")
End Sub

Private Sub Location_ConnectionSuspended(SuspendedCause1 As Int)
	Log("suspend location")
End Sub

Private Sub Location_LocationChanged(locArg_ As Location)
	CallSubDelayed2(B4XPages.GetManager.GetTopPage.B4XPage,e.ToLowerCase & "_find",locArg_)
End Sub