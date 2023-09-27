B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.3
@EndOfDesignText@
Private Sub Process_Globals
End Sub

Public Sub GregorianToIslamic (Year As Long,Month As Long,Day As Long) As Long()
	Dim NativeMe As NativeObject = Me
	Dim mResult As Object = NativeMe.RunMethod("GregorianToIslamicDate:::", Array(Year,Month,Day))
	Return Spliter(mResult)
End Sub

Public Sub IslamicToGregorian (Year As Long,Month As Long,Day As Long) As Long()
	Dim NativeMe As NativeObject = Me
	Dim mResult As Object = NativeMe.RunMethod("IslamicToGregorian:::", Array(Year,Month,Day))
	Return Spliter(mResult)
End Sub

Public Sub IslamicToPersian (Year As Long,Month As Long,Day As Long) As Long()
	Dim NativeMe As NativeObject = Me
	Dim mResult As Object = NativeMe.RunMethod("IslamicToPersian:::", Array(Year,Month,Day))
	Return Spliter(mResult)
End Sub

Public Sub PersianToGregorian (Year As Long,Month As Long,Day As Long) As Long()
	Dim NativeMe As NativeObject = Me
	Dim mRes As Object = NativeMe.RunMethod("PersianToGregorian:",Array(ToString(Year,Month,Day)))
	Return Spliter(mRes)
End Sub

Public Sub GregorianToPersian (Year As Long,Month As Long,Day As Long) As Long()
	Dim NativeMe As NativeObject = Me
	Dim mRes As Object = NativeMe.RunMethod("GregorianToPersian:",Array(ToString(Year,Month,Day)))
	Return Spliter(mRes)
End Sub

Public Sub PersianToIslamic (Year As Long,Month As Long,Day As Long) As Long()
	Dim Res() As Long = PersianToGregorian(Year,Month,Day)
	Return GregorianToIslamic(Res(0),Res(1),Res(2))
End Sub

Public Sub ToString2(Results() As Long) As String
	Return ToString(Results(0),Results(1),Results(2))
End Sub
Public Sub ToString(Year As Long,Month As Long,Day As Long) As String
	Return Year&"/"&Month&"/"&Day
End Sub
Private Sub Spliter (Result As String) As Long()
	Dim ResSpliter() As String = Regex.Split("/",Result)
	Return Array As Long(ResSpliter(0),ResSpliter(1),ResSpliter(2))
End Sub
#If OBJC
- (NSString *) GregorianToIslamicDate : (long) year: (long) month: (long) day {
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];
   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
	  return dates;
}

- (NSString *) IslamicToGregorian : (long) year: (long) month: (long) day {
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];
   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
	  return dates;
}

- (NSString *) IslamicToPersian : (long) year: (long) month: (long) day {
NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
gregorianComponents.day = day;
gregorianComponents.month = month;
gregorianComponents.year = year;
NSDate *date = [gregorianCalendar dateFromComponents:gregorianComponents];
NSCalendar *hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
NSDateComponents *hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                               NSMonthCalendarUnit |
                                                               NSYearCalendarUnit)
                                                     fromDate:date];
   NSString *dates=   [NSString stringWithFormat:@"%ld/%ld/%ld",(long)[hijriComponents year],
   (long)[hijriComponents month],(long)[hijriComponents day]];
	  return dates;
}

- (NSString *) PersianToGregorian : (NSString *) Persiandate {
NSDateFormatter *df = [[NSDateFormatter alloc] init];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
df.dateStyle = NSDateFormatterMediumStyle;
df.dateFormat = @"yyyy/MM/dd";
NSString *stringDate =Persiandate;

NSDate *date = [df dateFromString:stringDate];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSString *stringDateConverted = [df stringFromDate:date];
return stringDateConverted;
}

- (NSString *) GregorianToPersian : (NSString *) gdate {
NSDateFormatter *df = [[NSDateFormatter alloc] init];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
df.dateStyle = NSDateFormatterMediumStyle;
df.dateFormat = @"yyyy/MM/dd";
NSString *stringDate =gdate;

NSDate *date = [df dateFromString:stringDate];
df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
NSString *stringDateConverted = [df stringFromDate:date];
return stringDateConverted;
}
#End If
