B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=StaticCode
Version=11
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	#if b4i
	Private device1 As NativeObject
	#end if
End Sub

Sub Name As String
	#if b4i
	device1 = device1.Initialize("UIDevice").RunMethod("currentDevice", Null)
	Return device1.GetField("name").AsString
	#end if
End Sub

Sub Model As String
	#if b4i
	device1 = device1.Initialize("UIDevice").RunMethod("currentDevice", Null)
	Return device1.GetField("model").AsString
	#end if
End Sub

Sub ModelName As String
	
	#if b4i
	Return Me.As(NativeObject).RunMethod("deviceName", Null).AsString
	#End If
	
End Sub

Sub SystemName As String
	#if b4i
	device1 = device1.Initialize("UIDevice").RunMethod("currentDevice", Null)
	Return device1.GetField("systemName").AsString
	#end if
End Sub

#if b4i
#If OBJC
#import <sys/utsname.h>
- (NSString*) deviceName
{
  struct utsname systemInfo;

  uname(&systemInfo);

  NSString* code = [NSString stringWithCString:systemInfo.machine
      encoding:NSUTF8StringEncoding];
  return code;
 }
 #end if
#End If