B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=10.9
@EndOfDesignText@
#Event: OnResponse(Result As Map,Error As String)
#Event: OnResponse(Result As List,Error As String)
#Event: OnResponse(Result As String,Error As String)
#Event: Request_OnError(CurrentCallback As Callback)

Private Sub Class_Globals
	
	Type Callback (Module As Object,Event As String,Error As String)
	
	Private http As HttpJob
	Private xui As XUI
	Private js As JSONParser
	Private method_ As String
	Private parameters_ As Map
	Private headers_ As Map
	Private timeout_ As Int
	Private module_ As Object
	Private event_ As String
	Private body_ As String
	Private no_cache As Boolean
	Private files_ As List
	Private start_time,end_time As Int
	Private as_map,as_list As Boolean
	
	Public ERROR_SERVICE_UNAVAIALBE As String 	= "SERVICE_UNAVAIALBE"
	Public ERROR_HOST_UNAVAILABLE As String 		= "HOST_UNAVAILABLE"
	Public ERROR_NETWORK_ERROR As String 		= "NETWORK_ERROR"
	Public ERROR_CONNECT As String 				= "ERROR_CONNECT"
	Public ERROR_ALL As String 					= ""
	
	Public METHOD_POST As String = "POST"
	Public METHOD_GET As String = "GET"
	Public METHOD_PUT As String = "PUT"
	Public METHOD_DELETE As String = "DELETE"
	Public METHOD_FILE As String = "FILE"
	
	Private request_result As String
	Private base_url As String
	
	Private last_request As Map
	
	Private show_activity_on_error_module As Object
	Private show_activity_on_error_error_type As String
	Private show_activity_on_error_event As String
	
	Private is_success = False
	
End Sub

'Initializes the object.
'use below code for android to prevent block thraid
'<code>
'Sub DisableStrictMode
'	Dim jo As JavaObject
'	jo.InitializeStatic("android.os.Build.VERSION")
'	If jo.GetField("SDK_INT") > 9 Then
'		Dim policy As JavaObject
'		policy = policy.InitializeNewInstance("android.os.StrictMode.ThreadPolicy.Builder", Null)
'		policy = policy.RunMethodJO("permitAll", Null).RunMethodJO("build", Null)
'		Dim sm As JavaObject
'		sm.InitializeStatic("android.os.StrictMode").RunMethod("setThreadPolicy", Array(policy))
'	End If
'End Sub
'</code>
Public Sub Initialize
	parameters_.Initialize
	headers_.Initialize
	files_.Initialize
	last_request.Initialize
	timeout_ = 15000
	no_cache = True
End Sub

'save clicked event and call that again on error
'for ErrorType, you can use constant ERROR_
'add code <code>Sub Request_OnError(CalbackModule as Object,CallbackEvent As String)
'
'End Sub</code>
'into Main activity or page
'in this event, you can show error page
Sub ShowActivityOnError(ErrorType As String,Module As Object,Event As String) As HttpRequest2
	
	show_activity_on_error_error_type	=	ErrorType
	show_activity_on_error_module		=	Module
	show_activity_on_error_event			=	Event
	
	Return Me
	
End Sub

'methods are GET,POST,PUT,DELETE,FILE
Sub Method(Val As String) As HttpRequest2
	
	last_request.Put("method",Val)
	
	method_ = Val.ToUpperCase
	Return Me
	
End Sub

Sub RequestBody(data As String) As HttpRequest2
	body_ = data
	Return Me
End Sub

'set parameter for request
Sub Parameter(Parameters As Map) As HttpRequest2
	
	last_request.Put("parameter",Parameters)
	
	parameters_ = Parameters
	Return Me

End Sub

'contain files with MultipartFileData type
Sub AttachmentFiles(ListFile As List) As HttpRequest2
	
	last_request.Put("files",ListFile)
	
	files_ = ListFile
	Return Me
	
End Sub

'set headers on request
Sub Header(Headers As Map) As HttpRequest2
	
	last_request.Put("headers",Headers)
	
	headers_ = Headers
	Return Me
	
End Sub

'url must have / in end url
Sub SetBaseUrl(Url As String) As HttpRequest2
	last_request.Put("base_url",Url)
	base_url = Url
	Return Me
End Sub

'according to millisecond
Sub Timeout(Second As Int) As HttpRequest2
	
	last_request.Put("timeout",Second)
	
	timeout_ = Second
	Return Me
	
