B4i=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=7.5
@EndOfDesignText@
#Event: StreamReady
#Event: StreamError (ErrorCode As String, ExtraData As Int)
#Event: Complete

Private Sub Class_Globals
	Private ob As Object
	Private ev As String
	Private player1 As NativeObject
	Private is_play As Boolean
	Private mute_ As Boolean
	Private tmr As Timer
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object,Event As String)
	ob = Module
	ev = Event
	tmr.Initialize("tmr",1000)
End Sub

Public Sub Load(Url As String)
	player1 = CreatePlayer(Url)
	Sleep(1400)
	CallSubDelayed(ob,ev.ToLowerCase & "_StreamReady".ToLowerCase)
End Sub

Public Sub Play
	tmr.Enabled = True
	is_play = True
	player1.RunMethod("play", Null)
	#if debug
	Log(Status)
	#End If
	If Status <> 1 Then
		CallSubDelayed3(ob,ev.ToLowerCase & "_StreamError".ToLowerCase,"error",Status)
	End If
End Sub

Public Sub Pause
	tmr.Enabled = False
	is_play = False
	player1.RunMethod("pause", Null)
End Sub

Private Sub tmr_Tick
	
	If Position = Duration Then
		tmr.Enabled = False
		CallSubDelayed(ob,ev.ToLowerCase & "_complete")
	End If
	
End Sub

Public Sub Stop
	Seek(0)
	Pause
End Sub

Public Sub IsPlaying As Boolean
	Return is_play
End Sub

Public Sub Status As Int
	Return player1.GetField("status").AsNumber
End Sub

Public Sub Rate As Int
	Return player1.GetField("rate").AsNumber
End Sub

'get duration per second
Public Sub Duration As Int
	Dim no As NativeObject = Me
	Return no.RunMethod("GetDuration:", Array(player1)).AsNumber
End Sub

'get position per second
Public Sub Position As Int
	Dim no As NativeObject = Me
	Return no.RunMethod("GetTime:", Array(player1)).AsNumber
End Sub

'current position is per second
Public Sub Seek(CurrentPosition As Int)
	Dim no As NativeObject = Me
	no.RunMethod("seekto::", Array(player1,CurrentPosition))
End Sub

Public Sub setMute(State As Boolean)
	player1.SetField("muted", State)
	mute_ = State
End Sub

Public Sub getMute As Boolean
	Return mute_
End Sub

'value should be between 0 and 1
Public Sub setVolume(Volume As Float)
	player1.SetField("volume", Volume)
End Sub

Public Sub getVolume As Float
	Return player1.GetField("volume")
End Sub

Private Sub CreatePlayer(url As String) As NativeObject
	Dim u As NativeObject
	u = u.Initialize("NSURL").RunMethod("URLWithString:", Array(url))
	Dim player As NativeObject
	player = player.Initialize("AVPlayer").RunMethod("alloc", Null) _
     .RunMethod("initWithURL:", Array(u))
	Return player
End Sub

#if OBJC
@import CoreMedia;
@import AVFoundation;
- (double)GetTime:(AVPlayer*)player {
   return CMTimeGetSeconds([player.currentItem currentTime]);
}
- (float)GetDuration:(AVPlayer*)player {
    Float64 duration = CMTimeGetSeconds(player.currentItem.duration);
	return duration;
}
- (void)seekto:(AVPlayer*)player :(float)pos{
    Float64 seconds = pos;
	CMTime targetTime = CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC);
	[player seekToTime:targetTime
 toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
#End If