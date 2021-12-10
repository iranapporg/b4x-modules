B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Private Sub Class_Globals
	Private recorder1 As AudioRecorder
	Private Recording1 As Boolean
	Private dir_,filename_ As String
	Private output_is_mp3 As Boolean
End Sub

'add below permission for android
'<code>
'rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)
'rp.CheckAndRequest(rp.PERMISSION_CAMERA)
'rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)
'</code>
'
'add below code to ios
'<code>#PlistExtra:<key>NSMicrophoneUsageDescription</key><string>Usage explanation here...</string></code>
'require iOS 10+
Public Sub Initialize(Dir As String,Filename As String)

	#if b4a
	recorder1.Initialize
	recorder1.AudioSource = recorder1.AS_MIC
	recorder1.OutputFormat = recorder1.OF_DEFAULT
	recorder1.AudioEncoder = recorder1.AE_AMR_NB
	recorder1.setOutputFile(Dir,Filename)
	recorder1.prepare
	#else
	dir_ = Dir
	If Filename.IndexOf(".mp3") > -1 Then
		filename_ = Filename.Replace(".mp3",".mp4")
		output_is_mp3 = True
	Else
		output_is_mp3 = False
	End If
	
	recorder1.Initialize(Dir,filename_, 44100, True, 16, False)
	#end if
	
End Sub

Sub Start
	
	Try
		#if b4a
		recorder1.start
		#else
		recorder1.Record
		#end if
		Recording1 = True
	Catch
		Recording1 = False
	End Try
	
End Sub

Sub Stop
	
	Try
		Recording1 = False
		recorder1.stop
		If output_is_mp3 Then
			filename_ = filename_.Replace(".mp4",".mp3")
		End If
		File.Copy(dir_,filename_.Replace(".mp3",".mp4"),dir_,filename_)
	Catch
	End Try
	
End Sub

Sub getRecording As Boolean
	Return Recording1
End Sub