End Sub

'call event after finish request
Sub Callback(Module As Object,Event As String) As HttpRequest2
	
	last_request.Put("module",module_)
	last_request.Put("event",Event)
	
	module_ = Module
	event_ = Event
	
	Return Me
	
End Sub

'prevent cache request
Sub NoCache As HttpRequest2
	last_request.Put("no_cache",NoCache)
	no_cache = True
	Return Me
End Sub

'return result as map on event
Sub AsMap As HttpRequest2
	last_request.Put("as_map",True)
	as_map = True
	Return Me
End Sub

'return result as list on event
Sub AsList As HttpRequest2
	last_request.Put("as_list",True)
	as_list = True
	Return Me
End Sub

'according to second
Sub GetElapsedTime As Int
	Return end_time - start_time
End Sub

'get http status code
Sub GetStatusCode As Int
	Return http.Response.StatusCode	
End Sub

'get http response (contain headers)
#if b4i
Sub GetResponse As HttpResponse
	Return http.Response
End Sub
#else
Sub GetResponse As OkHttpResponse
	Return http.Response
End Sub
#end if

Sub IsSuccess As Boolean
	Return is_success
End Sub

Sub Submit(UrlOrEndpoint As String) As ResumableSub
	
	#if b4i
	Main.App.NetworkActivityIndicatorVisible = True
	#End If
	
	http.Initialize("http",Me)
	
	UrlOrEndpoint = base_url & UrlOrEndpoint
	last_request.Put("endpoint",UrlOrEndpoint)
	
	Dim query As String
	query = PrepareParameters
	
	If body_ <> "" Then query = body_
	
	start_time = DateTime.Now
	
	#region Set method
	If method_ = "POST" Then
		http.PostString(UrlOrEndpoint,query)

	Else If method_ = "PUT" Then
		http.PostString(UrlOrEndpoint,"")
		http.GetRequest.InitializePut2(UrlOrEndpoint,query.GetBytes("UTF8"))
		http.GetRequest.SetContentType("x-www-form-urlencoded")
	
	Else If method_ = "DELETE" Then
		http.PostBytes(UrlOrEndpoint, query.GetBytes("utf8"))
		#if b4i
		Dim no As NativeObject = http.GetRequest
		no.GetField("object").RunMethod("setHTTPMethod:", Array("DELETE"))
		#end if
		http.GetRequest.SetContentType("x-www-form-urlencoded")
	
	Else If method_ = "GET" Then
		http.Download(UrlOrEndpoint & "?" & query)
	
	Else If method_ = "FILE" Then
		
		Dim ListFiles As List
		ListFiles	=	files_
		
		http.PostMultipart(UrlOrEndpoint,parameters_,ListFiles)
	
	End If
	#end region
	
	http.GetRequest.Timeout = timeout_
	
	If no_cache Then
		http.GetRequest.SetHeader("Cache-Control","no-store, no-cache, must-revalidate, max-age=0")
		#if b4i
		http.GetRequest.SetHeader("user-agent","ios")
		#else
		http.GetRequest.SetHeader("user-agent","android")
		#end if
	End If
	
	http.GetRequest.SetHeader("appversioncode",Applications.VersionCode)
	http.GetRequest.SetHeader("apppackagename",Applications.PackageName)
	http.GetRequest.SetHeader("appos",Applications.OSName)
	http.GetRequest.SetHeader("apposversion",Applications.OsVersion)

	If headers_.Size > 0 Then
		For Each key As String In headers_.Keys
			http.GetRequest.SetHeader(key,headers_.Get(key))
		Next
	End If
	
	#region Response request
	Wait For JobDone(Job As HttpJob)

		#if b4i
		Main.App.NetworkActivityIndicatorVisible = False
		#End If

		end_time = DateTime.Now
		
		If Job.Success Then
			
			#if debug
			Log(Job.GetString)
			#End If
			
			is_success	=	True
		
			request_result	=	Job.GetString
		
			Job.Release
		
			If as_map Then
				
				If xui.SubExists(module_,event_ & "_onresponse",0) Then
					CallSubDelayed3(module_,event_ & "_onresponse",ResultAsMap(request_result),"")
					Return True
				End If
				
				Return ResultAsMap(request_result)
			
			Else if as_list Then
				
				If xui.SubExists(module_,event_ & "_onresponse",0) Then
					CallSubDelayed3(module_,event_ & "_onresponse",ResultAsList(request_result),"")
					Return True
				End If
			
				Return ResultAsList(request_result)
				
			Else
				Return request_result
			End If
		
		Else
			
			is_success	=	False
		
			Dim job_error As String
			Dim error2 As String
			job_error = http.ErrorMessage.ToLowerCase
			
			If job_error.IndexOf("ResponseError. Reason: Service unavailable, Response: Service unavailable".ToLowerCase) > -1 Then
				job_error = "SERVICE_UNAVAIALBE"
			
			Else if job_error.IndexOf("java.net.UnknownHostException: Unable to resolve host".ToLowerCase) > -1 Then
				job_error = "HOST_UNAVAILABLE"
			
			Else if job_error.IndexOf("java.net.SocketTimeoutException".ToLowerCase) > -1 Then
				job_error = "NETWORK_ERROR"
				
			Else if job_error.IndexOf("ResponseError. Reason: java.net.ConnectException: Failed To connect".ToLowerCase) > -1 Then
				job_error = "HOST_UNAVAILABLE"
			
			Else if job_error.IndexOf("android.os.NetworkOnMainThreadException".ToLowerCase) > -1 Then
				job_error = "ERROR_MAIN_THREAD"
			End If
			
		If show_activity_on_error_error_type = error2 Or show_activity_on_error_error_type = ERROR_ALL Then
			Dim call As Callback
			call.Initialize
			call.Module = show_activity_on_error_module
			call.Event = show_activity_on_error_event
			call.Error = job_error
			CallSubDelayed2(Main,"Request_OnError",call)
		End If
		
		Job.Release
		
		If is_Json(job_error) Then
			
			job_error = job_error
			
			Dim j As JSONParser
			j.Initialize(error2)
			Return j.NextObject
		
		Else
			Return job_error
		End If

	End If		
	#end region
		
End Sub

'library save all fields last request and can rerun that
Sub ReloadLastRequest(LastRequest As Map) As Boolean
	
	If LastRequest.Size > 0 Then
		
		If LastRequest.ContainsKey("method") Then
			Method(LastRequest.Get("method"))
		End If
		
		If LastRequest.ContainsKey("parameter") Then
			Parameter(LastRequest.Get("parameter"))
		End If
		
		If LastRequest.ContainsKey("files") Then
			AttachmentFiles(LastRequest.Get("files"))
		End If
		
		If LastRequest.ContainsKey("headers") Then
			Header(LastRequest.Get("headers"))
		End If
		
		If LastRequest.ContainsKey("base_url") Then
			SetBaseUrl(LastRequest.Get("base_url"))
		End If
		
		If LastRequest.ContainsKey("timeout") Then
			Timeout(LastRequest.Get("timeout"))
		End If
		
		If LastRequest.ContainsKey("module") Then
			Callback(LastRequest.Get("module"),LastRequest.Get("event"))
		End If
		
		If LastRequest.ContainsKey("no_cache") Then
			NoCache
		End If
		
		If LastRequest.ContainsKey("as_map") Then
			AsMap
		End If
		
		If LastRequest.ContainsKey("as_list") Then
			AsList
		End If
		
		Submit(LastRequest.Get("endpoint"))
		
		Return True
		
	Else
		Return False
		
	End If
	
End Sub

Private Sub PrepareParameters As String
	
	Dim query As String
	
	For Each v1 As String In parameters_.Keys
		query = query & v1 & "=" & parameters_.Get(v1) & "&"
	Next
	
	If query <> "" Then
		query = query.SubString2(0,query.Length-1)
	End If
		
	Return query

End Sub

Private Sub ResultAsMap(Data As String) As Map
	
	Try
		js.Initialize(Data)
		Dim m As Map
		m = js.NextObject
		Return m	
	Catch
		Return Null
	End Try
	
End Sub

Private Sub ResultAsList(Data As String) As List
	
	Try
		js.Initialize(Data)
		Dim m As List
		m = js.NextArray
		Return M	
	Catch
		Return Null
	End Try
	
End Sub

Private Sub is_Json(JSON_ As String) As Boolean
	If Regex.IsMatch($"[{\[]{1}([,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]|".*?")+[}\]]{1}"$, JSON_.Trim) And JSON_.Length > 2  Then
		Return True
	Else
		Return False
	End If
End Sub