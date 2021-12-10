﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'xChart Custom View class
'Version 5.5
'Added DrawXScale and DrawYScale properties
'
'Version 5.4
'Amended problem with logarithmic manual scales
'
'Version 5.3
'Added the four properties below
'DrawGridFrame As Boolean, True by default
'DrawHorizontalGridLines As Boolean, True by default
'DrawVerticallGridLines As Boolean, True by default
'YZeroAxisHighlight As Boolean, True by default
'
'Version 5.2
'Amended NbYInterval problem when set in code.
'
'Version 5.1
'Replced Props.Get by Props.GetDefault, to avoid compatibility problems when addin new properties
'
'Version 5.0
'Amended probelm for scales with same min max values.
'
'Version 4.9
'Amended problem with different scales, didn't work with more than 2 lines.

'Version 4.8
'Added limit of Y scale values if there is not enough place
'Improved values display layout
'Added different scales for 2 up to 4 lines in LINE and YX_CHART charts
'
'Version 4.7
'Set Base_Resize Public
'Amended Width and Height property setting
'
'Version 4.6
'Added AxisTextColor
'
'Version 4.5
'Added the DrawEmptyChart method
'Amended error in ClearPoints method, YXPoints were not cleared
'
'Version 4.4	2020.02.09
'Added logarithmic Y scales for LINE charts 
'Added logarithmic Y and/or X scales for YX_CHART charts
'Added ValuesShowPosition property, can be upper left and new also upper right
'
'Version 4.3	2020.01.07
'Improved Bar width calculation
'
'Version 4.2	2019.11.05
'Amended Draw MinLine with YZeroAxis.
'Added PiePercentageNbFractions property
'
'Version 4.1	2019.09.21
'Amended scale with YZeroAxis and negative values.
'
'Version 4.0	2019.09.20
'Amended scale problems with big scales, YZeroAxis and value zero line.

'Version 3.9	2019.03.23
'Added ClearPoints method

'Version 3.8	2019.02.23
'Added the ScalesValues property, which allows to define custom scale values
'the default scale values are 1 2 2.5 5 10
'
'Version 3.7 2019.02.01
'Amended mean line in Bar charts, put the line in front
'
'Version 3.6 2019.01.18
'Amended wrong results during the first drawing, Added Sleep(0) in Base_Resize
'Amended scales for the YXChart type
'Amended some minor bugs
'
'Version 3.5 2019.01.12
'Amended scales problem with manual scaling
'
'Version 3.4 2019.01.12
'Added following properties: Subtitle, SubtitleTextSize, SubtitleTextColor
'Added BarValueOrientation property
'
'Version 3.3 2018.12.26
'Amended transparent color
'
'Version 3.2 2018.12.15
'Amended Y scale for StackedBarChart
'Amended StackedBarChart min withd
' 
'Version 3.1 2018.12.04
'Amended problem with Lgend at BOTTOM 
'
'Version 3.0 2018.11.22
'Amended problem with bar charts width many bars, and bar width too small < 4dip
'improved bar width calculation
'
'Version 2.9 2018.11.15
'Improved scale drawing with all zeros
'use the MeanLineColor also for the single bar chart; before, the color was the Bar color
'
'Version 2.8 2018.11.14
'Amended Bar mean line property
'Added number format for Bar mean line value
'
'Version 2.7 2018.11.05
'Improved x scale drawing, avoid text overlapping
'Amended an error
'
'Version 2.6 2018.11.04
'Added min, max and mean lines for single line charts
'Improved automatic scale calculation
'Amended some errors
'
'Version 2.5 2018.10.03
'Improved sacle display
'added dynamic lines in the B4A demo project 
'
'Version 2.4 2018.08.31
'Ameded error with Legend.IncludeLegend <> "NONE" And Items.Size > 0 
'
'Version 2.3 2018.08.27
'Ameded error with DrawOuterFrame
'
'Version 2.2 2018.08.18
'Ameded an error for B4i (SubExists is different in B4i)
'
'Version 2.1 2018.08.19
'Added the NbXIntervals property
'Added the SnapShot property
'Added the Rotation property
'Added the DrawOuterFrame property
'Added a clip function to avoid lines being drawn outsides the grid
'Added a Touch event for YXCharts returning the X and Y coordinates of the cursor
'
'Version 2.0 2018.07.19
'Added set / getXSclaMinValue and set / getXSclaMaxValue and 
'
'Version 1.9 2018.07.14
'Modified the data structure for YXChart to allow lines with different number of points.
'
'Version 1.8 2018.07.12
'added RemovePointData method
'added NbPoints property
'added more comments
'
'Version 1.7 2018.07.05
'added YX_CHART type
'added mean line to single bar charts
'amended some errors
'
'Version 1.6 2018.06.01
'adapted the code with the new features of B4A V8.30+, B4i V 5.00+ and B4J V6.30+
'use of the BitmapCreator library instead of the class
'use of the Touch event of a B4XView and xui.Scale
'
'Version 1.5 2018.05.21
'Amended some bugs.
'changed the color properties from native colors to xui colors.
'added the YZeroAxis property.
'improved Numberformat3 routine
'
'Version 1.4 2018.05.10
'Added gradient colors.

'Version 1.3 2018.05.02
'Amended the TextColor not used.
'Changed it to TitleTextColor

'Version 1.2 2018.04.29
'Amended the ScaleTextColor property not working.
'The old versions used the GridColor instead of the ScaleTextColor.
'
'Version 1.1 2018.04.26
'Added display of data values with a click
'Added different line widths on a same chart
'Added point shapes for line points
'
'Version 1.0 2018.04.26
'
'Written by Klaus CHRISTL (klaus)

#Event: Touch (Action As Int, X As Float, Y As Float)
#RaisesSynchronousEvents: Touch(Action As Int, X As Float, Y As Float)

#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Bar chart
#DesignerProperty: Key: Subtitle, DisplayName: Subtitle, FieldType: String, DefaultValue: 
#DesignerProperty: Key: XAxisName, DisplayName: X axis name, FieldType: String, DefaultValue: X axis
#DesignerProperty: Key: YAxisName, DisplayName: Yaxis name, FieldType: String, DefaultValue: Y axis
#DesignerProperty: Key: YMaxValue, DisplayName: Y max value, FieldType: Int, DefaultValue: 100, Description: Max Y value manual scale
#DesignerProperty: Key: YMinValue, DisplayName: Y min vlaue, FieldType: Int, DefaultValue: 0, Description: Min Y value manual scale
#DesignerProperty: Key: XMaxValue, DisplayName: X max value, FieldType: Int, DefaultValue: 100, Description: Max X value manual scale, only for YX_CHART
#DesignerProperty: Key: XMinValue, DisplayName: X min vlaue, FieldType: Int, DefaultValue: 0, Description: Min X value manual scale, only for YX_CHART
#DesignerProperty: Key: YZeroAxis, DisplayName: YZeroAxis, FieldType: Boolean, DefaultValue: True, Description: Stes the min value to 0 if all values are > 0 and max valule to 0 if all values are <0
#DesignerProperty: Key: YZeroAxisHighlight, DisplayName: YZeroAxisHighlight, FieldType: Boolean, DefaultValue: True, Description: Highlights the Y zero axis if its value is beolw the top line and above the bottom line
#DesignerProperty: Key: NbYIntervals, DisplayName: Number of Y intervals, FieldType: Int, DefaultValue: 10, Description: number of Y intervals
#DesignerProperty: Key: NbXIntervals, DisplayName: Number of X intervals, FieldType: Int, DefaultValue: 10, Description: number of X intervals, only for YX_CHART
#DesignerProperty: Key: ChartType, DisplayName: Chart type, FieldType: String, DefaultValue: BAR, List: LINE|BAR|STACKED_BAR|PIE|YX_CHART, Description:Sets the chart type.
#DesignerProperty: Key: ChartBackgroundColor, DisplayName: Chart background color, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridFrameColor, DisplayName: Grid frame color, FieldType: Color, DefaultValue: 0xFF000000, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: DrawGridFrame, DisplayName: DrawGridFrame, FieldType: Boolean, DefaultValue: True, Description: If False no frame is drawn around the grid only the X and Y scale lines.
#DesignerProperty: Key: DrawHorizontalGridLines, DisplayName: DrawHorizontalGridLines, FieldType: Boolean, DefaultValue: True, Description: If False no horizontal grid lines are drawn.
#DesignerProperty: Key: DrawVerticalGridLines, DisplayName: DrawVerticalGridLines, FieldType: Boolean, DefaultValue: True, Description: If False no horizontal grid lines are drawn.
#DesignerProperty: Key: GridColor, DisplayName: Grid color, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: TitleTextColor, DisplayName: Title text color, FieldType: Color, DefaultValue: 0xFF000000, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SubtitleTextColor, DisplayName: Subtitle text color, FieldType: Color, DefaultValue: 0xFF000000, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GradientColors, DisplayName: Gradient colors, FieldType: Boolean, DefaultValue: True, Description:  Gradient colors for pies and bars
#DesignerProperty: Key: GradientColorsAlpha, DisplayName: Gradient colors alpha, FieldType: Int, DefaultValue: 96, MinRange: 0, MaxRange: 255, Description: Gradient colors alpha value for pies and bars
#DesignerProperty: Key: AxisTextColor, DisplayName: AxisTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Axis text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: ScaleTextColor, DisplayName: ScaleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Scale text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: ScaleValues, DisplayName: ScaleValues, FieldType: String, DefaultValue: 1!2!2.5!5!10, List: 1!2!2.5!5!10|1!1.2!1.5!1.8!2!2.5!3!4!5!6!7!8!9!10, Description: Scale values a string with the different possible scale values separated by the exclamation mark and must begin with 1! and end with !10
#DesignerProperty: Key: ScaleYValuesLog, DisplayName: ScaleYValuesLog, FieldType: String, DefaultValue: 1!2!5!7!10, List: 1!2!5!7!10|1!1.5!2!3!4!5!7!10, Description: Logarithmic Y Scale values a string with the different possible scale values for one decade separated by the exclamation mark and must begin with 1! and end with !10. Valid only for LINE and YX_CHART
#DesignerProperty: Key: ScaleXValuesLog, DisplayName: ScaleXValuesLog, FieldType: String, DefaultValue: 1!2!5!7!10, List: 1!2!5!7!10|1!1.5!2!3!4!5!7!10, Description: Logarithmic X Scale values a string with the different possible scale values for one decade separated by the exclamation mark and must begin with 1! and end with !10. Valid only for YX_CHART
#DesignerProperty: Key: DrawXScale, DisplayName: DrawXScale, FieldType: Boolean, DefaultValue: True, Description: Draws the X scale, not drawing the scale can be usefull for small charts. Not for logarithmic scales.
#DesignerProperty: Key: DrawYScale, DisplayName: DrawYScale, FieldType: Boolean, DefaultValue: True, Description: Draws the Y scale, not drawing the scale can be usefull for small charts. Not for logarithmic scales.
#DesignerProperty: Key: TitleTextSize, DisplayName: TitleTextSize, FieldType: Int, DefaultValue: 18, Description: Title text size, valid only if AutoTextSize = False.
#DesignerProperty: Key: SubtitleTextSize, DisplayName: SubtitleTextSize, FieldType: Int, DefaultValue: 16, Description: Subtitle text size, valid only if AutoTextSize = False.
#DesignerProperty: Key: AxisTextSize, DisplayName: AxisTextSize, FieldType: Int, DefaultValue: 14, Description: Axis name text size, valid only if AutoTextSize = False.
#DesignerProperty: Key: ScaleTextSize, DisplayName: ScaleTextSize, FieldType: Int, DefaultValue: 12, Description: Scale text size, valid only if AutoTextSize = False.
#DesignerProperty: Key: LegendTextSize, DisplayName: LegendTextSize, FieldType: Int, DefaultValue: 14, Description: Legend text size, valid only if AutoTextSize = False.
#DesignerProperty: Key: AutomaticTextSizes, DisplayName: AutomaticTextSizes, FieldType: Boolean, DefaultValue: True, Description: Automatic text sizes, they are automatically calculated according to the chart size.
#DesignerProperty: Key: IncludeLegend, DisplayName: Include Legend, FieldType: String, DefaultValue: NONE, List: NONE|TOP_RIGHT|BOTTOM
#DesignerProperty: Key: IncludeValues, DisplayName: Include values in single bar charts or pie charts with TOP_RIGHT legend, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: BarValueOrientation, DisplayName: BarValueOrientation, FieldType: String, DefaultValue: HORIZONTAL, List: HORIZONTAL|VERTICAL, Description: Orientation of the avlue text in single bar charts
#DesignerProperty: Key: IncludeBarMeanLine, DisplayName: Include bar mean line, FieldType: Boolean, DefaultValue: False, Description: Adds a line at the mean value and its value, only for single bar charts
#DesignerProperty: Key: IncludeMinLine, DisplayName: IncludeMinLine, FieldType: Boolean, DefaultValue: False, Description: Adds a line for the min value, only for single line charts
#DesignerProperty: Key: IncludeMaxLine, DisplayName: IncludeMaxLine, FieldType: Boolean, DefaultValue: False, Description: Adds a line for the max value, only for single line charts
#DesignerProperty: Key: IncludeMeanLine, DisplayName: IncludeMeanLine, FieldType: Boolean, DefaultValue: False, Description: Adds a line for the mean value, only for single line charts
#DesignerProperty: Key: MinLineColor, DisplayName: MinLineColor, FieldType: Color, DefaultValue: 0xFF008000, Description: Color of the min line. Valid for single line charts. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: MaxLineColor, DisplayName: MaxLineColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the max line. Valid for single line charts. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: MeanLineColor, DisplayName: MeanLineColor, FieldType: Color, DefaultValue: 0xFFB64A1A, Description: Color of the mean line. Valid for single line and single bar charts. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: AutomaticScale, DisplayName: AutomaticScale, FieldType: Boolean, DefaultValue: True, Description: Sets automatic scales. If checked, YMinValue and YMaxValue have no effect!
#DesignerProperty: Key: DifferentScales, DisplayName: DifferentScales, FieldType: Boolean, DefaultValue: False, Description: Sets different scales only for LINE and YX_CHART charts. If True uses a different automatic scale for each line fro two up to four lines!
#DesignerProperty: Key: LogarithmicYScale, DisplayName: LogarithmicYScale, FieldType: Boolean, DefaultValue: False, Description: Sets logarithmic Y scale only for LINE BAR and YX_CHART.
#DesignerProperty: Key: LogarithmicXScale, DisplayName: LogarithmicXScale, FieldType: Boolean, DefaultValue: False, Description: Sets logarithmic X scale only for YX_CHART.
#DesignerProperty: Key: XScaleTextOrientation, DisplayName: XScaleTextOrientation, FieldType: String, DefaultValue: HORIZONTAL, List: HORIZONTAL|VERTICAL|45 DEGREES, Description: Sets the X scale orientation.
#DesignerProperty: Key: PieGapDegrees, DisplayName: PieGapDegrees, FieldType: Int, DefaultValue: 0, Description: Gap in degrees betwwen pies, pie chart only
#DesignerProperty: Key: PieAddPerentage, DisplayName: PieAddPerentage, FieldType: Boolean, DefaultValue: True, Description: Add percentage values in pie slices.
#DesignerProperty: Key: PiePerentageNbFractions, DisplayName: PiePerentageNbFractions, FieldType: Int, DefaultValue: 0, Description: Number of fractions for pie percentage values: min = 0  max = 2.
#DesignerProperty: Key: DisplayValues, DisplayName: DisplayValues, FieldType: Boolean, DefaultValue: True, Description: Display values when clicking on a chart.
#DesignerProperty: Key: ValuesPosition, DisplayName: ValuesPosition, FieldType: String, DefaultValue: TOP_LEFT, List: TOP_LEFT|TOP_RIGHT, Description: Position of the panel showing the values when clicking on a chart.
#DesignerProperty: Key: ValuesTextSize, DisplayName: ValuesTextSize, FieldType: Int, DefaultValue: 14, Description: Text size of the values.
#DesignerProperty: Key: ValuesTextColor, DisplayName: Values text color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the values texts.
#DesignerProperty: Key: DrawOuterFrame, DisplayName: Draw outer frame, FieldType: Boolean, DefaultValue: False, Description: Draws an outer frame around the chart.
#DesignerProperty: Key: Rotation, DisplayName: Rotation, FieldType: Int, DefaultValue: 0, Description: Rotates the chart in degrees.

Sub Class_Globals
	Type ChartData (Title As String, Subtitle As String, XAxisName As String, YAxisName As String, Left As Int, Right As Int, Top As Int, Bottom As Int, Width As Int, Height As Int, Rect As B4XRect, YInterval As Int, XInterval As Int, XOffset As Int, BarWidth As Int, ChartType As String, BarSubWidth As Int, IncludeBarMeanLine As Boolean, IncludeValues As Boolean, ChartBackgroundColor As Int, GridFrameColor As Int, GridColor As Int, GridColorDark As Int, XScaleTextOrientation As String, PieGapDegrees As Int, PieAddPerentage As Boolean, GradientColors As Boolean, GradientColorsAlpha As Int, Rotation As Double, DrawOuterFrame As Boolean, IncludeMinLine As Boolean, IncludeMaxLine As Boolean, MinLineColor As Int, MaxLineColor As Int, IncludeMeanLine As Boolean, MeanLineColor As Int, BarValueOrientation As String, Error As Boolean, ErrorText As String, DrawGridFrame As Boolean, DrawHorizontalGridLines As Boolean, DrawVerticalGridLines As Boolean)
	Type PointData (X As String, XArray() As Double, YArray() As Double, ShowTick As Boolean)
	Type ItemData (Name As String, Color As Int, Value As Float, StrokeWidth As Int, DrawLine As Boolean, PointType As String, Filled As Boolean, PointColor As Int, YXArray As List)
	Type ScaleData (Scale As Double, MinVal As Double, MaxVal As Double, MinManu As Double, MaxManu As Double,	IntervalManu As Double, MinAuto As Double, MaxAuto As Double, IntervalAuto As Double, Interval As Double, NbIntervals As Int, Automatic As Boolean, Different As Boolean, Exp As Double, YZeroAxis As Boolean, YZeroAxisHighlight As Boolean, ScaleValues As String, Logarithmic As Boolean, DrawXScale As Boolean, DrawYScale As Boolean)
	Type ScaleDataLog(Scale As Double, MantMin As Int, MantMax As Int, LogMin As Double, LogMinIndex As Int, LogMax As Double, Logs() As Double, Vals() As Double, NbDecades As Int, ScaleValues As String)
	Type TextData (TitleFont As B4XFont, SubtitleFont As B4XFont, AxisFont As B4XFont, ScaleFont As B4XFont, AutomaticTextSizes As Boolean, TitleTextSize As Float, SubtitleTextSize As Float, TitleTextColor As Int, SubtitleTextColor As Int, AxisTextColor As Int, AxisTextSize As Float, ScaleTextSize As Float, ScaleTextColor As Int, TitleTextHeight As Int, SubtitleTextHeight As Int, AxisTextHeight As Int, ScaleTextHeight As Int)
	Type LegendData (IncludeLegend As String, TextFont As B4XFont, TextSize As Float, TextHeight As Int, Height As Int, LineNumber As Int, LineNumbers As List, LineChange As List)
	Type ValuesData (Show As Boolean, TextFont As B4XFont, TextSize As Float, TextColor As Int, TextHeight As Int, Left As Int, Top As Int, Width As Int, Height As Int, MidPont As Int, rectRight As B4XRect, rectCursor As B4XRect, MaxDigits As Int, Position As String)
	Type NumberFormats(MinimumIntegers As Int, MaximumFractions As Int, MinimumFractions As Int, GroupingUsed As Boolean)
	
	Private xui As XUI
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Public xBase As B4XView
	
	Private xcvsGraph As B4XCanvas
	Private xpnlValues As B4XView
	Private xcvsValues As B4XCanvas
	Private xpnlCursor As B4XView
	Private xcvsCursor As B4XCanvas
	Private pthGrid As B4XPath
	
	Private NbMaxDifferentScales = 4 As Int
	Private Scale(NbMaxDifferentScales + 1) As ScaleData
	Private ScaleLog(NbMaxDifferentScales + 1) As ScaleDataLog
	Private sX, sY(NbMaxDifferentScales) As Int
	Private Items As List
	Private Points As List
	Private Graph As ChartData
	Private Texts As TextData
	Private Legend As LegendData
	Private Values As ValuesData
	Private MinMaxMeanValues(3) As Double
	Private BMVNF As NumberFormats		' Bar Mean Value Number Format
	Private BMVNFUsed As Boolean			' True if a custom number format is used
	Private BarWidth0 = False As Boolean
	Private mPiePercentageNbFractions As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	sX = 0
	sY(0) = 1
	sY(1) = 2
	sY(2) = 3
	sY(3) = 4

End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	xBase = Base
	
	xcvsGraph.Initialize(xBase)
	
	Scale(sY(0)).Initialize
	Scale(sY(1)).Initialize
	Scale(sY(2)).Initialize
	Scale(sY(3)).Initialize
	Scale(sX).Initialize
	ScaleLog(sY(0)).Initialize
	ScaleLog(sY(1)).Initialize
	ScaleLog(sX).Initialize
	Items.Initialize
	Points.Initialize
	Graph.Initialize
	Texts.Initialize
	Legend.Initialize
	Values.Initialize
	BMVNF.Initialize		

	Legend.LineNumbers.Initialize
	Legend.LineChange.Initialize
	
	Graph.Title = Props.GetDefault("Title", "")
	Graph.Subtitle = Props.GetDefault("Subtitle", "")
	Graph.XAxisName = Props.GetDefault("XAxisName", "")
	Graph.YAxisName = Props.GetDefault("YAxisName", "")
	For i = 0 To sY.Length - 1
		Scale(sY(i)).MaxManu = Props.GetDefault("YMaxValue", 100)
		Scale(sY(i)).MinManu = Props.GetDefault("YMinValue", 0)
		Scale(sY(i)).NbIntervals = Props.GetDefault("NbYIntervals", 10)
		Scale(sY(i)).YZeroAxis = Props.GetDefault("YZeroAxis", False)
		Scale(sY(i)).YZeroAxisHighlight = Props.GetDefault("YZeroAxisHighlight", True)
		Scale(sY(i)).Automatic = Props.GetDefault("AutomaticScale", True)
		Scale(sY(i)).Different = Props.GetDefault("DifferentScales", False)
		Scale(sY(i)).Logarithmic = Props.GetDefault("LogarithmicYScale", False)
		Scale(sY(i)).ScaleValues = Props.GetDefault("ScaleValues", "1!2!2.5!5!10")
		Scale(sY(i)).DrawYScale = Props.GetDefault("DrawYScale", True)
		ScaleLog(sY(i)).ScaleValues = Props.GetDefault("ScaleYValuesLog", "1!2!5!7!10")
		
	Next
	Scale(sX).MaxManu = Props.GetDefault("XMaxValue", 100)
	Scale(sX).MinManu = Props.GetDefault("XMinValue", 0)
	Scale(sX).NbIntervals = Props.GetDefault("NbXIntervals", 10)
	Scale(sX).Logarithmic = Props.GetDefault("LogarithmicXScale", False)
	Scale(sX).ScaleValues = Props.GetDefault("ScaleValues", "1!2!2.5!5!10")
	Scale(sX).DrawXScale = Props.GetDefault("DrawXScale", True)
	ScaleLog(sX).ScaleValues = Props.GetDefault("ScaleXValuesLog", "1!2!5!7!10")
	Graph.ChartType = Props.Get("ChartType")
	If Graph.ChartType = "YX_CHART" Then
		Scale(sX).Automatic = Props.GetDefault("AutomaticScale", True)
	Else
		Scale(sX).Automatic = False
	End If

	Graph.ChartBackgroundColor = xui.PaintOrColorToColor(Props.Get("ChartBackgroundColor"))
	If Graph.ChartBackgroundColor = 16777215 Then
		Graph.ChartBackgroundColor = xui.Color_Transparent
	End If
	
	Graph.GridFrameColor = xui.PaintOrColorToColor(Props.Get("GridFrameColor"))
	Graph.DrawGridFrame = Props.GetDefault("DrawGridFrame", True)
	Graph.DrawHorizontalGridLines = Props.GetDefault("DrawHorizontalGridLines", True)
	Graph.DrawVerticalGridLines = Props.GetDefault("DrawVerticalGridLines", True)
	Graph.GridColor = xui.PaintOrColorToColor(Props.Get("GridColor"))
	Graph.GridColorDark = CalcDarkColor(Graph.GridColor)
	Graph.GradientColors = Props.GetDefault("GradientColors", True)
	Graph.GradientColorsAlpha = Props.GetDefault("GradientColorsAlpha", 96)
	Texts.TitleTextColor = xui.PaintOrColorToColor(Props.Get("TitleTextColor"))
	Texts.SubtitleTextColor = xui.PaintOrColorToColor(Props.Get("SubtitleTextColor"))
	Texts.ScaleTextColor = xui.PaintOrColorToColor(Props.Get("ScaleTextColor"))
	Texts.AxisTextColor = xui.PaintOrColorToColor(Props.Get("AxisTextColor"))
	Texts.TitleTextSize = Props.GetDefault("TitleTextSize", 18)
	Texts.SubtitleTextSize = Props.GetDefault("SubtitleTextSize", 16)
	Texts.AxisTextSize = Props.GetDefault("AxisTextSize", 14)
	Texts.ScaleTextSize = Props.GetDefault("ScaleTextSize", 12)
	Legend.TextSize = Props.GetDefault("LegendTextSize", 14)
	Texts.AutomaticTextSizes = Props.GetDefault("AutomaticTextSizes", True)
	Graph.XScaleTextOrientation = Props.GetDefault("XScaleTextOrientation", "HORIZONTAL")
	Legend.IncludeLegend = Props.GetDefault("IncludeLegend","NONE")
	Graph.IncludeValues = Props.GetDefault("IncludeValues", False)
	Graph.BarValueOrientation = Props.GetDefault("BarValueOrientation", "HORIZONTAL")
	Graph.PieAddPerentage = Props.GetDefault("PieAddPerentage", True)
	Graph.PieGapDegrees = Props.GetDefault("PieGapDegrees", 0)
	mPiePercentageNbFractions = Props.Get("PiePerentageNbFractions")
	mPiePercentageNbFractions = Max(mPiePercentageNbFractions, 0)
	mPiePercentageNbFractions = Min(mPiePercentageNbFractions, 2)	
	Values.Show = Props.GetDefault("DisplayValues", True)
	Values.Position = Props.GetDefault("ValuesPosition", "TOP_LEFT")
	Values.TextSize = Props.GetDefault("ValuesTextSize", 14)
	Values.TextColor = xui.PaintOrColorToColor(Props.Get("ValuesTextColor"))
	Graph.IncludeBarMeanLine = Props.GetDefault("IncludeBarMeanLine", False)
	Graph.IncludeMinLine = Props.GetDefault("IncludeMinLine", False)
	Graph.IncludeMaxLine = Props.GetDefault("IncludeMaxLine", False)
	Graph.IncludeMeanLine = Props.GetDefault("IncludeMeanLine", False)
	Graph.MinLineColor = xui.PaintOrColorToColor(Props.Get("MinLineColor"))
	Graph.MaxLineColor = xui.PaintOrColorToColor(Props.Get("MaxLineColor"))
	Graph.MeanLineColor = xui.PaintOrColorToColor(Props.Get("MeanLineColor"))
	Graph.DrawOuterFrame = Props.GetDefault("DrawOuterFrame", False)
	xpnlCursor = xui.CreatePanel("xpnlCursor")
	xBase.AddView(xpnlCursor, 0, 0, xBase.Width, xBase.Height)
	xcvsCursor.Initialize(xpnlCursor)
	
	xpnlValues = xui.CreatePanel("xpnlValues")
	xBase.AddView(xpnlValues, 0, 0, 100dip, 100dip)
	xpnlValues.Visible = False
	xcvsValues.Initialize(xpnlValues)
	
	BMVNFUsed = False
	BMVNF.MinimumIntegers = 1
	BMVNF.MaximumFractions = 2
	BMVNF.MinimumFractions = 2
	BMVNF.GroupingUsed = False
End Sub

'resizes the Chart with new Width and Height
Public Sub Base_Resize (Width As Double, Height As Double)
	xcvsGraph.Resize(Width, Height)
	xpnlCursor.Width = Width
	xpnlCursor.Height = Height
	xcvsCursor.Resize(Width, Height)
	Sleep(0)
	If Points.Size > 0 Or Graph.ChartType = "PIE" Then
		DrawChart
	End If
	If Graph.ChartType = "YX_CHART" And Items.Size > 0 Then
		Private i, n As Int
		Private ID As ItemData
		
		For i = 0 To Items.Size - 1
			ID = Items.Get(i)
			If ID.YXArray.Size > 0 Then
				n = 1
			End If
		Next
		If n = 1 Then
			DrawChart
		End If
	End If
End Sub

Private Sub xpnlCursor_Touch (Action As Int, X As Float, Y As Float)
	If Action = 100 Then
		Return
	End If
	
	If Graph.ChartType = "YX_CHART" Then
		If (Action = 0 Or Action = 2) And Action <> 100 And X > Graph.Left And X < Graph.Right And Y > Graph.Top And Y < Graph.Bottom  And xui.SubExists(mCallBack, mEventName & "_Touch", 2) Then
			If xui.SubExists(mCallBack, mEventName & "_Touch", 2) Then
				CallSubDelayed3(mCallBack, mEventName & "_Touch", Scale(sX).MinVal + (X - Graph.Left) / Scale(sX).Scale, Scale(sY(0)).MaxVal - (Y - Graph.Top) / Scale(sY(0)).Scale)	'in screen coordonates
'					CallSubDelayed3(mCallBack, mEventName & "_Touch", X - Graph.Left, Y - Graph.Top)	'in pixels '???
			End If
		End If
	End If
	
	If Values.Show = False Or Graph.ChartType = "PIE" Or Graph.ChartType = "YX_CHART" Then
		'no values shown in a YX_CHART
		Return
	End If
	
	Select Action
		Case 0	'DOWN
			If X > Graph.Left And X < Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				DrawItemValues(X, Y)
				xpnlValues.Visible = True
			End If
		Case 1	'UP
			xpnlValues.Visible = False
			xcvsCursor.ClearRect(Values.rectCursor)
			xcvsCursor.Invalidate
		Case 2	'MOVE
			If xpnlValues.Visible = False Then
				xpnlValues.Visible = True
			End If
			
			If X > Graph.Left And X < Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				DrawItemValues(X, Y)
				If X > Graph.Left And X < Graph.Left + Graph.Width / 2 And (Legend.IncludeLegend = "NON" Or Legend.IncludeLegend = "BOTTOM") Then
					xpnlValues.Left = Graph.Right - xpnlValues.Width
				Else
					xpnlValues.Left = Graph.Left
				End If
			End If
	End Select
End Sub

Private Sub InitValues
	Private r As B4XRect
	Private LineNumber As Int
	
	Values.Left = Graph.Left
	Values.Top = Graph.Top
	Values.MaxDigits = 6
	
	LineNumber = Items.Size + 1
	If Graph.ChartType = "LINE" Then
		Private PD As PointData
		PD = Points.Get(0)
		If PD.YArray.Length = 1 Then
			If Graph.IncludeMinLine = True Then
				LineNumber = LineNumber + 1
			End If
			If Graph.IncludeMaxLine = True Then
				LineNumber = LineNumber + 1
			End If
			If Graph.IncludeMeanLine = True Then
				LineNumber = LineNumber + 1
			End If
		End If
	End If
	Values.Height = Values.TextHeight * 1.3 * (LineNumber + 0.3)
	
	Private ItemWidth As Int
	For Each Item As ItemData In Items
		Private txt As String = Item.Name & " = "
		ItemWidth = Max(ItemWidth, MeasureTextWidth(txt, Values.TextFont))
	Next
	If Graph.ChartType = "STACKED_BAR" Then
		ItemWidth = Max(ItemWidth, MeasureTextWidth("Total = ", Values.TextFont))
		Values.Height = Values.TextHeight * 1.3 * (Items.Size + 2.3)
	End If
	ItemWidth = ItemWidth + 1.8 * Values.TextHeight
	Values.MidPont = ItemWidth - 0.9 * Values.TextHeight
'	Values.MidPont = ItemWidth - 0.52 * Values.TextHeight
	Private ValueWidth = MeasureTextWidth("-1.23456", Values.TextFont) As Int
	For Each pnt As PointData In Points
		Private txt As String = pnt.X
		ValueWidth = Max(ValueWidth, MeasureTextWidth(txt, Values.TextFont))
	Next
	Values.Width = ItemWidth + ValueWidth + 0.75 * Values.TextHeight
	Values.rectRight.Initialize(Values.MidPont, 0, Values.Width, Values.Height)
	Values.rectCursor.Initialize(0, 0, 5dip, xpnlCursor.Height)
	
	xpnlValues.Left = Values.Left
	xpnlValues.Top = Values.Top
	xpnlValues.Width = Values.Width
	If Values.Position = "TOP_RIGHT" Then
		xpnlValues.Left = xBase.Width - Values.Left - Values.Width
	End If
	xpnlValues.Height = Values.Height
	xcvsValues.Resize(Values.Width, Values.Height)
	
	r.Initialize(0, 0, Values.Width, Values.Height)
	xcvsValues.ClearRect(r)
	xcvsValues.DrawRect(r, 0xAAFFFFFF, True, 0)
	
	Private h, i, x, y As Int
	h = Values.TextHeight * 1.3
	x = Values.MidPont
	y = 1.2 * Values.TextHeight
	xcvsValues.DrawText("x = ", x, y + 0.2 * h, Values.TextFont, Values.TextColor, "RIGHT")
	i = 1
	Private top As Int
	For Each Item As ItemData In Items
		top = y + h * i
		Private txt As String = Item.Name & " = "
		xcvsValues.DrawText(txt, x, top + 0.2 * h, Values.TextFont, Item.Color, "RIGHT")
		i = i + 1
	Next
	
	If Graph.ChartType = "LINE" And Graph.IncludeMinLine = True Then
		If  Graph.IncludeMaxLine = True Then
			top = top + h
			xcvsValues.DrawText("max = ", x, top + 0.2 * h, Values.TextFont, Graph.MaxLineColor, "RIGHT")
		End If
		If  Graph.IncludeMeanLine = True Then
			top = top + h
			xcvsValues.DrawText("mean = ", x, top + 0.2 * h, Values.TextFont, Graph.MeanLineColor, "RIGHT")
		End If
		If  Graph.IncludeMinLine = True Then
			top = top + h
			xcvsValues.DrawText("min = ", x, top + 0.2 * h, Values.TextFont, Graph.MinLineColor, "RIGHT")
		End If
	End If
	
	If Graph.ChartType = "STACKED_BAR" Then
		Private top As Int = y + h * i
		Private txt As String = "Total = "
		xcvsValues.DrawText(txt, x, top + 0.2 * h, Values.TextFont, Values.TextColor, "RIGHT")
	End If
	
	xcvsValues.Invalidate
End Sub

'makes a color darker
Private Sub CalcDarkColor(Color As Int) As Int
	Private BmpCreate As BitmapCreator
	Private ARGBCol As ARGBColor
	
	BmpCreate.Initialize(1, 1)
	BmpCreate.ColorToARGB(Color, ARGBCol)
	ARGBCol.r = ARGBCol.r / 2
	ARGBCol.g = ARGBCol.g / 2
	ARGBCol.b = ARGBCol.b / 2
	
	Return BmpCreate.ARGBToColor(ARGBCol)
End Sub

'draws item values in a specific area, not for pie charts
Private Sub DrawItemValues(x As Int, y As Int)
	If Graph.ChartType <> "PIE" Then
		Private Index As Int
		xcvsValues.ClearRect(Values.rectRight)
		xcvsCursor.ClearRect(Values.rectCursor)
		xcvsValues.DrawRect(Values.rectRight, 0xAAFFFFFF, True, 0)
		Select Graph.ChartType
			Case "BAR", "STACKED_BAR"
				Index =(x - Graph.Left) / Graph.XInterval
			Case "LINE"
				Index = (x - Graph.Left) / Scale(sX).Scale + 0.5
		End Select
		Index = Min(Index, Points.Size - 1)
		Private Point As PointData
		Point = Points.Get(Index)
		Private h, i, x, y As Int
		h = Values.TextHeight * 1.3
		x = Values.MidPont
		y = 1.2 * Values.TextHeight
		xcvsValues.DrawText(Point.X, x, y + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
		Private Total = 0 As Double
		Private top As Int
		For i = 0 To Point.YArray.Length - 1
			top = y + h * (i + 1)
			xcvsValues.DrawText(NumberFormat3(Point.YArray(i), Values.MaxDigits), x, top + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
			Total = Total + Point.YArray(i)
		Next
		If Graph.ChartType = "STACKED_BAR" Then
			top = y + h * (i + 1)
			xcvsValues.DrawText(NumberFormat3(Total, Values.MaxDigits), x, top + 0.2 * h, Values.TextFont, xui.Color_Black, "LEFT")
		End If
		
		If Graph.ChartType = "LINE" And Point.YArray.Length = 1 Then
			top = top + 0.2 * h
			If Graph.IncludeMaxLine = True Then
				top = top + h
				xcvsValues.DrawText(NumberFormat3(MinMaxMeanValues(1), Values.MaxDigits), x, top, Values.TextFont, xui.Color_Black, "LEFT")
			End If
			If Graph.IncludeMeanLine = True Then
				top = top + h
				xcvsValues.DrawText(NumberFormat3(MinMaxMeanValues(2), Values.MaxDigits), x, top, Values.TextFont, xui.Color_Black, "LEFT")
			End If
			If Graph.IncludeMinLine = True Then
				top = top + h
				xcvsValues.DrawText(NumberFormat3(MinMaxMeanValues(0), Values.MaxDigits), x, top, Values.TextFont, xui.Color_Black, "LEFT")
			End If
		End If
		
		Private xCursor As Int
		Select Graph.ChartType
			Case "BAR", "STACKED_BAR"
				xCursor = (Index + 0.5) * Graph.XInterval + Graph.Left + Graph.XOffset
			Case "LINE"
				xCursor = Index * Scale(sX).Scale + Graph.Left 
		End Select		
		xcvsCursor.DrawLine(xCursor, Graph.Top, xCursor, Graph.Bottom, xui.Color_Red, 2dip)
		Values.rectCursor.Initialize(xCursor - 2dip, 0, xCursor + 2dip, xpnlCursor.Height)
		xcvsValues.Invalidate
		xcvsCursor.Invalidate
	End If
End Sub

'adds a bar
'only for Bar and StackedBar charts !
Public Sub AddBar(Name As String, BarColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	
	Private ID As ItemData
	ID.Initialize
	ID.Name = Name
	ID.Color = BarColor
	Items.Add(ID)
End Sub

'adds multibar points data
'only for Bar and StackedBar charts !
Public Sub AddBarMultiplePoint (X As String, YArray() As Double)
	If Points.IsInitialized = False Then
		Points.Initialize
	End If
	Dim PD As PointData
	PD.Initialize
	PD.X = X
	PD.YArray = YArray
	PD.ShowTick = True
	Points.Add(PD)
End Sub

'adds single bar point data
'only for Bar charts !
Public Sub AddBarPointData (X As String, Y As Double)
	If Points.IsInitialized = False Then
		Points.Initialize
	End If
	Dim PD As PointData
	PD.Initialize
	PD.X = X
	Private YArray(1) As Double
	YArray(0) = Y
	PD.YArray = YArray
	PD.ShowTick = True
	Points.Add(PD)
End Sub

'adds a line
'only for Line charts !
Public Sub AddLine(Name As String, LineColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	
	Dim ID As ItemData
	ID.Initialize
	ID.Name = Name
	ID.Color = LineColor
	ID.StrokeWidth = 2dip
	ID.PointType = "NONE"
	ID.Filled = False
	Items.Add(ID)
End Sub

'adds a line
'StrokeWidth = line thickness
'PointType, possible values: "NONE", "CIRCLE", "SQUARE", "TRIANGLE", "RHOMBUS", "CROSS+", "CROSSX"
'only for Line charts !
Public Sub AddLine2(Name As String, LineColor As Int, StrokeWidth As Int, PointType As String, Filled As Boolean, PointColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	
	Dim ID As ItemData
	ID.Initialize
	ID.Name = Name
	ID.Color = LineColor
	ID.StrokeWidth = StrokeWidth
	ID.PointType = PointType
	ID.Filled = Filled
	ID.PointColor = PointColor
	Items.Add(ID)
End Sub

'adds multiline points data
'ShowTick = True displays the x value in the X axis
'only for Line charts !
Public Sub AddLineMultiplePoints(X As String, YArray() As Double, ShowTick As Boolean)
	If Points.IsInitialized = False Then Points.Initialize
	Private PD As PointData
	PD.Initialize
	PD.X = X
	PD.YArray = YArray
	PD.ShowTick = ShowTick
	Points.Add(PD)
	If xpnlValues.Visible = True Then
		xpnlValues.Visible = False
		xcvsCursor.ClearRect(Values.rectCursor)
		xcvsCursor.Invalidate
	End If
End Sub

'adds single line point data
'ShowTick = True displays the x value in the X axis
'only for Line charts !
Public Sub AddLinePointData (X As String, Y As Double, ShowTick As Boolean)
	If Points.IsInitialized = False Then Points.Initialize
	Dim PD As PointData
	PD.Initialize
	PD.X = X
	Private YArray(1) As Double
	YArray(0) = Y
	PD.YArray = YArray
	PD.ShowTick = ShowTick
	Points.Add(PD)
	If xpnlValues.Visible = True Then
		xpnlValues.Visible = False
		xcvsCursor.ClearRect(Values.rectCursor)
		xcvsCursor.Invalidate
	End If
End Sub

'Adds a pie slice item
'Color: 0 = random color
'only for Pie charts !
Public Sub AddPie(Name As String, Value As Float, Color As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If Color = 0 Then Color = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	Dim ID As ItemData
	ID.Initialize
	ID.Name = Name
	ID.Value = Value
	ID.Color = Color
	Items.Add(ID)
End Sub

'adds a YXLine
'only for YXCharts !
Public Sub AddYXLine(Name As String, LineColor As Int, StrokeWidth As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	
	Dim ID As ItemData
	ID.Initialize
	ID.Name = Name
	ID.Color = LineColor
	ID.StrokeWidth = StrokeWidth
	ID.DrawLine = True
	ID.PointType = "NONE"
	ID.Filled = False
	ID.YXArray.Initialize
	Items.Add(ID)
End Sub

'adds a YX line
'StrokeWidth = line thickness
'DrawLine = False allows to draw only the points
'PointType, possible values: "NONE", "CIRCLE", "SQUARE", "TRIANGLE", "RHOMBUS", "CROSS+", "CROSSX"
'Filled = False empty points, True = filled points
'only for YXCharts !
Public Sub AddYXLine2(Name As String, LineColor As Int, StrokeWidth As Int, DrawLine As Boolean, PointType As String, Filled As Boolean, PointColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	
	Dim ID As ItemData
	ID.Initialize
	ID.Name = Name
	ID.Color = LineColor
	ID.StrokeWidth = StrokeWidth
	ID.DrawLine = DrawLine
	ID.PointType = PointType
	ID.Filled = Filled
	ID.PointColor = PointColor
	ID.YXArray.Initialize
	If DrawLine = False Then
		ID.Color = ID.PointColor
	End If
	Items.Add(ID)
End Sub

'adds a point in the given lines
Public Sub AddYXPoint(LineIndex As Int, X As Double, Y As Double)
	If LineIndex < 0 Or LineIndex > Items.Size Then
		Log("Index out of range")
		Return
	End If
	
	Private ID As ItemData
	Private YX(2) As Double
	YX(0) = X
	YX(1) = Y
	ID = Items.Get(LineIndex)
	If ID.YXArray.IsInitialized = False Then
		ID.YXArray.Initialize
	End If
	ID.YXArray.Add(YX)
End Sub

'initializes different parameters for a chart
Private Sub InitChart
	If Texts.AutomaticTextSizes = True Then
		Private GraphSize As Int
		GraphSize = Min(xcvsGraph.TargetRect.Width, xcvsGraph.TargetRect.Height) / xui.Scale
		Texts.TitleTextSize = (1 + (GraphSize - 250)/1000) * 18
		Texts.SubtitleTextSize = (1 + (GraphSize - 250)/1000) * 16
		Texts.AxisTextSize = (1 + (GraphSize - 250)/1000) * 14
		Legend.TextSize = (1 + (GraphSize - 250)/1000) * 14
		Texts.ScaleTextSize = (1 + (GraphSize - 250)/1000) * 12
		Values.TextSize = (1 + (GraphSize - 250)/1000) * 14
	End If

	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.SubtitleFont = xui.CreateDefaultFont(Texts.SubtitleTextSize)
	Texts.AxisFont = xui.CreateDefaultFont(Texts.AxisTextSize)
	Texts.ScaleFont = xui.CreateDefaultFont(Texts.ScaleTextSize)
	Legend.TextFont = xui.CreateDefaultFont(Legend.TextSize)
	Values.TextFont = xui.CreateDefaultFont(Values.TextSize)
	
	Texts.TitleTextHeight = MeasureTextHeight("Mg", Texts.TitleFont)
	Texts.SubtitleTextHeight = MeasureTextHeight("Mg", Texts.SubtitleFont)
	Texts.AxisTextHeight =  MeasureTextHeight("Mg", Texts.AxisFont)
	Texts.ScaleTextHeight =  MeasureTextHeight("Mg", Texts.ScaleFont)
	Legend.TextHeight =  MeasureTextHeight("Mg", Legend.TextFont)
	Values.TextHeight = MeasureTextHeight("Mg", Values.TextFont)
	
	Graph.Error = False
	Graph.ErrorText = ""
	
	If Graph.ChartType = "PIE" Then
		Graph.Height = xcvsGraph.TargetRect.Height
		If Legend.IncludeLegend = "BOTTOM" And Items.Size > 0 Then
			GetLegendLineNumbers(xcvsGraph.TargetRect.Width - 1.2 * Legend.TextHeight)
			Legend.Height = (Legend.LineNumber + 0.2) * 1.5 * Legend.TextHeight
			Graph.Height = Graph.Height - Legend.Height - 0.75 * Legend.TextHeight
		End If
		Return
	End If
	
	If Graph.ChartType = "YX_CHART" Then
		Private ID As ItemData
		ID = Items.Get(0)
		If ID.YXArray.Size = 0 Then
			Graph.Error = True
			Graph.ErrorText = "No data"
			Return
		End If
	Else
		If Points.Size = 0 Then
			Graph.Error = True
			Graph.ErrorText = "No data"
			Return
		End If
	End If
	
	If (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
		For i = 0 To Items.Size - 1
			CalcScaleAuto(sY(i))
		Next
	Else
		If Scale(sY(0)).Logarithmic = True And (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") Then
			If Scale(sY(0)).Automatic = True Then
				CalcScaleLogAuto(sY(0))
			Else
				CalcScaleLogManu(sY(0))
			End If
		Else
			If Scale(sY(0)).Automatic = True Then
				CalcScaleAuto(sY(0))
			Else
				CalcScaleManu(sY(0))
			End If
		End If
	End If
	
	If Graph.ChartType = "YX_CHART" Then
		If Scale(sX).Logarithmic = True Then
			If Scale(sX).Automatic = True Then
				CalcScaleLogAuto(sX)
			Else
				CalcScaleLogManu(sX)
			End If
		Else
			If Scale(sX).Automatic = True Then
				CalcScaleAuto(sX)
			Else
				CalcScaleManu(sX)
			End If
		End If
	End If
	
	If Scale(sY(0)).DrawYScale = False Then
		Graph.Left = 0.75 * Texts.AxisTextHeight
	Else
		If (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
			Private Width As Int
			For i = 0 To NbMaxDifferentScales - 1 Step 2
				Width = Max(Width, GetYScaleWidth(i))
			Next
			Graph.Left = Width + 1.05 * Texts.ScaleTextHeight
		Else
			Graph.Left = GetYScaleWidth(0) + 1.05 * Texts.ScaleTextHeight
		End If
	End If

	If Graph.YAxisName <> "" Then
		Graph.Left = Graph.Left + Texts.AxisTextHeight * 1.8
	End If
	
	If Scale(sY(0)).DrawYScale = False Then
		Graph.Right = xcvsGraph.TargetRect.Width - 0.75 * Texts.ScaleTextHeight
	Else
		If (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
			Graph.Right = xcvsGraph.TargetRect.Width - 1.5 * Texts.ScaleTextHeight - GetYScaleWidth(1)
			Private Width As Int
			For i = 1 To NbMaxDifferentScales - 1 Step 2
				Width = Max(Width, GetYScaleWidth(i))
			Next
			Graph.Right = xcvsGraph.TargetRect.Width - Width - 1.5 * Texts.ScaleTextHeight
		Else
			Graph.Right = xcvsGraph.TargetRect.Width - 1.5 * Texts.ScaleTextHeight
		End If
	End If

	Graph.Width = Graph.Right - Graph.Left

	If Graph.ChartType = "YX_CHART" Then
		Graph.Width = Floor(Graph.Width / Scale(sX).NbIntervals) * Scale(sX).NbIntervals
		Graph.Right = Graph.Left + Graph.Width
		Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
		Scale(sX).Scale = Graph.Width / (Scale(sX).MaxVal - Scale(sX).MinVal)
	Else
		If (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
			For i = 0 To Items.Size - 1
				Scale(sY(i)).Scale = Graph.Height / (Scale(sY(i)).MaxVal - Scale(sY(i)).MinVal)
			Next
		Else
			Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
		End If
		Scale(sX).Scale = Graph.Width / (Scale(sX).MaxVal - Scale(sX).MinVal)
	End If

	If Graph.ChartType = "BAR" Or Graph.ChartType = "STACKED_BAR" Then
		BarWidth0 = False
		Private PD As PointData = Points.Get(0)
		Private Margin = 0.02 * xcvsGraph.TargetRect.Width As Int
		Graph.XInterval = (Graph.Width - Margin) / Points.Size
		
		Private Space As Int
		If Graph.ChartType = "BAR" And Items.Size = 1 And Points.Size <= 7 Then
			Private SpaceRatio As Double
			Select Points.Size
				Case 1
					SpaceRatio = 1
				Case 2
					SpaceRatio = 0.85
				Case 3
					SpaceRatio = 0.75
				Case 4
					SpaceRatio = 0.6
				Case 5
					SpaceRatio = 0.5
				Case 6
					SpaceRatio = 0.4
				Case 7
					SpaceRatio = 0.3
			End Select
			Space = Graph.XInterval - xcvsGraph.TargetRect.Width / ((1 + SpaceRatio) * Points.Size + 2 * SpaceRatio)
		Else
			Space = Margin
		End If
		
		'checks id space is too big
'		If Space > 0.3 * Graph.XInterval Then
'			Space = 0.3 * Graph.XInterval
'			Graph.XInterval = (Graph.Width - Space) / Points.Size
'		End If
	
		Private Limit As Int
		If Graph.ChartType = "BAR" Then
			Limit = 4dip * PD.YArray.Length
		Else
			Limit = 4dip
		End If
	
'		If Graph.XInterval < 5dip Then
'		If Graph.XInterval - Space < 4dip * PD.YArray.Length Then
		If Graph.XInterval - Space < Limit Then
			Log("Bar width = too small !!! Drawing of Bar chart skipped")
			BarWidth0 = True
		End If
		
		Graph.XOffset = (Graph.Width - Graph.XInterval * Points.Size) / 2
		Graph.BarWidth = Graph.XInterval - Space
		Graph.BarSubWidth = Graph.BarWidth / PD.YArray.Length
		
		If Graph.ChartType = "BAR" Then
			'checks if Graph.BarSubWidth too small < 4dip
			If Graph.BarSubWidth < 4dip And BarWidth0 = False Then
				Log("Bar width = too small !!! Drawing of Bar chart skipped")
				BarWidth0 = True
			End If
		End If
	End If
	
	If Graph.Title <> "" Then
		Graph.Top = 1.8 * Texts.TitleTextHeight
	Else
		Graph.Top = 0.9 * Texts.TitleTextHeight
	End If
	
	If Graph.Subtitle <> "" Then
		Graph.Top = Graph.Top + 1.5 * Texts.SubtitleTextHeight
	End If
	
	If Scale(sX).DrawXScale = False Then
		Graph.Height = xcvsGraph.TargetRect.Height - Graph.Top - 0.2 * Texts.ScaleTextHeight
	Else
		Select Graph.XScaleTextOrientation
			Case "HORIZONTAL"
				Graph.Height = xcvsGraph.TargetRect.Height - Graph.Top - 2.1 * Texts.ScaleTextHeight
			Case "VERTICAL"
				Graph.Height = xcvsGraph.TargetRect.Height - Graph.Top - 0.9 * Texts.ScaleTextHeight - GetXScaleWidth
			Case "45 DEGREES"
				Graph.Height = xcvsGraph.TargetRect.Height - Graph.Top - 0.9 * Texts.ScaleTextHeight - GetXScaleWidth * 0.8
		End Select
	End If
	If Graph.XAxisName <> "" Then
		Graph.Height = Graph.Height - 1.3 * Texts.AxisTextHeight
	End If
	
	If Legend.IncludeLegend = "BOTTOM" And Items.Size > 0 Then
		GetLegendLineNumbers(xcvsGraph.TargetRect.Width - 1.2 * Legend.TextHeight)
		Legend.Height = (Legend.LineNumber + 0.2) * 1.5 * Legend.TextHeight
		Graph.Height = Graph.Height - Legend.Height - 0.75 * Legend.TextHeight
	End If
	
	Graph.YInterval = Graph.Height / Scale(sY(0)).NbIntervals
	Graph.Height =  Graph.YInterval * Scale(sY(0)).NbIntervals
	Graph.Bottom = Graph.Top + Graph.Height
	Graph.Rect.Initialize(Graph.Left, Graph.Top, Graph.Right, Graph.Bottom)
	
	'used to avoid drawing lines outsides the grid
	pthGrid.Initialize(Graph.Left, Graph.Top)
	pthGrid.LineTo(Graph.Right, Graph.Top)
	pthGrid.LineTo(Graph.Right, Graph.Bottom)
	pthGrid.LineTo(Graph.Left, Graph.Bottom)
	pthGrid.LineTo(Graph.Left, Graph.Top)
	
	InitValues
End Sub

'Calculates manual scales
Private Sub CalcScaleManu(Index As Int)
	Private ValMinMax(3) As Double

	Select Graph.ChartType
		Case "LINE", "YX_CHART"
			ValMinMax = GetLinePointsMinMaxMeanValues(sY(0))
			If Scale(sY(0)).YZeroAxis = True And ValMinMax(0) >= 0 And ValMinMax(1) > 0 Then
				ValMinMax(0) = 0
			End If
			If Scale(sY(0)).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) <= 0 Then
				ValMinMax(1) = 0
			End If
		Case Else
			ValMinMax = GetBarPointsMinMaxValues
	End Select
		
	Scale(Index).MaxVal = Scale(Index).MaxManu
	Scale(Index).MinVal = Scale(Index).MinManu
	Scale(Index).IntervalManu = (Scale(Index).MaxVal - Scale(Index).MinVal) / Scale(Index).NbIntervals
	Scale(Index).Interval = Scale(Index).IntervalManu
	Scale(Index).Exp = Floor(Logarithm((Scale(Index).MaxVal - Scale(Index).MinVal) / Scale(Index).NbIntervals, 10))
	If Index = sY(0) Then
		Scale(Index).Scale = Graph.Height / (Scale(Index).MaxVal - Scale(Index).MinVal)
	Else
		Scale(Index).Scale = Graph.Width / (Scale(Index).MaxVal - Scale(Index).MinVal)
	End If
End Sub

'Calculates automatic scales, with 1, 2, 2.5, 5 standardized scales
Private Sub CalcScaleAuto(Axis As Int)
	Private ScaleLogarithm, ScaleMant, ScaleDelta, ValDiff, ScaleMin, ScaleMax, ValMax As Double
'	Private Log1, Log12, Log15, Log18, Log2, Log25, Log3, Log4, Log5, Log6, Log7, Log8, Log9, Log10 As Double
	Private nbMin, NbUsedIntervals, NbUsedIntervalsTop, NbUsedIntervalsBottom, NbIntervalsToMove As Int
	Private ValMinMax(3) As Double
	
	Select Graph.ChartType
		Case "LINE", "YX_CHART"
			ValMinMax = GetLinePointsMinMaxMeanValues(Axis)
			If Scale(Axis).YZeroAxis = True And ValMinMax(0) >= 0 And ValMinMax(1) > 0 Then
				ValMinMax(0) = 0
			End If
			If Scale(Axis).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) <= 0 Then
				ValMinMax(1) = 0
			End If
		Case Else
			ValMinMax = GetBarPointsMinMaxValues
	End Select
	
	'check if min = max then unit scale
	If ValMinMax(0) = ValMinMax(1) Then
		If ValMinMax(0) >= 0 And ValMinMax(0) <= 1 Then
			Scale(Axis).MinAuto = 0
			Scale(Axis).MaxAuto = 1
			Scale(Axis).IntervalAuto = 1 / Scale(Axis).NbIntervals
			Scale(Axis).MinVal = Scale(Axis).MinAuto
			Scale(Axis).MaxVal = Scale(Axis).MaxAuto
			Scale(Axis).Interval = Scale(Axis).IntervalAuto
			Return
		Else If ValMinMax(0) < 0 And ValMinMax(0) >= -1 Then
			Scale(Axis).MinAuto = -1
			Scale(Axis).MaxAuto = 0
			Scale(Axis).IntervalAuto = 1 / Scale(Axis).NbIntervals
			Scale(Axis).MinVal = Scale(Axis).MinAuto
			Scale(Axis).MaxVal = Scale(Axis).MaxAuto
			Scale(Axis).Interval = Scale(Axis).IntervalAuto
			Return
		Else
			If Scale(Axis).YZeroAxis = False Then
				If Abs(ValMinMax(0)) < 100 Then
					Scale(Axis).IntervalAuto = 0.1
				Else
					Scale(Axis).IntervalAuto = 1
				End If
				Scale(Axis).MinAuto = Floor(ValMinMax(0)) - Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals / 2
				Scale(Axis).MaxAuto = Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
				Scale(Axis).MinVal = Scale(Axis).MinAuto
				Scale(Axis).MaxVal = Scale(Axis).MaxAuto
				Scale(Axis).Interval = Scale(Axis).IntervalAuto
				If Axis = sX Then
					Scale(Axis).Scale = Graph.Width / (Scale(Axis).MaxVal - Scale(Axis).MinVal)
				Else
					Scale(Axis).Scale = Graph.Height / (Scale(Axis).MaxVal - Scale(Axis).MinVal)
				End If
				Return
			Else
				If ValMinMax(0) > 0 Then
					ValMinMax(0) = 0
				Else
					ValMinMax(1) = 0
				End If
			End If
		End If
		Scale(Axis).MinVal = Scale(Axis).MinAuto
		Scale(Axis).MaxVal = Scale(Axis).MaxAuto
		Scale(Axis).Interval = Scale(Axis).IntervalAuto
		Return
	End If
	
	Private ScaleOK As Boolean = False
	ValMax = ValMinMax(1)
	Do Until ScaleOK = True
		ValDiff = ValMax - ValMinMax(0)
		ScaleDelta = ValDiff / Scale(Axis).NbIntervals
	
		ScaleLogarithm = Logarithm(ScaleDelta, 10)
		Scale(Axis).Exp = Floor(ScaleLogarithm)
		If ValDiff >= 1 Then
			ScaleMant = ScaleLogarithm - Scale(Axis).Exp
		Else
			ScaleMant = Abs(Scale(Axis).Exp) + ScaleLogarithm
		End If
		
		ScaleMant = GetScaleMant(ScaleMant, Axis)
		Scale(Axis).IntervalAuto = Power(10, Scale(Axis).Exp + ScaleMant)
		
		If Scale(Axis).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) = 0 Then
			ScaleMax = 0
			ScaleMin = -Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
		Else
			ScaleMin = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto + 0.00000000000001) * Scale(Axis).IntervalAuto
			ScaleMax = ScaleMin + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
		End If
		
		' check if the top scale is below the max value
		If Round2(ScaleMax, 14) < Round2(ValMinMax(1), 14) Then
			ValMax = ValMax + Scale(Axis).IntervalAuto
		Else
			ScaleOK = True
		End If
	Loop
	
	' check if the scale interval is OK
	If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
		NbUsedIntervalsTop = Ceil(ValMinMax(1) / Scale(Axis).IntervalAuto - 0.00000000000001)
		NbUsedIntervalsBottom = Ceil(Abs(ValMinMax(0)) / Scale(Axis).IntervalAuto - 0.00000000000001)
		' check if there are more necessary intervals than available
		If NbUsedIntervalsTop + NbUsedIntervalsBottom > Scale(Axis).NbIntervals Then
'			' if yes increase the scale interval
			ScaleMant = GetScaleMant(ScaleMant, Axis)
		
			Scale(Axis).IntervalAuto = Power(10, Scale(Axis).Exp + ScaleMant)
		End If
	End If
	
	' calculate the scale min value
	If Scale(Axis).YZeroAxis = True And ValMinMax(1) = 0 Then
		Scale(Axis).MinAuto = ScaleMin
		Scale(Axis).MaxAuto = 0
	Else
		nbMin = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto)
		If Abs(ValMinMax(0)) <= 0.000000000001 Then
			Scale(Axis).MinAuto = 0
		Else If ValMinMax(0) >= 0 Then
			Scale(Axis).MinAuto = nbMin * Scale(Axis).IntervalAuto
		Else If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
			Scale(Axis).MinAuto = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto + 0.00000000000001) * Scale(Axis).IntervalAuto
		Else
			Scale(Axis).MinAuto = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto + 0.00000000000001) * Scale(Axis).IntervalAuto
		End If
	End If
	
	' distribution of empty intervals
'	If Abs(Scale(Axis).MinAuto) > 0.0000000000001 Then
'	If Abs(Scale(Axis).MinAuto) >= 0 Then
'	If Abs(Scale(Axis).MinAuto) >= 0 And Scale(Axis).YZeroAxis = False Then
'	If Abs(Scale(Axis).MinAuto) >= 0 And Scale(Axis).YZeroAxis = False Or Scale(Axis).MinAuto <= 0 And Scale(Axis).MaxAuto >= 0 Then
'	If Abs(Scale(Axis).MinAuto) >= 0 And Scale(Axis).YZeroAxis = False Or Scale(Axis).MinAuto < 0 And Scale(Axis).MaxAuto >= 0 Then
	If (Scale(Axis).MinAuto >= 0 And Scale(Axis).YZeroAxis = False) Or (Scale(Axis).MaxAuto <= 0 And Scale(Axis).YZeroAxis = False) Or (Scale(Axis).MinAuto < 0 And Scale(Axis).MaxAuto > 0) Then
		If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
			NbUsedIntervalsTop = Ceil(ValMinMax(1) / Scale(Axis).IntervalAuto - 0.00000000000001)
			NbUsedIntervalsBottom = Ceil(Abs(ValMinMax(0)) / Scale(Axis).IntervalAuto - 0.00000000000001)
			NbUsedIntervals = NbUsedIntervalsTop + NbUsedIntervalsBottom
			If NbUsedIntervalsTop - NbUsedIntervalsBottom = 1 Then
				NbIntervalsToMove = Scale(Axis).NbIntervals / 2 - NbUsedIntervalsBottom
			Else
				NbIntervalsToMove = (Scale(Axis).NbIntervals - NbUsedIntervals) / 2
			End If
		Else
			NbUsedIntervals = Ceil(ValDiff / Scale(Axis).IntervalAuto - 0.00000000000001)
			NbIntervalsToMove = (Scale(Axis).NbIntervals - NbUsedIntervals) / 2
		End If
		Scale(Axis).MinAuto = Scale(Axis).MinAuto - Scale(Axis).IntervalAuto * NbIntervalsToMove
	End If
	
	If Graph.ChartType = "BAR" Then
		'if all values are > 0 and the min scale is < 0 then min scale is set to 0
		If 	ValMinMax(0) = 0 And ValMinMax(1) > 0 And Scale(Axis).MinAuto < 0 Then
			Scale(Axis).MinAuto = 0
		End If
		
		'if all values are < 0 and the max scale is > 0 then max scale is set to 0
		If 	ValMinMax(0) < 0 And ValMinMax(1) = 0 And Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals > 0 Then
			Scale(Axis).MinAuto = - Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
		End If
	End If
	
	' calculate the scale max value
	Scale(Axis).MaxAuto = Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
	
	Scale(Axis).MinVal = Scale(Axis).MinAuto
	Scale(Axis).MaxVal = Scale(Axis).MaxAuto
	Scale(Axis).Interval = Scale(Axis).IntervalAuto
End Sub

'calculates the Logs and Value for linear scales according to the ScaleLog(Axis).ScaleValues string
Private Sub ScaleLogVals(Axis As Int)
	Private Scales() As String
	Scales = Regex.Split("!", Scale(Axis).ScaleValues)
	Private Vals(Scales.Length), Logs(Scales.Length) As Double
	For i = 0 To Scales.Length - 1
		Vals(i) = Scales(i)
		Logs(i) = Logarithm(Vals(i), 10)
	Next
	ScaleLog(Axis).Logs = Logs
	ScaleLog(Axis).Vals = Vals
End Sub

'calculates the Logs and Value for logarithmic scales according to the ScaleLog(Axis).ScaleValues string
Private Sub ScaleLogLogVals(Axis As Int)
	Private Scales() As String
	Scales = Regex.Split("!", ScaleLog(Axis).ScaleValues)
	Private Vals(Scales.Length), Logs(Scales.Length) As Double
	For i = 0 To Scales.Length - 1
		Vals(i) = Scales(i)
		Logs(i) = Logarithm(Vals(i), 10)
	Next
	ScaleLog(Axis).Logs = Logs
	ScaleLog(Axis).Vals = Vals
End Sub

'Calculates manual scales
Private Sub CalcScaleLogManu(Axis As Int)
	Private ValLog As Double
	
	ScaleLogLogVals(Axis)
	
	ValLog = Logarithm(Scale(Axis).MaxManu, 10)
	ScaleLog(Axis).MantMax = Floor(ValLog)
	ScaleLog(Axis).LogMax = ValLog - ScaleLog(Axis).MantMax
	ValLog = Logarithm(Scale(Axis).MinManu, 10)
	ScaleLog(Axis).MantMin = Floor(ValLog)
	ScaleLog(Axis).LogMin = ValLog - ScaleLog(Axis).MantMin
	
	For i = 0 To ScaleLog(Axis).Logs.Length - 2
		If Round2(ScaleLog(Axis).LogMin, 14) >= Round2(ScaleLog(Axis).Logs(i), 14) And Round2(ScaleLog(Axis).LogMin, 14) < Round2(ScaleLog(Axis).Logs(i + 1), 14) Then
			ScaleLog(Axis).LogMin = ScaleLog(Axis).Logs(i)
			ScaleLog(Axis).LogMinIndex = i
			Exit
		End If
	Next
	
	If Axis = sX Then
		ScaleLog(Axis).Scale = Graph.Width / (ScaleLog(Axis).MantMax + ScaleLog(Axis).LogMax - ScaleLog(Axis).MantMin - ScaleLog(Axis).LogMin)
	Else
		ScaleLog(Axis).Scale = Graph.Height / (ScaleLog(Axis).MantMax + ScaleLog(Axis).LogMax - ScaleLog(Axis).MantMin - ScaleLog(Axis).LogMin)
	End If
End Sub

Private Sub CalcScaleLogAuto(Axis As Int)
	If Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART" Then
		Private ValMinMax(3) As Double
		ValMinMax = GetLinePointsMinMaxMeanValues(Axis)
	Else If Graph.ChartType = "BAR" Then
		Private ValMinMax(2) As Double
		ValMinMax = GetBarPointsMinMaxValues
	End If
	
	If ValMinMax(0) <= 0 Then
		Graph.Error = True
		Graph.ErrorText = "Logarithmic scales with values" & "less or equal to zero is not allowed !"
		Return
	End If
	
	If ValMinMax(0) = ValMinMax(1) Then
		If ValMinMax(0) = 0 Then
			ScaleLog(Axis).MantMin = 0
			ScaleLog(Axis).MantMax = 1
			ScaleLog(Axis).NbDecades = 1
			Scale(Axis).MinVal = 1
			Scale(Axis).MaxVal = 10
			Scale(Axis).Interval = 1
			Graph.Error = True
			Graph.ErrorText = "Min and max values = " & ValMinMax(0) & " are the same !"
			Return
		End If
	End If
	
	ScaleLogLogVals(Axis)
	
	Private ValMaxMant, ValMinMant, ValMaxLog, ValMinLog As Double
	ValMinLog = Logarithm(ValMinMax(0), 10)
	ValMaxLog = Logarithm(ValMinMax(1), 10)
	ValMinMant = Floor(ValMinLog)
	ValMaxMant = Floor(ValMaxLog)
	ValMinLog = ValMinLog - ValMinMant
	ValMaxLog = ValMaxLog - ValMaxMant
	
	ScaleLog(Axis).MantMin = ValMinMant
	For i = 0 To ScaleLog(Axis).Logs.Length - 2
		If ValMinLog >= ScaleLog(Axis).Logs(i) And ValMinLog < ScaleLog(Axis).Logs(i + 1) Then
			ScaleLog(Axis).LogMin = ScaleLog(Axis).Logs(i)
			ScaleLog(Axis).LogMinIndex = i
			Exit
		End If
	Next
	
	ScaleLog(Axis).MantMax = ValMaxMant
	ScaleLog(Axis).LogMax = ValMaxLog
	If ScaleLog(Axis).LogMax <> Abs(0.000000000001) Then
		For i = 0 To ScaleLog(Axis).Logs.Length - 2
			If ValMaxLog > ScaleLog(Axis).Logs(i) And ValMaxLog <= ScaleLog(Axis).Logs(i + 1) Then
				ScaleLog(Axis).LogMax = ScaleLog(Axis).Logs(i + 1)
				Exit
			End If
		Next
	End If
	
	If ScaleLog(Axis).LogMax = 1 Then
		ScaleLog(Axis).MantMax = ScaleLog(Axis).MantMax + 1
		ScaleLog(Axis).LogMax = 0
	End If
	Scale(Axis).MinVal = Power(10, ScaleLog(Axis).MantMin + ScaleLog(Axis).LogMin)
	Scale(Axis).MaxVal = Power(10, ScaleLog(Axis).MantMax + ScaleLog(Axis).LogMax)
	Scale(Axis).Interval = 1
End Sub

Private Sub GetScaleMant(ScaleMant0 As Double, Axis As Int) As Double
	Private ScaleMant1 As Double
	
	ScaleLogVals(Axis)
	
	If Round2(ScaleMant0, 14) <= Round2(ScaleLog(Axis).Logs(0), 14) Then
		ScaleMant1 = 0
	Else
		For i = 0 To ScaleLog(Axis).Logs.Length - 2
			If Round2(ScaleMant0, 14) > Round2(ScaleLog(Axis).Logs(i), 14) And Round2(ScaleMant0, 14) <= Round2(ScaleLog(Axis).Logs(i + 1), 14) Then
				ScaleMant1 = Logarithm(ScaleLog(Axis).Vals(i + 1), 10)
				Exit
			End If
		Next
	End If
	
'	If ScaleMant0 <= ScaleLog(Axis).Logs(0) Or Abs(ScaleMant0) < 1e-14 Then
'		ScaleMant1 = 0
'	Else
'		For i = 0 To ScaleLog(Axis).Logs.Length - 2
'			If ScaleMant0 > ScaleLog(Axis).Logs(i) And ScaleMant0 <= ScaleLog(Axis).Logs(i + 1) Then
'				ScaleMant1 = Logarithm(ScaleLog(Axis).Vals(i + 1), 10)
'				Exit
'			End If
'		Next
'	End If
	
	Return ScaleMant1
End Sub

'gets min and max values of the given points for bars
Private Sub GetBarPointsMinMaxValues As Double()
	Private j, j As Int
	Private MinMax(2) As Double
	
	If Graph.ChartType = "BAR" Then
		' BAR chart
		MinMax(1) = -1E10
		MinMax(0) = 1E10
	
		For i = 0 To Points.Size - 1
			Private YVals() As Double
			Private PD As PointData
			PD = Points.Get(i)
			YVals = PD.YArray
			For j = 0 To PD.YArray.Length - 1
				MinMax(1) = Max(MinMax(1), YVals(j))
				MinMax(0) = Min(MinMax(0), YVals(j))
			Next
		Next
		MinMaxMeanValues(0) = MinMax(0)
		MinMaxMeanValues(1) = MinMax(1)
		If MinMax(0) > 0 And MinMax(1) > 0 Then
			MinMax(0) = 0
		End If
		If MinMax(0) < 0 And MinMax(1) < 0 Then
			MinMax(1) = 0
		End If
	Else
		' STACKED BAR chart
		MinMax(1) = 0
		MinMax(0) = 0
	
		For i = 0 To Points.Size - 1
			Private YVals(), Total As Double
			Private PD As PointData
			PD = Points.Get(i)
			YVals = PD.YArray
			For j = 0 To PD.YArray.Length - 1
				Total = Total + YVals(j)
			Next
			MinMax(1) = Max(MinMax(1), Total)
		Next
		MinMaxMeanValues(0) = MinMax(0)
		MinMaxMeanValues(1) = MinMax(1)
	End If
	
	Return MinMax
End Sub

'gets min, max and mean values of the given points for lines
Private Sub GetLinePointsMinMaxMeanValues(Axis As Int) As Double()
	Private i, j As Int
	Private MMMValues(3) As Double
	MMMValues(1) = -1E10
	MMMValues(0) = 1E10
	MMMValues(2) = 0

	If Graph.ChartType = "LINE" Then
		If Scale(Axis).Different = False Then 'mono scale
			For i = 0 To Points.Size - 1
				Private YVals() As Double
				Private PD As PointData
				PD = Points.Get(i)
				If Axis = sX Then
					YVals = PD.XArray
				Else
					YVals = PD.YArray
				End If
				For j = 0 To PD.YArray.Length - 1
					MMMValues(1) = Max(MMMValues(1), YVals(j))
					MMMValues(0) = Min(MMMValues(0), YVals(j))
					MMMValues(2) = MMMValues(2) + YVals(j)
				Next
			Next
		Else	'multi scale
			For i = 0 To Points.Size - 1	'????
				Private YVals() As Double
				Private PD As PointData
				PD = Points.Get(i)
				YVals = PD.YArray
				For j = 0 To PD.YArray.Length - 1
					MMMValues(1) = Max(MMMValues(1), YVals(Axis - 1))
					MMMValues(0) = Min(MMMValues(0), YVals(Axis - 1))
					MMMValues(2) = MMMValues(2) + YVals(Axis - 1)
				Next
			Next
		End If
		MMMValues(2) = MMMValues(2) / Points.Size / PD.YArray.Length
	Else	'YXCHART
		Private ID As ItemData
		If Scale(Axis).Different = False Then 'mono scale
			For l = 0 To Items.Size - 1
				ID = Items.Get(l)
				For i = 0 To ID.YXArray.Size - 1
					Private YXVal(2) As Double
					YXVal = ID.YXArray.Get(i)
					If Axis = sX Then  'X axis
						MMMValues(1) = Max(MMMValues(1), YXVal(0))
						MMMValues(0) = Min(MMMValues(0), YXVal(0))
					Else	'Y axis
						MMMValues(1) = Max(MMMValues(1), YXVal(1))
						MMMValues(0) = Min(MMMValues(0), YXVal(1))
					End If
				Next
			Next
		Else	'multi scale
			ID = Items.Get(Axis - 1)
			For i = 0 To ID.YXArray.Size - 1
				Private YXVal(2) As Double
				YXVal = ID.YXArray.Get(i)
				If Axis = sX Then  'X axis
					MMMValues(1) = Max(MMMValues(1), YXVal(0))
					MMMValues(0) = Min(MMMValues(0), YXVal(0))
					MMMValues(2) = MMMValues(2) + YXVal(0)
				Else	'Y axis
					MMMValues(1) = Max(MMMValues(1), YXVal(1))
					MMMValues(0) = Min(MMMValues(0), YXVal(1))
					MMMValues(2) = MMMValues(2) + YXVal(1)
				End If
			Next
		End If
'		MMMValues(0) = MMMValues(0)
'		MMMValues(1) = MMMValues(1)
		MMMValues(2) = 0
	End If

	MinMaxMeanValues(0) = MMMValues(0)
	MinMaxMeanValues(1) = MMMValues(1)
	MinMaxMeanValues(2) = MMMValues(2)

	Return MMMValues
End Sub

'gets the max width of the x scale values in pixels
Private Sub GetXScaleWidth As Int
	Private Width As Int

	If Graph.ChartType = "YX_CHART" Then
		If Scale(sY(0)).Automatic = True Then
			Width = MeasureTextWidth(NumberFormat3(Scale(sX).MaxVal, 6), Texts.ScaleFont)
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sX).MinVal, 6), Texts.ScaleFont))
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sX).Interval, 6), Texts.ScaleFont))
		Else
			Width = MeasureTextWidth(NumberFormat3(Scale(sX).MaxVal, 6), Texts.ScaleFont)
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sX).MinVal, 6), Texts.ScaleFont))
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sX).Interval, 6), Texts.ScaleFont))
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sX).MaxVal - Scale(sY(0)).Interval, 6), Texts.ScaleFont))
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sX).MinVal + Scale(sY(0)).Interval, 6), Texts.ScaleFont))
		End If
	Else
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			If Graph.ChartType = "LINE" And PD.ShowTick = True Then
				Width = Max(Width, MeasureTextWidth(PD.X, Texts.ScaleFont))
			Else
				Width = Max(Width, MeasureTextWidth(PD.X, Texts.ScaleFont))
			End If
		Next
	End If
	Return Width
End Sub

'gets the max width of the y scale values in pixels
Private Sub GetYScaleWidth(Index As Int) As Int	'???
	Private Width As Int
	
	If Scale(sY(0)).Automatic = True And Scale(sY(0)).Logarithmic = False Then
'		Width = MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MaxVal, 6), Texts.ScaleFont)
'		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal, 6), Texts.ScaleFont))
'		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).Interval, 6), Texts.ScaleFont))

		Width = MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal, 6), Texts.ScaleFont)
		For i = 1 To Scale(sY(Index)).NbIntervals
'			Log(NumberFormat3(Scale(sY).MinVal + i * Scale(sY).IntervalAuto, 6))
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal + i * Scale(sY(Index)).IntervalAuto, 6), Texts.ScaleFont))
		Next
	Else
		Width = MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MaxVal, 6), Texts.ScaleFont)
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal, 6), Texts.ScaleFont))
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).Interval, 6), Texts.ScaleFont))
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MaxVal - Scale(sY((Index))).Interval, 6), Texts.ScaleFont))
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal + Scale(sY((Index))).Interval, 6), Texts.ScaleFont))
	End If
	Return Width
End Sub

'Draws an empty chart with the current background color
Public Sub DrawEmptyChart
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)	
End Sub

'draws a chart
Public Sub DrawChart
	InitChart
	
	If Graph.Error = True Then
		DrawError
		Return
	End If
	
	Select Graph.ChartType
		Case "LINE"
			GetXIntervals
			DrawGrid
			If Scale(sY(0)).Logarithmic = True Then
				DrawLinesLog
			Else
				If Items.Size > 1 And Items.Size <= NbMaxDifferentScales  And Scale(sY(0)).Different = True Then
					DrawLinesNScales
				Else
					DrawLines
				End If
			End If
		Case "BAR"
			If BarWidth0 = False Then
				DrawGrid
				DrawBars
			End If
		Case "STACKED_BAR"
			If BarWidth0 = False Then
				DrawGrid
				DrawBars
			End If
		Case "PIE"
			DrawPies
		Case "YX_CHART"
			DrawGrid
			If Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
				DrawYXLinesNScales
			Else
				DrawYXLines
			End If
	End Select
'	If SubExists(mCallBack, mEventName & "_DrawingFinished") Then
'		CallSubDelayed(mCallBack, mEventName & "_DrawingFinished")
'	End If
	
End Sub

Private Sub DrawError
	Private x, y As Double
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)
	
	x = xcvsGraph.TargetRect.CenterX
	y = xcvsGraph.TargetRect.Top + 100
	
	xcvsGraph.DrawText("E R R O R", x, y, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	y = y + 40
	xcvsGraph.DrawText(Graph.Title & "  " & Graph.ChartType & " chart", x, y, Texts.SubtitleFont, Texts.TitleTextColor, "CENTER")
	y = y + 40
	xcvsGraph.DrawText(Graph.ErrorText, x, y, Texts.SubtitleFont, Texts.TitleTextColor, "CENTER")
End Sub

'draws the grid of a chart with the scales, titles and axis names, not for PIE charts
Private Sub DrawGrid
	Private x1, y As Int
	
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)
	If Scale(sY(0)).Logarithmic = True And (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") Then
		ScaleLog(sY(0)).Scale = Graph.Height / (ScaleLog(sY(0)).MantMax - ScaleLog(sY(0)).MantMin)
		DrawYScaleLog
	Else
		If (Graph.ChartType = "LINE" Or Graph.ChartType = "YX_CHART") And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
			For i = 0 To Items.Size - 1
				Scale(sY(i)).Scale = Graph.Height / (Scale(sY(i)).MaxVal - Scale(sY(i)).MinVal)
			Next
			DrawScalesY
		Else
			Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
			DrawScaleY
		End If
	End If
	If Scale(sX).Logarithmic = True And Graph.ChartType = "YX_CHART" Then
		ScaleLog(sX).Scale = Graph.Width / (ScaleLog(sX).MantMax + ScaleLog(sX).LogMax - ScaleLog(sX).MantMin - ScaleLog(sX).LogMin)
		DrawXScaleLog
	Else
		DrawScaleX
	End If
	
	y = 0.45 * Texts.TitleTextHeight
	If Graph.Title <> "" Then
		y = y + 0.9 * Texts.TitleTextHeight
		xcvsGraph.DrawText(Graph.Title, Graph.Left + Graph.Width / 2, y, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	End If
	
	If Graph.Subtitle <> "" Then
		y = y + 1.5 * Texts.SubtitleTextHeight
		xcvsGraph.DrawText(Graph.Subtitle, Graph.Left + Graph.Width / 2, y, Texts.SubtitleFont, Texts.SubtitleTextColor, "CENTER")
	End If
	
	y = xcvsGraph.TargetRect.Height - 0.38 * Texts.AxisTextHeight
	If Legend.IncludeLegend = "BOTTOM" Then
		y = y - Legend.Height - 0.75 * Legend.TextHeight
	End If
	
	If Graph.XAxisName <> "" Then
		xcvsGraph.DrawText(Graph.XAxisName, Graph.Left + Graph.Width / 2, y, Texts.AxisFont, Texts.AxisTextColor, "CENTER")
	End If
	
	x1 = 1.5 * Texts.AxisTextHeight
	If xui.IsB4i Then x1 = 1.2 * Texts.AxisTextHeight
	If Graph.YAxisName <> "" Then
		xcvsGraph.DrawTextRotated(Graph.YAxisName, x1, Graph.Top + Graph.Height / 2, Texts.AxisFont, Texts.AxisTextColor, "CENTER", -90)
	End If
	
	If Graph.DrawGridFrame = True Then
		xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
		xcvsGraph.DrawLine(Graph.Left, Graph.Bottom, Graph.Right, Graph.Bottom, Graph.GridFrameColor, 2dip)
		xcvsGraph.DrawLine(Graph.Left, Graph.Top, Graph.Left, Graph.Bottom, Graph.GridFrameColor, 2dip)
	End If
	
	If Graph.DrawOuterFrame = True Then
		Private rctOuter As B4XRect
		rctOuter.Initialize(0, 0, xpnlCursor.Width, xpnlCursor.Height)
		xcvsGraph.DrawRect(rctOuter, Graph.GridFrameColor, False, 4dip)
	End If
End Sub

'draws the Y scale
Private Sub DrawScaleY
	Private i, y, y1 As Int
	Private txt As String
	
	y1 = Graph.Bottom
	For i = 0 To Scale(sY(0)).NbIntervals
		y = Graph.Bottom - i * Graph.YInterval
		
		If Graph.DrawHorizontalGridLines = True Then
			xcvsGraph.DrawLine(Graph.Left, y, Graph.Right, y, Graph.GridColor, 1dip)
		End If
		
		If Scale(sY(0)).DrawYScale = True Then
			xcvsGraph.DrawLine(Graph.Left - 4dip, y, Graph.Left, y, Graph.GridFrameColor, 2dip)
			If MinMaxMeanValues(0) = 0 And MinMaxMeanValues(1) = 0 Then
				txt = ""
			Else
				txt = NumberFormat3(Scale(sY(0)).MinVal + i * Scale(sY(0)).Interval, 6)
			End If
		
			If i = 0 Or MeasureTextHeight(txt, Texts.ScaleFont) * 1.8 < y1 - y Then
#If B4A
				xcvsGraph.DrawText(txt, Graph.Left - 0.75 * Texts.ScaleTextHeight, y + 0.52 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#Else If B4J
				xcvsGraph.DrawText(txt, Graph.Left - 0.6 * Texts.ScaleTextHeight, y + 0.38 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#Else
				xcvsGraph.DrawText(txt, Graph.Left - 0.6 * Texts.ScaleTextHeight, y + 0.52 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#End If				
				y1 = y
			End If
		End If
	Next
	If Scale(sY(0)).DrawYScale = True Then
		xcvsGraph.DrawLine(Graph.Left, Graph.Top, Graph.Left, Graph.Bottom, Graph.GridFrameColor, 2dip)
	End If
End Sub

'draws the Y scales
Private Sub DrawScalesY
	Private i, l, x(NbMaxDifferentScales), dy(NbMaxDifferentScales), y, y1 As Int
	Private txt As String
	Private ID As ItemData
	Private Alignment(4) As String
	Alignment(0) = "RIGHT"
	Alignment(1) = "LEFT"
	Alignment(2) = "RIGHT"
	Alignment(3) = "LEFT"
#If B4A
	x(0) = Graph.Left - 0.75 * Texts.ScaleTextHeight
	x(1) = Graph.Right + 0.75 * Texts.ScaleTextHeight
	x(2) = Graph.Left - 0.75 * Texts.ScaleTextHeight
	x(3) = Graph.Right + 0.75 * Texts.ScaleTextHeight
	dy(0) = 0.52 * Texts.ScaleTextHeight
	dy(1) = 0.52 * Texts.ScaleTextHeight
	dy(2) = -0.48 * Texts.ScaleTextHeight
	dy(3) = -0.48 * Texts.ScaleTextHeight
#Else If B4J
	x(0) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(1) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	x(2) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(3) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	dy(0) = 0.38 * Texts.ScaleTextHeight
	dy(1) = 0.38 * Texts.ScaleTextHeight
	dy(2) = -0.62 * Texts.ScaleTextHeight
	dy(3) = -0.62 * Texts.ScaleTextHeight
#Else
	x(0) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(1) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	x(2) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(3) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	dy(0) = 0.52 * Texts.ScaleTextHeight
	dy(1) = 0.52 * Texts.ScaleTextHeight
	dy(2) = -0.48 * Texts.ScaleTextHeight
	dy(3) = -0.48 * Texts.ScaleTextHeight
#End If	
	y1 = Graph.Bottom
	For l = 0 To Items.Size - 1
		ID = Items.Get(l)
		For i = 0 To Scale(sY(0)).NbIntervals
			y = Graph.Bottom - i * Graph.YInterval
			If Graph.DrawHorizontalGridLines = True Then
				xcvsGraph.DrawLine(Graph.Left, y, Graph.Right, y, Graph.GridColor, 1dip)
			End If

			If Scale(sY(0)).DrawYScale = True Then
				xcvsGraph.DrawLine(Graph.Left - 4dip, y, Graph.Left, y, Graph.GridFrameColor, 2dip)
				If Scale(sY(0)).Different = True Then
					xcvsGraph.DrawLine(Graph.Right, y, Graph.Right + 4dip, y, Graph.GridFrameColor, 2dip)
				End If
				If Scale(sY(l)).MinVal = 0 And Scale(sY(l)).MaxVal = 0 Then
					txt = ""
				Else
					txt = NumberFormat3(Scale(sY(l)).MinVal + i * Scale(sY(l)).Interval, 6)
				End If
		
				If i = 0 Or MeasureTextHeight(txt, Texts.ScaleFont) * 1.8 < y1 - y Then
					'????? skip scale values
					xcvsGraph.DrawText(txt, x(l), y + dy(l), Texts.ScaleFont, ID.Color, Alignment(l))
					y1 = y
				End If
			End If
		Next
	Next
	xcvsGraph.DrawLine(Graph.Left, Graph.Top, Graph.Left, Graph.Bottom, Graph.GridFrameColor, 2dip)
End Sub

'draws the logarithmic Y scale
Private Sub DrawYScaleLog
	Private yi, y0, Manti, Logi As Int
	Private txt As String
	Private Val0 As Double
	
	ScaleLog(sY(0)).Scale = Graph.Height / (ScaleLog(sY(0)).MantMax + ScaleLog(sY(0)).LogMax - ScaleLog(sY(0)).MantMin - ScaleLog(sY(0)).LogMin)
	y0 = Graph.Bottom + (ScaleLog(sY(0)).MantMin + ScaleLog(sY(0)).LogMin) * ScaleLog(sY(0)).Scale
	Val0 = -1
	Manti = ScaleLog(sY(0)).MantMin
	Logi = ScaleLog(sY(0)).LogMinIndex
	Do While Val0 < Round2(Scale(sY(0)).MaxVal, 12)
		yi = y0 - (ScaleLog(sY(0)).Logs(Logi) + Manti) * ScaleLog(sY(0)).Scale
		xcvsGraph.DrawLine(Graph.Left - 4dip, yi, Graph.Left, yi, Graph.GridFrameColor, 2dip)
		If Graph.DrawHorizontalGridLines = True Then
			If ScaleLog(sY(0)).Logs(Logi) <> 0 Then
				xcvsGraph.DrawLine(Graph.Left, yi, Graph.Right, yi, Graph.GridColor, 1dip)
			Else
				xcvsGraph.DrawLine(Graph.Left, yi, Graph.Right, yi, Graph.GridColorDark, 1dip)
			End If
		End If
		
		If Scale(sY(0)).DrawYScale = True Then	
			Val0 = Round2(Power(10, ScaleLog(sY(0)).Logs(Logi) + Manti), 12)
			txt = NumberFormat3(Val0, 6)
#if B4A
		xcvsGraph.DrawText(txt, Graph.Left - 0.75 * Texts.ScaleTextHeight, yi + 0.52 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#Else If B4J
			xcvsGraph.DrawText(txt, Graph.Left - 0.6 * Texts.ScaleTextHeight, yi + 0.38 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#Else
		xcvsGraph.DrawText(txt, Graph.Left - 0.6 * Texts.ScaleTextHeight, yi + 0.52 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#End If	

			Logi = Logi + 1
			If Logi = ScaleLog(sY(0)).Logs.Length - 1 Then
				Logi = 0
				Manti = Manti + 1
			End If
		End If
	Loop
End Sub

'draws the X scale
Private Sub DrawScaleX
	Private i, x, x1, XInterval, l1 As Int
	Private txt As String
	Private h1, h2, h3, h4, h5 As Double
	
#If B4i	
	h1 = 1.52
	h2 = 0.5
	h3 = 0.6
	h4 = 0.75
	h5 = 1.35
#Else
	h1 = 1.65
	h2 = 0.38
	h3 = 0.45
	h4 = 0.6
	h5 = 1.2
#End If
	l1 = 4dip

	If Graph.ChartType = "YX_CHART" Then
		XInterval = Graph.Width / Scale(sX).NbIntervals
		For i = 0 To Scale(sX).NbIntervals
			x = Graph.Left + i * XInterval
			txt = NumberFormat3(Scale(sX).MinVal + i * Scale(sX).Interval, 6)
'			xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
			If Graph.DrawVerticalGridLines = True Then
				xcvsGraph.DrawLine(x, Graph.Top, x, Graph.Bottom, Graph.GridColor, 1dip)
			End If
			If Scale(sX).DrawXScale = True Then
				Select Graph.XScaleTextOrientation
					Case "HORIZONTAL"
						If (x - x1) > 1.8 * MeasureTextWidth(txt, Texts.ScaleFont) Then
							xcvsGraph.DrawText(txt, x, Graph.Bottom + h1 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "CENTER")
							x1 = x
						End If
					Case "VERTICAL"
						If (x - x1) > 1.8 * Texts.ScaleTextHeight Then
							xcvsGraph.DrawTextRotated(txt, x + h2 * Texts.ScaleTextHeight, Graph.Bottom + h4 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -90)
							x1 = x
						End If
					Case "45 DEGREES"
						If (x - x1) > 1.8 * Texts.ScaleTextHeight Then
							xcvsGraph.DrawTextRotated(txt, x + h3 * Texts.ScaleTextHeight, Graph.Bottom + h5 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -45)
							x1 = x
						End If
				End Select
				xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
			End If
			x1 = x
		Next
	Else
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			If Graph.ChartType = "LINE" Then
				x = Graph.Left + i * Scale(sX).Scale
			Else
				x = Graph.Left + Graph.XOffset + (i + 0.5) * Graph.XInterval
			End If
			If PD.ShowTick = True Then
'				xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
				If Graph.DrawVerticalGridLines = True Then
					xcvsGraph.DrawLine(x, Graph.Top, x, Graph.Bottom, Graph.GridColor, 1dip)
				End If
				If Scale(sX).DrawXScale = True Then			
					Select Graph.XScaleTextOrientation
						Case "HORIZONTAL"
							If (x - x1) > 1.8 * MeasureTextWidth(PD.X, Texts.ScaleFont) Then
								xcvsGraph.DrawText(PD.X, x, Graph.Bottom + h1 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "CENTER")
								x1 = x
								xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
							End If
						Case "VERTICAL"
							If (x - x1) > 1.8 * Texts.ScaleTextHeight Then
								xcvsGraph.DrawTextRotated(PD.X, x + h2 * Texts.ScaleTextHeight, Graph.Bottom + h4 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -90)
								x1 = x
								xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
							End If
						Case "45 DEGREES"
							If (x - x1) > 1.8 * Texts.ScaleTextHeight Then
								xcvsGraph.DrawTextRotated(PD.X, x + h3 * Texts.ScaleTextHeight, Graph.Bottom + h5 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -45)
								x1 = x
								xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
							End If
					End Select
				End If
			End If
		Next
	End If
End Sub

'draws the X logarithmic scale
Private Sub DrawXScaleLog
	Private xi, x0, xn, Manti, Logi, l1 As Int
	Private txt As String
	Private Val0 As Double
	Private h1, h2, h3, h4, h5 As Double
	
#If B4i	
	h1 = 1.35
	h2 = 0.33
	h3 = 0.4
	h4 = 0.5
	h5 = 0.9
#Else
	h1 = 1.1
	h2 = 0.25
	h3 = 0.3
	h4 = 0.6
	h5 = 0.8
#End If
	l1 = 4dip
	
'	Private Logs() As String
'	Logs = Regex.Split("!",ScaleLog(sY(0)).ScaleValues)
'	Private LogsVal(Logs.Length) As Double
'	For i = 0 To Logs.Length - 1
'		LogsVal(i) = Logs(i)
'	Next

	x0 = Graph.Left - (ScaleLog(sX).MantMin + ScaleLog(sX).LogMin) * ScaleLog(sX).Scale
	Val0 = -1
	Manti = ScaleLog(sX).MantMin
	Logi = ScaleLog(sX).LogMinIndex
	Do While Val0 < Scale(sX).MaxVal
		xi = x0 + (ScaleLog(sX).Logs(Logi) + Manti) * ScaleLog(sX).Scale
		xcvsGraph.DrawLine(xi, Graph.Bottom - 4dip, xi, Graph.Bottom, Graph.GridFrameColor, 2dip)
		If ScaleLog(sX).Logs(Logi) <> 0 Then
			xcvsGraph.DrawLine(xi, Graph.Top, xi, Graph.Bottom, Graph.GridColor, 1dip)
		Else
			xcvsGraph.DrawLine(xi, Graph.Top, xi, Graph.Bottom, Graph.GridColorDark, 1dip)
		End If
		Val0 = Power(10, ScaleLog(sX).Logs(Logi) + Manti)
		txt = NumberFormat3(Val0, 6)

		Select Graph.XScaleTextOrientation
			Case "HORIZONTAL"
				If (xi - xn) > 1.8 * MeasureTextWidth(txt, Texts.ScaleFont) Then
					xcvsGraph.DrawText(txt, xi, Graph.Bottom + h1 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "CENTER")
					xn = xi
				End If
			Case "VERTICAL"
				If (xi - xn) > 1.8 * Texts.ScaleTextHeight Then
					xcvsGraph.DrawTextRotated(txt, xi + h2 * Texts.ScaleTextHeight, Graph.Bottom + h4 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -90)
					xn = xi
				End If
			Case "45 DEGREES"
				If (xi - xn) > 1.8 * Texts.ScaleTextHeight Then
					xcvsGraph.DrawTextRotated(txt, xi + h3 * Texts.ScaleTextHeight, Graph.Bottom + h5 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -45)
					xn = xi
				End If
				xcvsGraph.DrawLine(xi, Graph.Bottom, xi, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
		End Select

		Logi = Logi + 1
		If Logi = ScaleLog(sX).Logs.Length - 1 Then
			Logi = 0
			Manti = Manti + 1
		End If
	Loop
End Sub

'draws the lines in a LINE chart
Private Sub DrawLines
	Private i As Int
	Private x0, x1 As Int
	
	Private PD As PointData
	Private Cols(Items.Size), PointCols(Items.Size), StrokeWidths(Items.Size) As Int
	Private Names(Items.Size), PointTypes(Items.Size) As String
	Private Filled(Items.Size) As Boolean
	
	If Items.Size = 1 And (MinMaxMeanValues(0) <> 0 Or MinMaxMeanValues(1) <> 0) Then
		Private sMax, sMin, sMean As Double
		If Graph.IncludeMinLine = True Then
			sMin = Graph.Bottom - (MinMaxMeanValues(0) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			xcvsGraph.DrawLine(Graph.Left, sMin, Graph.Right, sMin, Graph.MinLineColor, 2dip)
		End If
		If Graph.IncludeMaxLine = True Then
			sMax = Graph.Bottom - (MinMaxMeanValues(1) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			xcvsGraph.DrawLine(Graph.Left, sMax, Graph.Right, sMax, Graph.MaxLineColor, 2dip)
		End If
		If Graph.IncludeMeanLine = True Then
			sMean = Graph.Bottom - (MinMaxMeanValues(2) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			xcvsGraph.DrawLine(Graph.Left, sMean, Graph.Right, sMean, Graph.MeanLineColor, 2dip)
		End If
	End If
	
	PD = Points.Get(0)
	x0 = Graph.Left
	Private py0(PD.YArray.Length), py1(PD.YArray.Length) As Double
	Private psy0(PD.YArray.Length), psy1(PD.YArray.Length) As Double
	py0 = PD.YArray
	For i = 0 To py0.Length - 1
		Private ID As ItemData
		ID = Items.Get(i)
		Cols(i) = ID.Color
		PointCols(i) = ID.PointColor
		Names(i) = ID.Name
		StrokeWidths(i) = ID.StrokeWidth
		PointTypes(i) = ID.PointType
		Filled(i) = ID.Filled
		psy0(i) = Graph.Bottom - (py0(i) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
	Next
	
	xcvsGraph.ClipPath(pthGrid)
	For i = 1 To Points.Size - 1
		Private PD As PointData
		PD = Points.Get(i)
		py1 = PD.YArray
		x1 = Graph.Left + i * Scale(sX).Scale
		For j = 0 To py1.Length - 1
			psy1(j) = Graph.Bottom - (py1(j) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			xcvsGraph.DrawLine(x0, psy0(j), x1, psy1(j), Cols(j), StrokeWidths(j))
			psy0(j) = psy1(j)
		Next
		x0 = x1
	Next
	xcvsGraph.RemoveClip
	
	For i = 0 To Points.Size - 1
		Private PD As PointData
		PD = Points.Get(i)
		py1 = PD.YArray
		x1 = Graph.Left + i * Scale(sX).Scale
		For j = 0 To py1.Length - 1
			psy1(j) = Graph.Bottom - (py1(j) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			If PointTypes(j) <> "NONE" Then
				DrawPoint(x1, psy1(j), PointCols(j), PointTypes(j), Filled(j), StrokeWidths(j))
			End If
		Next
	Next
	
'	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	If Scale(sY(0)).MinVal< 0 And Scale(sY(0)).MaxVal > 0 Then
		Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
		If Scale(sY(0)).YZeroAxisHighlight = True Then
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
		Else
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
		End If
	End If

	If Legend.IncludeLegend <> "NONE" And Points.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws N lines with N different scales
Private Sub DrawLinesNScales
	Private i, j As Int
	Private x0, x1, y0, y1 As Int
	
	Private PD As PointData

	For i = 0 To Items.Size - 1
		Private ID As ItemData
		ID = Items.Get(i)
		PD = Points.Get(0)
		x0 = Graph.Left
		y0 = Graph.Bottom - (PD.YArray(i) - Scale(sY(i)).MinVal) * Scale(sY(i)).Scale
		For j = 1 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(j)
			x1 = Graph.Left + j * Scale(sX).Scale
			y1 = Graph.Bottom - (PD.YArray(i) - Scale(sY(i)).MinVal) * Scale(sY(i)).Scale
			xcvsGraph.DrawLine(x0, y0, x1, y1, ID.Color, ID.StrokeWidth)
			x0 = x1
			y0 = y1
		Next
		
		If ID.PointType <> "NONE" Then
			For j = 0 To Points.Size - 1
				Private PD As PointData
				PD = Points.Get(j)
				x0 = Graph.Left + j * Scale(sX).Scale
				y0 =  Graph.Bottom - (PD.YArray(i) - Scale(sY(i)).MinVal) * Scale(sY(i)).Scale
				DrawPoint(x0, y0, ID.PointColor, ID.PointType, ID.Filled, ID.StrokeWidth)
			Next
		End If
		
		If Scale(sY(i)).MinVal< 0 And Scale(sY(i)).MaxVal > 0 Then
			Private mYAxis0 = Graph.Bottom + Scale(sY(i)).MinVal * Scale(sY(i)).Scale As Int
			If Scale(sY(i)).YZeroAxisHighlight = True Then
				xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, ID.Color, 2dip)
			Else
				xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, ID.Color, 1dip)
			End If
		End If
	Next

	If Legend.IncludeLegend <> "NONE" And Points.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws the lines in a LINE chart with logarithmic scale
Private Sub DrawLinesLog
	Private i As Int
	Private x0, x1 As Int
	
	Private PD As PointData
	Private Cols(Items.Size), PointCols(Items.Size), StrokeWidths(Items.Size) As Int
	Private Names(Items.Size), PointTypes(Items.Size) As String
	Private Filled(Items.Size) As Boolean

	PD = Points.Get(0)
	x0 = Graph.Left
	Private py0(PD.YArray.Length), py1(PD.YArray.Length) As Double
	Private psy0(PD.YArray.Length), psy1(PD.YArray.Length) As Double
	py0 = PD.YArray
	For i = 0 To py0.Length - 1
		Private ID As ItemData
		ID = Items.Get(i)
		Cols(i) = ID.Color
		PointCols(i) = ID.PointColor
		Names(i) = ID.Name
		StrokeWidths(i) = ID.StrokeWidth
		PointTypes(i) = ID.PointType
		Filled(i) = ID.Filled
		psy0(i) = Graph.Bottom - (Logarithm(py0(i), 10) - ScaleLog(sY(0)).MantMin) * ScaleLog(sY(0)).Scale
	Next
	
	xcvsGraph.ClipPath(pthGrid)
	For i = 1 To Points.Size - 1
		Private PD As PointData
		PD = Points.Get(i)
		py1 = PD.YArray
		x1 = Graph.Left + i * Scale(sX).Scale
		For j = 0 To py1.Length - 1
			psy1(j) = Graph.Bottom - (Logarithm(py1(j), 10) -  ScaleLog(sY(0)).MantMin) *  ScaleLog(sY(0)).Scale
			xcvsGraph.DrawLine(x0, psy0(j), x1, psy1(j), Cols(j), StrokeWidths(j))
			psy0(j) = psy1(j)
		Next
		x0 = x1
	Next
	xcvsGraph.RemoveClip
	
	If Legend.IncludeLegend <> "NONE" And Points.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws a point at each StrokeTick
Private Sub DrawPoint(X As Int, Y As Int, Color As Int, PointType As String, Filled As Boolean, StrokeWidth As Int)
	Private dx As Int 
	
	If x < Graph.Left Or x > Graph.Right Or Y < Graph.Top Or Y > Graph.Bottom Then
		Return
	End If
	
	dx = Max(4dip, 1.4 * StrokeWidth)
	Select PointType
		Case "CIRCLE"
			If Filled = False Then
				xcvsGraph.DrawCircle(X, Y, dx, Graph.ChartBackgroundColor, True, 2dip)
				xcvsGraph.DrawCircle(X, Y, dx, Color, Filled, 2dip)
			Else
				xcvsGraph.DrawCircle(X, Y, dx, Color, True, 2dip)
				xcvsGraph.DrawCircle(X, Y, dx, Color, False, 2dip)
			End If
		Case "SQUARE"
			Private r As B4XRect
			r.Initialize(X - dx, Y - dx, X + dx, Y + dx)
			If Filled = False Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 2dip)
				xcvsGraph.DrawRect(r, Color, Filled, 2dip)
			Else
				xcvsGraph.DrawRect(r, Color, True, 2dip)
				xcvsGraph.DrawRect(r, Color, False, 2dip)
			End If
		Case "TRIANGLE"
			Private triPath As B4XPath
			triPath.Initialize(X - dx, Y + 0.8 * dx)
			triPath.LineTo(X, Y - 1.2 * dx)
			triPath.LineTo(X + dx, Y + 0.8 * dx)
			triPath.LineTo(X - dx, Y + 0.8 * dx)
			xcvsGraph.ClipPath(triPath)
			Private r As B4XRect
			r.Initialize(X - dx, Y - dx, X + dx, Y + dx)	
					
			If Filled = False Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y + dx, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X - dx, Y + dx, X + dx, Y + dx, Color, 2dip)
			Else
				xcvsGraph.DrawRect(r, Color, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y + dx, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X - dx, Y + dx, X + dx, Y + dx, Color, 2dip)
			End If
		Case "RHOMBUS"
			Private triPath As B4XPath
			triPath.Initialize(X - dx, Y)
			triPath.LineTo(X, Y -  dx)
			triPath.LineTo(X + dx, Y)
			triPath.LineTo(X, Y + dx)
			triPath.LineTo(X - dx, Y)
			xcvsGraph.ClipPath(triPath)
			Private r As B4XRect
			r.Initialize(X - dx, Y - dx, X + dx, Y + dx)
					
			If Filled = False Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y, Color, 2dip)
				xcvsGraph.DrawLine(X + dx, Y, X, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y + dx, X - dx, Y, Color, 2dip)
			Else
				xcvsGraph.DrawRect(r, Color, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y, Color, 2dip)
				xcvsGraph.DrawLine(X + dx, Y, X, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y + dx, X - dx, Y, Color, 2dip)
			End If
		Case "CROSS+"
			dx = dx + 1dip
			xcvsGraph.DrawLine(X, Y - dx, X, Y + dx, Color, 2dip)
			xcvsGraph.DrawLine(X - dx, Y, X + dx, Y, Color, 2dip)
		Case "CROSSX", "CROSSx"
			xcvsGraph.DrawLine(X - dx, Y + dx, X + dx, Y - dx, Color, 2dip)
			xcvsGraph.DrawLine(X - dx, Y - dx, X + dx, Y + dx, Color, 2dip)
	End Select
End Sub

'draws the XY lines in the chart
Private Sub DrawYXLines
	Private i, l As Int
	Private ID As ItemData
	Private yxVal(2) As Double
	Private x0, y0, x1, y1, xi, yi As Int
	
	If Items.Size = 0 Then Return
	
	xcvsGraph.ClipPath(pthGrid)
	xi = Graph.Left - (ScaleLog(sX).MantMin + ScaleLog(sX).LogMin) * ScaleLog(sX).Scale
	yi = Graph.Bottom + (ScaleLog(sY(0)).MantMin + ScaleLog(sY(0)).LogMin) * ScaleLog(sY(0)).Scale
	For l = 0 To Items.Size - 1
		ID = Items.Get(l)
		yxVal = ID.YXArray.Get(0)
		If Scale(sX).Logarithmic = False Then
			x0 = Graph.Left + (yxVal(0) - Scale(sX).MinVal) * Scale(sX).Scale
		Else
			x0 = xi + Logarithm(yxVal(0), 10) * ScaleLog(sX).Scale
		End If
		If Scale(sY(0)).Logarithmic = False Then
			y0 = Graph.Bottom - (yxVal(1) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
		Else
			y0 = yi - Logarithm(yxVal(1), 10) * ScaleLog(sY(0)).Scale
		End If
		
		For i = 0 To ID.YXArray.Size - 1
			yxVal = ID.YXArray.Get(i)
			If Scale(sX).Logarithmic = False Then
				x1 = Graph.Left + (yxVal(0) - Scale(sX).MinVal) * Scale(sX).Scale
			Else
				x1 = xi + Logarithm(yxVal(0), 10) * ScaleLog(sX).Scale
			End If
			If Scale(sY(0)).Logarithmic = False Then
				y1 = Graph.Bottom - (yxVal(1) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			Else
				y1 = yi - Logarithm(yxVal(1), 10) * ScaleLog(sY(0)).Scale
			End If
			If ID.DrawLine = True Then
				xcvsGraph.DrawLine(x0, y0, x1, y1 , ID.Color, ID.StrokeWidth)
			End If
			If ID.PointType <> "NONE" Then
				If i = 0 Then
					DrawPoint(x0, y0, ID.PointColor, ID.PointType, ID.Filled, ID.StrokeWidth)
				Else
					DrawPoint(x1, y1, ID.PointColor, ID.PointType, ID.Filled, ID.StrokeWidth)
				End If
			End If
			x0 = x1
			y0 = y1
		Next
	Next
	
	xcvsGraph.RemoveClip

	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	If Scale(sY(0)).MinVal< 0 And Scale(sY(0)).MaxVal > 0 Then
		Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
		If Scale(sY(0)).YZeroAxisHighlight = True Then
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
		Else
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
		End If
	End If
	
	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	If Scale(sX).MinVal< 0 And Scale(sX).MaxVal > 0 Then
		Private mXAxis0 = Graph.Left - Scale(sX).MinVal * Scale(sX).Scale As Int
		xcvsGraph.DrawLine(mXAxis0, Graph.Top, mXAxis0, Graph.Bottom, Graph.GridFrameColor, 2dip)
	End If

	If Legend.IncludeLegend <> "NONE" And (Points.Size > 0 Or Graph.ChartType = "YX_CHART") Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws the XY lines in the chart
Private Sub DrawYXLinesNScales
	Private i, l As Int
	Private ID As ItemData
	Private yxVal(2) As Double
	Private x0, y0, x1, y1, xi, yi As Int
	
	If Items.Size = 0 Then Return
	
	xcvsGraph.ClipPath(pthGrid)
	xi = Graph.Left - (ScaleLog(sX).MantMin + ScaleLog(sX).LogMin) * ScaleLog(sX).Scale
	yi = Graph.Bottom + (ScaleLog(sY(0)).MantMin + ScaleLog(sY(0)).LogMin) * ScaleLog(sY(0)).Scale
	For l = 0 To Items.Size - 1
		ID = Items.Get(l)
		yxVal = ID.YXArray.Get(0)
		If Scale(sX).Logarithmic = False Then
			x0 = Graph.Left + (yxVal(0) - Scale(sX).MinVal) * Scale(sX).Scale
		Else
			x0 = xi + Logarithm(yxVal(0), 10) * ScaleLog(sX).Scale
		End If
		If Scale(sY(0)).Logarithmic = False Then
			y0 = Graph.Bottom - (yxVal(1) - Scale(sY(l)).MinVal) * Scale(sY(l)).Scale
		Else
			y0 = yi - Logarithm(yxVal(1), 10) * ScaleLog(sY(l)).Scale
		End If
		
		For i = 0 To ID.YXArray.Size - 1
			yxVal = ID.YXArray.Get(i)
			If Scale(sX).Logarithmic = False Then
				x1 = Graph.Left + (yxVal(0) - Scale(sX).MinVal) * Scale(sX).Scale
			Else
				x1 = xi + Logarithm(yxVal(0), 10) * ScaleLog(sX).Scale
			End If
			If Scale(sY(0)).Logarithmic = False Then
				y1 = Graph.Bottom - (yxVal(1) - Scale(sY(l)).MinVal) * Scale(sY(l)).Scale
			Else
				y1 = yi - Logarithm(yxVal(1), 10) * ScaleLog(sY(l)).Scale
			End If
			If ID.DrawLine = True Then
				xcvsGraph.DrawLine(x0, y0, x1, y1 , ID.Color, ID.StrokeWidth)
			End If
			If ID.PointType <> "NONE" Then
				If i = 0 Then
					DrawPoint(x0, y0, ID.PointColor, ID.PointType, ID.Filled, ID.StrokeWidth)
				Else
					DrawPoint(x1, y1, ID.PointColor, ID.PointType, ID.Filled, ID.StrokeWidth)
				End If
			End If
			x0 = x1
			y0 = y1
		Next
	Next
	
	xcvsGraph.RemoveClip

	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	If Scale(sY(0)).MinVal< 0 And Scale(sY(0)).MaxVal > 0 Then
		Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
		If Scale(sY(0)).YZeroAxisHighlight = True Then
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
		Else
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
		End If
	End If
	
	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	If Scale(sX).MinVal< 0 And Scale(sX).MaxVal > 0 Then
		Private mXAxis0 = Graph.Left - Scale(sX).MinVal * Scale(sX).Scale As Int
		xcvsGraph.DrawLine(mXAxis0, Graph.Top, mXAxis0, Graph.Bottom, Graph.GridFrameColor, 2dip)
	End If

	If Legend.IncludeLegend <> "NONE" And (Points.Size > 0 Or Graph.ChartType = "YX_CHART") Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws the bars in a BAR chart
Private Sub DrawBars
	Private i, j, x0, x, h, y As Int
	Private Cols(Items.Size), ACols(Items.Size) As Int
	Private Names(Items.Size) As String

	For i = 0 To Items.Size - 1
		Private ID As ItemData
		ID = Items.Get(i)
		Cols(i) = ID.Color
		Private ARGB As ARGBColor
		Private BmpCreate As BitmapCreator
		BmpCreate.Initialize(10, 10)
		BmpCreate.ColorToARGB(Cols(i), ARGB)
		ACols(i) = xui.Color_ARGB(Graph.GradientColorsAlpha, ARGB.r, ARGB.g, ARGB.b)
		Names(i) = ID.Name
	Next
	
	If Graph.ChartType = "BAR" Then
		Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
	
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval - Graph.BarWidth / 2
			py = PD.YArray

			For j = 0 To PD.YArray.Length - 1
				Private r, rb As B4XRect
				x = x0 + j * Graph.BarSubWidth
				h = py(j) * Scale(sY(0)).Scale
				
				If h > 0 Then
					r.Initialize(x, mYAxis0 - h, x + Graph.BarSubWidth, mYAxis0)
				Else
					r.Initialize(x, mYAxis0, x + Graph.BarSubWidth, mYAxis0 - h)
				End If
				If Graph.GradientColors = False Then
					xcvsGraph.DrawRect(r, Cols(j), True, 1dip)
				Else
					Private bmc1 As BitmapCreator
					rb.Initialize(0, 0, Graph.BarSubWidth, Max(1, Abs(h)))
					bmc1.Initialize(Graph.BarSubWidth, Max(1, Abs(h)))
					If h > 0 Then
						bmc1.FillGradient(Array As Int(Cols(j), ACols(j)), rb, "TOP_BOTTOM")
					Else
						bmc1.FillGradient(Array As Int(Cols(j), ACols(j)), rb, "BOTTOM_TOP")
					End If
					xcvsGraph.DrawBitmap(bmc1.Bitmap, r)
				End If
			Next
		Next
		If Scale(sY(0)).DrawYScale = True Then
			If mYAxis0 = Graph.Top Or mYAxis0 = Graph.Bottom Then
				xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
			Else
				If Scale(sY(0)).YZeroAxisHighlight = True Then
					xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
				Else
					xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
				End If
			End If
		End If
		
		If Graph.IncludeValues = True And PD.YArray.Length = 1 Then
			DrawBarValues
		End If
		
		If Graph.IncludeBarMeanLine = True Then
			DrawBarMeanLine
		End If
	Else 'Graph.ChartType = "STACKED_BAR"
		Private mYAxis0 = Graph.Bottom As Int
	
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval - Graph.BarWidth / 2
			py = PD.YArray
		
			y = mYAxis0
			For j = 0 To PD.YArray.Length - 1
				Private r, rb As B4XRect
				h = py(j) * Scale(sY(0)).Scale
				r.Initialize(x0, y - h, x0 + Graph.BarWidth, y)
				If Graph.GradientColors = False Then
					xcvsGraph.DrawRect(r, Cols(j), True, 1dip)
				Else
					rb.Initialize(0, 0, Graph.BarSubWidth, Max(1, Abs(h)))
					Private bmc1 As BitmapCreator
					bmc1.Initialize(Graph.BarSubWidth, Max(1, Abs(h)))
					bmc1.FillGradient(Array As Int(Cols(j), ACols(j)), rb, "TOP_BOTTOM")
					xcvsGraph.DrawBitmap(bmc1.Bitmap, r)
				End If
				y = y - h
			Next
		Next
		If mYAxis0 = Graph.Top Or mYAxis0 = Graph.Bottom Then
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
		Else
			If Scale(sY(0)).YZeroAxisHighlight = True Then
				xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
			Else
				xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
			End If
		End If
	End If
	
	If Legend.IncludeLegend <> "NONE" And Items.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws the bars mean value line and its value, only for single bar charts
Private Sub DrawBarMeanLine
	If MinMaxMeanValues(0) = 0 And MinMaxMeanValues(1) = 0 Then Return
	
	Private PD As PointData
	PD = Points.Get(0)
	
	If PD.YArray.Length > 1 Then Return
	
	Private i, sMean, sMean0, h, x0, y0, yt As Int
	Private Total, Mean As Double
	For i = 0 To Points.Size - 1
		PD = Points.Get(i)
		Total = Total + PD.YArray(0)
	Next
	Mean = Total / Points.Size
	sMean0 = Mean * Scale(sY(0)).Scale
	sMean = Graph.Bottom - (Mean - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
	
'	Private ID As ItemData
'	ID = Items.Get(0)
'	xcvsGraph.DrawLine(Graph.Left, sMean, Graph.Right, sMean, ID.Color, 2dip)
	xcvsGraph.DrawLine(Graph.Left, sMean, Graph.Right, sMean, Graph.MeanLineColor, 2dip)
	
	If Scale(sY(0)).MinVal = 0 And Scale(sY(0)).MaxVal > 0 Then
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			h = PD.YArray(0) * Scale(sY(0)).Scale
			If sMean0 > h + 0.75 * Texts.ScaleTextHeight Then
				x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
				y0 = sMean - 1.35 * Texts.ScaleTextHeight
				yt = sMean - 0.3 * Texts.ScaleTextHeight
				Exit
			End If
		Next
	Else if Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			h = -PD.YArray(0) * Scale(sY(0)).Scale
			If -sMean0 > h + 0.3 * Texts.ScaleTextHeight Then
				x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
				y0 = sMean + 0.3 * Texts.ScaleTextHeight
				yt = sMean + 1.2 * Texts.ScaleTextHeight
				Exit
			End If
		Next
	Else
		If Mean >= 0 Then
			For i = 0 To Points.Size - 1
				Private PD As PointData
				PD = Points.Get(i)
				h = PD.YArray(0) * Scale(sY(0)).Scale
				If Mean >= 0 And sMean0 > h + 0.75 * Texts.ScaleTextHeight Then
					x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
					y0 = sMean - 1.45 * Texts.ScaleTextHeight
					yt = sMean - 0.3 * Texts.ScaleTextHeight
					Exit
				End If
			Next
		Else
			For i = 0 To Points.Size - 1
				Private PD As PointData
				PD = Points.Get(i)
				h = -PD.YArray(0) * Scale(sY(0)).Scale
				If Mean < 0 And -sMean0 > h + 0.3 * Texts.ScaleTextHeight Then
					x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
					y0 = sMean + 0.3 * Texts.ScaleTextHeight
					yt = sMean + 1.2 * Texts.ScaleTextHeight
					Exit
				End If
			Next
		End If
	End If
	
	Private txt As String
	Private rctText, rctMean As B4XRect
	Private txtW, txtH As Double
	If BMVNFUsed = False Then
		txt = NumberFormat3(Mean, 6)
	Else
		txt = NumberFormat2(Mean, BMVNF.MinimumIntegers, BMVNF.MaximumFractions, BMVNF.MinimumFractions, BMVNF.GroupingUsed)
	End If
	rctText = xcvsGraph.MeasureText(txt, Texts.ScaleFont)
	txtW = 4dip + rctText.Width
	txtH = 1.2 * rctText.Height
	rctMean.Initialize(x0 - txtW / 2, y0, x0 + txtW / 2, y0 + txtH)
	xcvsGraph.DrawRect(rctMean, Graph.ChartBackgroundColor, True, 1dip)
	xcvsGraph.DrawText(txt, x0, yt, Texts.ScaleFont, Graph.MeanLineColor, "CENTER")
'	xcvsGraph.DrawText(txt, x0, yt, Texts.ScaleFont, ID.Color, "CENTER")
End Sub

'draws the bar values, only for single bar charts
Private Sub DrawBarValues
	If MinMaxMeanValues(0) = 0 And MinMaxMeanValues(1) = 0 Then Return
	
	Private i, h, x, xt, dy, y, yt As Int
	Private Col As Int
	Private txt As String
	Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
	Private rectText, rectTextBackground As B4XRect
	Private TextWidth As Int
	Private LocalBarValueOrientation As String
	Private LocalTextSize As Float
	Private LocalTextHeight As Int
	Private LocalFont As B4XFont
	Private ID As ItemData
	
	ID = Items.Get(0)
	
	LocalBarValueOrientation = Graph.BarValueOrientation
	LocalFont = Texts.ScaleFont
	LocalTextHeight = Texts.ScaleTextHeight	'???
	LocalTextSize = Texts.ScaleTextSize
	'checks if the bar value text is too wide, if yes sets it to VERTICAL 
	If Graph.BarValueOrientation = "HORIZONTAL" Then
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			rectText = xcvsGraph.MeasureText(py(0), Texts.ScaleFont)
			TextWidth = rectText.Width + 1.5 * Texts.ScaleTextHeight
			If TextWidth + 1.5 * Texts.ScaleTextHeight > Graph.XInterval Then
				LocalBarValueOrientation = "VERTICAL"
				Log("xChart BarValueOrientation set to VERTICAL")
				Exit
			End If
		Next
	End If

	If LocalBarValueOrientation = "VERTICAL" Then
		Private TextAlignment As String
		
		'checks if the bar width is too small for the value text
		If Texts.ScaleTextHeight - 4dip > Graph.BarWidth Then	'???
			rectText = xcvsGraph.MeasureText("10", Texts.ScaleFont)
			LocalTextSize = Texts.ScaleTextSize * Graph.BarWidth / Texts.ScaleTextHeight	'???
			LocalFont = xui.CreateFont2(Texts.ScaleFont, LocalTextSize)
			LocalTextHeight = Texts.ScaleTextHeight * LocalTextSize / Texts.ScaleTextSize	'???
			If LocalTextSize < 10 Then
				Log("Bar value text size too small")
				Return
			End If
		End If
		
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			xt = Graph.Left + Graph.XOffset + (i + 0.5) * Graph.XInterval + 0.28 * LocalTextHeight
			x = xt - 0.72 * LocalTextHeight
			h = py(0) * Scale(sY(0)).Scale
			rectText = xcvsGraph.MeasureText(py(0), LocalFont)
			TextWidth = rectText.Width + LocalTextHeight
			If Abs(h) > TextWidth Then
				yt = mYAxis0 - h / 2
				TextAlignment = "CENTER"
				Col = GetContrastColor(ID.Color)
			Else
				y = mYAxis0 - h
				dy = 0.5 * LocalTextHeight
				rectTextBackground.Initialize(x, y, x + LocalTextHeight, y + TextWidth)
				rectTextBackground.Height = TextWidth
				If h = 0 Then
					If Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
						yt = y - dy
						TextAlignment = "RIGHT"
						rectTextBackground.Top = y
						rectTextBackground.Height = TextWidth
					Else
						yt = y - dy
						TextAlignment = "LEFT"
						rectTextBackground.Top = y - TextWidth
						rectTextBackground.Height = TextWidth
					End If
				Else If h > 0  Then
					If Abs(h) + TextWidth > mYAxis0 - Graph.Top Then
						yt = mYAxis0 + dy + 2dip
						TextAlignment = "RIGHT"
						rectTextBackground.Top = mYAxis0 + 2dip
						rectTextBackground.Height = TextWidth
					Else
						yt = y - dy
						TextAlignment = "LEFT"
						rectTextBackground.Top = y - TextWidth
						rectTextBackground.Height = TextWidth
					End If
				Else
					If Abs(h) + TextWidth > Graph.Bottom - mYAxis0 Then
						yt = mYAxis0 - dy- 2dip
						TextAlignment = "LEFT"
						rectTextBackground.Top = mYAxis0 - TextWidth - 2dip
						rectTextBackground.Height = TextWidth
					Else
						yt = y + dy
						TextAlignment = "RIGHT"
						rectTextBackground.Top = y
						rectTextBackground.Height = TextWidth
					End If
				End If
			
				Col = GetContrastColor(Graph.ChartBackgroundColor)
				xcvsGraph.DrawRect(rectTextBackground, Graph.ChartBackgroundColor, True, 1dip)
			End If
			txt = py(0)
			xcvsGraph.DrawTextRotated(txt, xt, yt, LocalFont, Col, TextAlignment, -90)
		Next
	Else	' Graph.BarValueOrientation = "HORIZONTAL"
		For i = 0 To Points.Size - 1
			Private PD As PointData
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			x = Graph.Left + Graph.XOffset + (i + 0.5) * Graph.XInterval
			h = py(0) * Scale(sY(0)).Scale
			If Abs(h) > 2.25 * Texts.ScaleTextHeight Then
				y = mYAxis0 - h / 2
				If h >= 0 Then
					y = y + 0.45 * Texts.ScaleTextHeight
				Else
					y = y + 0.38 * Texts.ScaleTextHeight
				End If
				Col = GetContrastColor(ID.Color)
			Else
				y = mYAxis0 - h
				If h = 0 Then
					If Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
						y = y + 1.45 * Texts.ScaleTextHeight
					Else
						y = y - 1.5 * Texts.ScaleTextHeight / 3
					End If
				Else If h > 0  Then
					y = y - 1.5 * Texts.ScaleTextHeight / 3
				Else
					y = y + 1.45 * Texts.ScaleTextHeight
				End If
			
				Col = GetContrastColor(Graph.ChartBackgroundColor)
			End If
			txt = py(0)
			xcvsGraph.DrawText(txt, x, y, Texts.ScaleFont, Col, "CENTER")
		Next	
	End If
End Sub

'draws the pies chart
Private Sub DrawPies
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)
	
	Dim Total As Float
	For Each Item As ItemData In Items
		Total = Total + Item.Value
	Next
	
	Private CenterX, CenterY, TitleHeight As Int
	
	If Graph.Title <> "" Then
		TitleHeight = 1.8 * Texts.TitleTextHeight
	End If
	Private Radius As Float = Min(xcvsGraph.TargetRect.Width, (Graph.Height - TitleHeight)) / 2 - 10dip
	
	If Legend.IncludeLegend <> "NONE" Then
		If xcvsGraph.TargetRect.Width > xcvsGraph.TargetRect.Height Then
			CenterX = Radius + 10dip
		Else
			CenterX = xcvsGraph.TargetRect.Width / 2
		End If
	Else
		CenterX = xcvsGraph.TargetRect.Width / 2
	End If
'	CenterY = xcvsGraph.TargetRect.Height - Radius - 10dip
	CenterY = Graph.Height - Radius - 10dip
	
	If Graph.Title <> "" Then
		xcvsGraph.DrawText(Graph.Title, xcvsGraph.TargetRect.Width / 2, 1.2 * Texts.TitleTextHeight, Texts.TitleFont, xui.Color_Black, "CENTER")
	End If
	
	Private RadiusText As Float = Radius * 0.7
	Private StartAngle, TotalAngle, MidAngle As Float
	TotalAngle = 360 - Graph.PieGapDegrees * Items.Size
	Private rectCircle As B4XRect
	rectCircle.Initialize(CenterX - Radius, CenterY - Radius, CenterX + Radius, CenterY + Radius)

	For Each Item As ItemData In Items
		Private mPath As B4XPath
		Private Angle As Float = Item.Value / Total * TotalAngle
		If Angle = TotalAngle Then
			If Graph.GradientColors = False Then
				xcvsGraph.DrawCircle(CenterX, CenterY, Radius, Item.Color, True, 0)
			Else				
			End If
		Else
			Private ARGB As ARGBColor
			Private BmpCreate As BitmapCreator
			Private Acol As Int
			BmpCreate.Initialize(10, 10)
			BmpCreate.ColorToARGB(Item.Color, ARGB)
			Acol = xui.Color_ARGB(Graph.GradientColorsAlpha, ARGB.r, ARGB.g, ARGB.b)
			
			mPath.InitializeArc(CenterX, CenterY, Radius, StartAngle, Angle)
			StartAngle = StartAngle + Angle + Graph.PieGapDegrees
			xcvsGraph.ClipPath(mPath)
			If Graph.GradientColors = False Then
				xcvsGraph.DrawCircle(CenterX, CenterY, Radius, Item.Color, True, 0)
			Else	
				Private rb As B4XRect
				rb.Initialize(0, 0, 2 * Radius, 2 * Radius)
				Private bc1 As BitmapCreator
				bc1.Initialize(2 * Radius, 2 * Radius)
				bc1.FillRadialGradient(Array As Int(Acol, Item.Color), rb)
				xcvsGraph.DrawBitmap(bc1.Bitmap, rectCircle)
			End If
			xcvsGraph.RemoveClip
		End If
	Next
	
	If Graph.PieAddPerentage Then
		Private Percentage As Float
		
		For Each Item As ItemData In Items
			Private mPath As B4XPath
			Private Angle As Float = Item.Value / Total * TotalAngle
			If Angle = TotalAngle Then
				xcvsGraph.DrawCircle(CenterX, CenterY, Radius, Item.Color, True, 0)
			Else
				StartAngle = StartAngle + Angle + Graph.PieGapDegrees
				Private x, y As Int
				Private txt As String
				MidAngle = StartAngle - Angle /2 - Graph.PieGapDegrees
				x = CenterX + RadiusText * CosD(MidAngle)
				y = CenterY + RadiusText * SinD(MidAngle) + 5dip
				Percentage = Item.Value / Total * 100
				txt = NumberFormat2(Percentage, 1, mPiePercentageNbFractions, mPiePercentageNbFractions, False) & " %"
				xcvsGraph.DrawText(txt, x, y, Texts.AxisFont, GetContrastColor(Item.Color), "CENTER")
			End If
		Next
	End If
	
	If Legend.IncludeLegend <> "NONE" And Items.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'gets the x intervals and x scale for LINE charts
Private Sub GetXIntervals
	Private I As Int
	
	Scale(sX).Scale = Graph.Width / (Points.Size - 1)
	
	For i = 0 To Points.Size - 1
		Private PD As PointData
		PD = Points.Get(I)
		If PD.ShowTick = True Then
			Scale(sX).NbIntervals = Scale(sX).NbIntervals + 1
		End If
	Next
	Scale(sX).Scale = Graph.Width / (Points.Size - 1)
End Sub

'clears all data, not the title nor axis names
Public Sub ClearData
	Items.Clear
	Points.Clear
End Sub

'clears all points, not the title nor axis names
Public Sub ClearPoints
	Private l As Int
	Private ID As ItemData
	
	Points.Clear
	If Graph.ChartType = "YX_CHART" And Items.Size > 0 Then
		For l = 0 To Items.Size - 1
			ID = Items.Get(l)
			ID.YXArray.Initialize
		Next
	End If
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
	Return rct.Width
End Sub

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
'	Return rct.Width
	Return rct.Height
End Sub

'returns white for a dark color or returns black for a light color for a good contrast between bachground and text colors
Private Sub GetContrastColor(Color As Int) As Int
	Private a, r, g, b, yiq As Int	'ignore
	
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	yiq = r * 0.299 + g * 0.587 + b * 0.114
	
	If yiq > 128 Then
		Return xui.Color_Black
	Else
		Return xui.Color_White
	End If
End Sub

'draws the legend
Private Sub DrawLegend
'	Private y As Int = 1.2 * Legend.TextHeight
	Private y, y1, w, x As Int
	Private h As Int = 1.8 * Legend.TextHeight
	Private box As Int = 0.8 * Legend.TextHeight
'	Private textVerticalOffset As Int = 0.38 * Legend.TextHeight
	Private textVerticalOffset As Int = 0.3 * Legend.TextHeight
	If xui.IsB4i Then textVerticalOffset = 0.45 * Legend.TextHeight
	Private i As Int
	Private r As B4XRect
	
	y = 1.2 * Legend.TextHeight
	y = Graph.Top + 0.5 * box
	Select Legend.IncludeLegend
		Case "TOP_RIGHT"
			h = Texts.AxisTextHeight * 1.2
			For Each Item As ItemData In Items
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & Item.Value
				End If
				w = Max(w, MeasureTextWidth(txt, Legend.TextFont))
			Next
			w = w + 2 * box + 1.5 * Texts.AxisTextHeight
'			x = xcvsGraph.TargetRect.Width - w - 0.5 * box
			x = Graph.Right - w - 0.5 * box
			r.Initialize(x - box, y - 0.5 * box, x + w, y + h * Items.Size + 0.5 * box)
			If Graph.ChartBackgroundColor = xui.Color_Transparent Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 0)
			Else
				xcvsGraph.DrawRect(r, 0x66FFFFFF, True, 0)
			End If
			For Each Item As ItemData In Items
				Private top As Int = y + h * i
				r.Initialize(x, top + 0.5 * h - 0.65 * box, x + box, top + 0.5 * h + 0.35 * box)
				xcvsGraph.DrawRect(r, Item.Color, True, 0)
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & Item.Value
				End If
				xcvsGraph.DrawText(txt, x + box + box, top + 0.5 * h + textVerticalOffset, Legend.TextFont, xui.Color_Black, "LEFT")
				i = i + 1
			Next
		Case "BOTTOM"
			Private x, y0, y As Int
			Private i As Int
			Private r As B4XRect
			
			y0  = xcvsGraph.TargetRect.Height - Legend.Height + 0.9 * Legend.TextHeight
			x = box

			r.Initialize(0.5 * box, xcvsGraph.TargetRect.Height - Legend.Height - 0.5 * box, xcvsGraph.TargetRect.Width - 0.5 * box, xcvsGraph.TargetRect.Height - 0.5 * box)
			If Graph.ChartBackgroundColor = xui.Color_Transparent Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 0)
			Else
				xcvsGraph.DrawRect(r, 0x66FFFFFF, True, 0)
			End If
			
			For i = 0 To Items.Size - 1
				Private Item As ItemData
				Item = Items.Get(i)
				y = y0 + 1.6 * box * Legend.LineNumbers.Get(i)
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & Item.Value
				End If
				If Legend.LineChange.Get(i) = True Then
					x = box				
				End If

				r.Initialize(x, y - box, x + box, y)
				xcvsGraph.DrawRect(r, Item.Color, True, 0)
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & Item.Value
				End If
				
				#If B4A
					y1 = y '+ 0.1 * box
				#Else If B4i
					y1 = y + 0.3 * box
				#Else
					y1 = y '- 0.1 * box
				#End If
				xcvsGraph.DrawText(txt, x + 1.5 * box, y1, Legend.TextFont, xui.Color_Black, "LEFT")
				x = x + 2.5 * box + MeasureTextWidth(txt, Legend.TextFont)
			Next
	End Select
End Sub

'gets the number of lines for the BOTTOM legend and the line changes
Private Sub GetLegendLineNumbers(Limit As Int)
	Private x As Int
	Private box As Int = 1.05 * Legend.TextHeight
	
	Legend.LineNumber = 1
	Legend.LineNumbers.Clear
	Legend.LineChange.Clear
	
	Private AllTooBig = False As Boolean
	
	For i = 0 To Items.Size - 1
		Private Item As ItemData
		Item = Items.Get(i)
		Private txt As String = Item.Name
		If Graph.ChartType = "PIE" And Legend.IncludeLegend = "BOTTOM" And Graph.IncludeValues = True Then
			txt = txt & " : " & Item.Value
		End If
		If 2.5 * box + MeasureTextWidth(txt, Legend.TextFont) > Limit Then
			AllTooBig = True
		End If
	Next
	
	If AllTooBig = True Then
		Legend.LineNumber = Items.Size
		For i = 0 To Items.Size - 1
			Legend.LineChange.Add(True)
			Legend.LineNumbers.Add(i)
		Next
	Else
		x = 0
		For i = 0 To Items.Size - 1
			Private Item As ItemData
			Item = Items.Get(i)
			Private txt As String = Item.Name
			If Graph.ChartType = "PIE" And Legend.IncludeLegend = "BOTTOM" And Graph.IncludeValues = True Then
				txt = txt & " : " & Item.Value
			End If
			x = x + 2.5 * box + MeasureTextWidth(txt, Legend.TextFont)
			If x > Limit Then
				x = 2.5 * box + MeasureTextWidth(txt, Legend.TextFont)
				Legend.LineNumber = Legend.LineNumber + 1
				Legend.LineChange.Add(True)
			Else
				Legend.LineChange.Add(False)
			End If
			Legend.LineNumbers.Add(Legend.LineNumber - 1)
		Next
	End If
End Sub

'formats a number with scientific notation
'MaxDigits = number max of digits
'Examples: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.23E10
Public Sub NumberFormat3(Number As Double, MaxDigits As Int) As String
	Private mant, exp, lng, lng2 As Double
	Private str, strMinus As String
	
	If Abs(Number) < 1e-11 Then Return "0"
	
	If Number < 0 Then
		strMinus = "-"
	Else
		strMinus = ""
	End If
	lng = Logarithm(Abs(Number), 10)
	exp = Floor(lng)
	If exp < 0 Then
		lng2 = Floor(lng)
		lng = -lng2 + lng
	Else
		lng = lng - exp
	End If
	
	If exp < MaxDigits And exp > -5 Then
		str = NumberFormat2(Number, 1, MaxDigits - 1 - exp, 0, False)
	Else If exp <= -5 And exp > -7 Then
		str = NumberFormat2(Number, 1, 9, 0, False)
	Else
		mant = Power(10, lng)
		str = strMinus & NumberFormat2(mant, 1, MaxDigits - 1, 0, False)
		str = str & "E" & exp
	End If
	
	Return str
End Sub

'gets or sets the Chart title
Public Sub getTitle As String
	Return Graph.Title
End Sub

Public Sub setTitle(Title As String)
	Graph.Title = Title
End Sub

'gets or sets the X axis name
Public Sub getXAxisName As String
	Return Graph.XAxisName
End Sub

Public Sub setXAxisName(XAxisName As String)
	Graph.XAxisName = XAxisName
End Sub

'gets or sets the Y axis name
Public Sub getYAxisName As String
	Return Graph.YAxisName
End Sub

Public Sub setYAxisName(YAxisName As String)
	Graph.YAxisName = YAxisName
End Sub

'gets or sets the Y scale max value
'works only with AutomaticScale = False
'setting XScaleMaxValue sets automatically AutomaticScale = False
Public Sub getYScaleMaxValue As Double
	Return Scale(sY(0)).MaxVal
End Sub

Public Sub setYScaleMaxValue(YScaleMaxValue As Double)
	Scale(sY(0)).MaxManu = YScaleMaxValue
	Scale(sY(0)).MaxVal = YScaleMaxValue
	Scale(sY(0)).Automatic = False
End Sub

'gets or sets the Y scale min value
'works only with AutomaticScale = False
'setting XScaleMaxValue sets automatically AutomaticScale = False
Public Sub getYScaleMinValue As Double
	Return Scale(sY(0)).MinVal
End Sub

Public Sub setYScaleMinValue(YScaleMinValue As Double)
	Scale(sY(0)).MinManu = YScaleMinValue
	Scale(sY(0)).MinVal = YScaleMinValue
	Scale(sY(0)).Automatic = False
End Sub

'gets or sets the X scale max value
'works only with AutomaticScale = False
'setting XScaleMaxValue sets automatically AutomaticScale = False
'valid only for YXChats
Public Sub getXScaleMaxValue As Double
	Return Scale(sX).MaxVal
End Sub

Public Sub setXScaleMaxValue(XScaleMaxValue As Double)
	Scale(sX).MaxManu = XScaleMaxValue
	Scale(sX).MaxVal = XScaleMaxValue
	Scale(sX).Automatic = False
End Sub

'gets or sets the X scale min value
'works only with AutomaticScale = False
'setting XScaleMinValue sets automatically AutomaticScale = False
'valid only for YXChats
Public Sub getXScaleMinValue As Double
	Return Scale(sX).MinVal
End Sub

Public Sub setXScaleMinValue(XScaleMinValue As Double)
	Scale(sX).MinManu = XScaleMinValue
	Scale(sX).MinVal = XScaleMinValue
	Scale(sX).Automatic = False
End Sub

'gets or sets the IncludeLegend property
'possible values: NONE, TOP_RIGHT, BOTTOM
Public Sub getIncludeLegend As String
	Return Legend.IncludeLegend
End Sub

Public Sub setIncludeLegend(IncludeLegend As String)
	Legend.IncludeLegend = IncludeLegend
End Sub

'gets or sets the IncludeValues property
'possible only for single bar charts or pie charts with TOP_RIGHT legend
Public Sub getIncludeValues As Boolean
	Return Graph.IncludeValues
End Sub

Public Sub setIncludeValues(IncludeValues As Boolean)
	Graph.IncludeValues = IncludeValues
End Sub

'gets or sets the IncludeBarMeanLine property
'possible only for single bar charts
Public Sub getIncludeBarMeanLine As Boolean
	Return Graph.IncludeBarMeanLine
End Sub

Public Sub setIncludeBarMeanLine(IncludeBarMeanLine As Boolean)
	Graph.IncludeBarMeanLine = IncludeBarMeanLine
End Sub

'gets or sets the AutomaticScale property
'if True, the scales are automatically calculated to fill the chart, with 1, 2, 2.5, 5 standardized scales
Public Sub getAutomaticScale As Boolean
	Return Scale(sY(0)).Automatic
End Sub

Public Sub setAutomaticScale(AutomaticScale As Boolean)
	Scale(sY(0)).Automatic = AutomaticScale
	Scale(sY(1)).Automatic = AutomaticScale
	Scale(sY(2)).Automatic = AutomaticScale
	Scale(sY(3)).Automatic = AutomaticScale
	Scale(sX).Automatic = AutomaticScale
End Sub

'gets or sets the DifferentScales property, only for LINE and YX_CHART charts.
'when True, displays the lines with different automatic scales for two up to four lines.
'if the number of lines is smaller than 2 and bigger than 4, then all lines have the same scale.
Public Sub getDifferentScales As Boolean
	Return Scale(sY(0)).Different
End Sub

Public Sub setDifferentScales(DifferentScales As Boolean)
	Scale(sY(0)).Different = DifferentScales
	Scale(sY(1)).Different = DifferentScales
	Scale(sY(2)).Different = DifferentScales
	Scale(sY(3)).Different = DifferentScales
End Sub

'gets or sets the X scale text orientation
'Possible values: VERTICAL, HORIZONTAL, 45 DEGREES
Public Sub getXScaleTextOrientation As String
	Return Graph.XScaleTextOrientation
End Sub

Public Sub setXScaleTextOrientation(XScaleTextOrientation As String)
	Graph.XScaleTextOrientation = XScaleTextOrientation
End Sub

'gets or sets the chart type
'Possible values: LINE, BAR, STACKED_BAR, PIE, YX_CHART
Public Sub getChartType As String
	Return Graph.ChartType
End Sub

Public Sub setChartType(ChartType As String)
	If ChartType = "BAR" Or ChartType = "STACKED_BAR" Or ChartType = "LINE" Or ChartType = "PIE" Then
		Graph.ChartType = ChartType
	Else
		Log("Wrong chart type")
	End If
End Sub

'gets or sets the Left property
Public Sub getLeft As Int
	Return xBase.Left
End Sub

Public Sub setLeft(Left As Int)
	xBase.Left = Left
End Sub

'gets or sets the Top property
Public Sub getTop As Int
	Return xBase.Top
End Sub

Public Sub setTop(Top As Int)
	xBase.Top = Top
End Sub

'gets or sets the Top property
Public Sub getTag As Object
	Return xBase.Tag
End Sub

Public Sub setTag(Tag As Object)
	xBase.Tag = Tag
End Sub

'gets or sets the Width property
Public Sub getWidth As Int
	Return xBase.Width
End Sub

Public Sub setWidth(Width As Int)
	xBase.Width = Width
	Base_Resize(Width, xBase.Height)
End Sub

'gets or sets the Height property
Public Sub getHeight As Int
	Return xBase.Height
End Sub

Public Sub setHeight(Height As Int)
	xBase.Height = Height
	Base_Resize(xBase.Width, Height)
End Sub

'gets or sets the Visible property
Public Sub getVisible As Boolean
	Return xBase.Visible
End Sub

Public Sub setVisible(Visible As Boolean)
	xBase.Visible = Visible
End Sub

'gets or sets the AutomaticTextSizes property
'if True, the text sizes are automatically calculated according to the chart size
Public Sub getAutomaticTextSizes As Boolean
	Return Texts.AutomaticTextSizes
End Sub

Public Sub setAutomaticTextSizes(AutomaticTextSizes As Boolean)
	Texts.AutomaticTextSizes = AutomaticTextSizes
End Sub

'gets or sets the TitleTextSize property
'setting this text size sets automatically AutomaticTextSizes = False
Public Sub getTitleTextSize As Float
	Return Texts.TitleTextSize
End Sub

Public Sub setTitleTextSize(TitleTextSize As Float)
	Texts.TitleTextSize = TitleTextSize
	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'gets or sets the AxisTextSize property
'setting this text size sets automatically AutomaticTextSizes = False
Public Sub getAxisTextSize As Float
	Return Texts.AxisTextSize
End Sub

Public Sub setAxisTextSize(AxisTextSize As Float)
	Texts.AxisTextSize = AxisTextSize
	Texts.AxisFont = xui.CreateDefaultFont(Texts.AxisTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'gets or sets the ScaleTextSize property
'setting this text size sets automatically AutomaticTextSizes = False
Public Sub getScaleTextSize As Float
	Return Texts.ScaleTextSize
End Sub

Public Sub setScaleTextSize(ScaleTextSize As Float)
	Texts.ScaleTextSize = ScaleTextSize
	Texts.ScaleFont = xui.CreateDefaultFont(Texts.ScaleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'gets or sets the LegendTextSize property
'setting this text size sets automatically AutomaticTextSizes = False
Public Sub getLegendTextSize As Float
	Return Legend.TextSize
End Sub

Public Sub setLegendTextSize(LegendTextSize As Float)
	Legend.TextSize = LegendTextSize
	Legend.TextFont = xui.CreateDefaultFont(Legend.TextSize)
	Texts.AutomaticTextSizes = False
End Sub

'gets or sets the ValuesTextSize property
'setting this text size sets automatically AutomaticTextSizes = False
Public Sub getValuesTextSize As Float
	Return Values.TextSize
End Sub

Public Sub setValuesTextSize(ValuesTextSize As Float)
	Values.TextSize = ValuesTextSize
	Values.TextFont = xui.CreateDefaultFont(Values.TextSize)
	Texts.AutomaticTextSizes = False
End Sub

'gets or sets the DisplayValues property
'if True, displays the point values when moving the finger or the cursor on the chart.
Public Sub getDisplayValues As Boolean
	Return Values.Show
End Sub

Public Sub setDisplayValues(DisplayValues As Boolean)
	Values.Show = DisplayValues
End Sub

'gets or sets the ScaleValues property
'it is a string  with the different scale values separated by the exclamation mark.
'it must begin with 1! and end with !10
'Example: the default property 1!2!2.5!5!10
Public Sub getScaleValues As String
	Return Scale(sY(0)).ScaleValues
End Sub

Public Sub setScaleValues(ScaleValues As String)
	If ScaleValues.StartsWith("1!") = False Or ScaleValues.EndsWith("!10") = False Then
		Log("Wrong ScaleValues property")
		Return
	End If
	Scale(sY(0)).ScaleValues = ScaleValues
	Scale(sY(1)).ScaleValues = ScaleValues
	Scale(sY(2)).ScaleValues = ScaleValues
	Scale(sY(3)).ScaleValues = ScaleValues
End Sub

'gets or sets the ScaleYValuesLog property
'it is a string  with the different scale values, for one decade, separated by the exclamation mark.
'it must begin with 1! and end with !10
'only for LINE Y scale and YX_CHART Y scale
'Example: the default property 1!2!5!7!10
Public Sub getScaleYValuesLog As String
	Return ScaleLog(sY(0)).ScaleValues
End Sub

Public Sub setScaleYValuesLog(ScaleYValuesLog As String)
	If ScaleYValuesLog.StartsWith("1!") = False Or ScaleYValuesLog.EndsWith("!10") = False Then
		Log("Wrong ScaleYValuesLog property")
		Return
	End If
	ScaleLog(sY(0)).ScaleValues = ScaleYValuesLog
End Sub

'gets or sets the ScaleXValuesLog property
'it is a string  with the different scale values, for one decade, separated by the exclamation mark.
'it must begin with 1! and end with !10
'only for YX_CHART X scale
'Example: the default property 1!2!5!7!10
Public Sub getScaleXValuesLog As String
	Return ScaleLog(sX).ScaleValues
End Sub

Public Sub setScaleXValuesLog(ScaleXValuesLog As String)
	If ScaleXValuesLog.StartsWith("1!") = False Or ScaleXValuesLog.EndsWith("!10") = False Then
		Log("Wrong ScaleXValuesLog property")
		Return
	End If
	ScaleLog(sX).ScaleValues = ScaleXValuesLog
End Sub

'gets or sets the DrawXScale property
'True by default, if False doesn't draw the X scale values
'not drawing the scale can be useful for small charts
'not for logarithmic scales.
Public Sub getDrawXScale As Boolean
	Return Scale(sX).DrawXScale
End Sub

Public Sub setDrawXScale(DrawXScale As Boolean)
	Scale(sX).DrawXScale = DrawXScale
End Sub

'gets or sets the DrawYScale property
'True by default, if False doesn't draw the Y scale values
'not drawing the scale can be useful for small charts
'not for logarithmic scales.
Public Sub getDrawYScale As Boolean
	Return Scale(sY(0)).DrawYScale
End Sub

Public Sub setDrawYScale(DrawYScale As Boolean)
	Scale(sY(0)).DrawYScale = DrawYScale
	Scale(sY(1)).DrawYScale = DrawYScale
	Scale(sY(2)).DrawYScale = DrawYScale
	Scale(sY(3)).DrawYScale = DrawYScale
End Sub

'gets or sets the GradientColors property
'gradient colors are used in PIE and BAR charts
Public Sub getGradientColors As Boolean
	Return Graph.GradientColors
End Sub

Public Sub setGradientColors(GradientColors As Boolean)
	Graph.GradientColors = GradientColors
End Sub

'gets or sets the GradientColorsAlpha property
'values between 0 and 255
'setting this value, set automatically the GradientColors property to True
Public Sub getGradientColorsAlpha As Int
	Return Graph.GradientColorsAlpha
End Sub

Public Sub setGradientColorsAlpha(GradientColorsAlpha As Int)
	Graph.GradientColorsAlpha = GradientColorsAlpha
	Graph.GradientColorsAlpha = Max(0, Graph.GradientColorsAlpha)
	Graph.GradientColorsAlpha = Min(255, Graph.GradientColorsAlpha)
End Sub

'sets the ChartBackgroundColor property
'the color must be an xui.Color
'Example code: <code>xChart1.ChartBackgroundColor = xui.Color_RGB(207, 220, 220)</code>
Public Sub setChartBackgroundColor(Color As Int)
	Graph.ChartBackgroundColor = Color
End Sub
	
'sets the GridFrameColor property
'the color must be an xui.Color
'Example code: <code>xChart1.GridFrameColor = xui.Color_Blue</code>
Public Sub setGridFrameColor(Color As Int)
	Graph.GridFrameColor = Color
End Sub
	
'sets the GridColor property
'the color must be an xui.Color
'Example code: <code>xChart1.GridColor = xui.Color_RGB(169, 169, 169)</code>
Public Sub setGridColor(Color As Int)
	Graph.GridColor = Color
End Sub

'sets or gets the DrawGridFrame property, True by default
'if False, no frame, only the X and Y axes are drawn
Public Sub setDrawGridFrame(DrawGridFrame As Boolean)
	Graph.DrawGridFrame = DrawGridFrame
End Sub

Public Sub getDrawGridFrame As Boolean
	Return Graph.DrawGridFrame
End Sub

'sets or gets the DrawHorizontalGridLines property, True by default
'if False, no horizontal grid lines are drawn
Public Sub setDrawHorizontalGridLines(DrawHorizontalGridLines As Boolean)
	Graph.DrawHorizontalGridLines = DrawHorizontalGridLines
End Sub

Public Sub getDrawHorizontalGridLines As Boolean
	Return Graph.DrawHorizontalGridLines
End Sub

'sets or gets the DrawVerticalGridLines property, True by default
'if False, no vertical grid lines are drawn
Public Sub setDrawVerticalGridLines(DrawVerticalGridLines As Boolean)
	Graph.DrawVerticalGridLines = DrawVerticalGridLines
End Sub

Public Sub getDrawVerticalGridLines As Boolean
	Return Graph.DrawVerticalGridLines
End Sub

'sets the TitleTextColor property
'the color must be an xui.Color
'Example code: <code>xChart1.TitleTextColor = xui.Color_Black</code>
Public Sub setTitleTextColor(Color As Int)
	Texts.TitleTextColor = Color
End Sub

'sets the AxisTextColor property
'the color must be an xui.Color
'Example code: <code>xChart1.AxisTextColor = xui.Color_Black</code>
Public Sub setAxisTextColor(Color As Int)
	Texts.AxisTextColor = Color
End Sub

'sets the ScaleTextColor property
'the color must be an xui.Color
'Example code: <code>xChart1.ScaleTextColor = xui.Color_Blue</code>
Public Sub setScaleTextColor(Color As Int)
	Texts.ScaleTextColor = Color
End Sub

'sets the ValuesTextColor property	
'the color must be an xui.Color
'Example code: <code>xChart1.ValuesTextColor = xui.Color_Black</code>
Public Sub setValuesTextColor(Color As Int)
	Values.TextColor = Color
End Sub

'sets the single line chart MinLineColor property	
'the color must be an xui.Color
'Example code: <code>xChart1.MinLineColor = xui.Color_RGB(0, 128, 0)</code>
Public Sub setMinLineColor(Color As Int)
	Graph.MinLineColor = Color
End Sub

'sets the single line chart MaxLineColor property	
'the color must be an xui.Color
'Example code: <code>xChart1.MaxLineColor = xui.Color_Red</code>
Public Sub setMaxLineColor(Color As Int)
	Graph.MaxLineColor = Color
End Sub

'sets the MeanLineColor property valid for single line and single bar charts 
'the color must be an xui.Color
'Example code: <code>xChart1.MeanLineColor = xui.Color_RGB(182, 74, 26)</code>
Public Sub setMeanLineColor(Color As Int)
	Graph.MeanLineColor = Color
End Sub

'gets or sets the NbYIntervals property, number of Y axis intervals
'should be an even number, otherwise the 0 scale value might not be displayed
Public Sub getNbYIntervals As Int
	Return Scale(sY(0)).NbIntervals
End Sub

Public Sub setNbYIntervals (NbYIntervals As Int)
	Scale(sY(0)).NbIntervals = NbYIntervals
	Scale(sY(1)).NbIntervals = NbYIntervals
	Scale(sY(2)).NbIntervals = NbYIntervals
	Scale(sY(3)).NbIntervals = NbYIntervals
End Sub

'gets or sets the NbYIntervals property, number of X axis intervals
'should be an even number, otherwise the 0 scale value might not be displayed
'valid only for YXCharts
Public Sub getNbXIntervals As Int
	Return Scale(sX).NbIntervals
End Sub

Public Sub setNbXIntervals (NbXIntervals As Int)
	Scale(sX).NbIntervals = NbXIntervals
End Sub

'gets or sets the YZeroAxis property for LINE and BAR charts
'if all values are positives, sets the lower Y scale to zero
'if all values are negatives, sets the upper Y scale to zero
Public Sub getYZeroAxis As Boolean
	Return Scale(sY(0)).YZeroAxis
End Sub

Public Sub setYZeroAxis (YZeroAxis As Boolean)
	Scale(sY(0)).YZeroAxis = YZeroAxis
	Scale(sY(1)).YZeroAxis = YZeroAxis
	Scale(sY(2)).YZeroAxis = YZeroAxis
	Scale(sY(3)).YZeroAxis = YZeroAxis
End Sub

'gets or sets the YZeroAxisHighlight property
'if True draws the Y Zero axis 2dip thick otherwise with 1dip
Public Sub getYZeroAxisHighlight As Boolean
	Return Scale(sY(0)).YZeroAxisHighlight
End Sub

Public Sub setYZeroAxisHighlight (YZeroAxisHighlight As Boolean)
	Scale(sY(0)).YZeroAxisHighlight = YZeroAxisHighlight
	Scale(sY(1)).YZeroAxisHighlight = YZeroAxisHighlight
	Scale(sY(2)).YZeroAxisHighlight = YZeroAxisHighlight
	Scale(sY(3)).YZeroAxisHighlight = YZeroAxisHighlight
End Sub

'gets the number of points (read only)
Public Sub getNbPoints As Int
	Return Points.Size
End Sub

'returns a B4XBitmap object of the chart (read only)
Public Sub getSnapshot As B4XBitmap
	Return xBase.Snapshot
End Sub

'gets or sets the Rotation property of the Chart
'rotates the entire chart
'Rotation in degrees
Public Sub getRotation As Double
	Return Graph.Rotation
End Sub

Public Sub setRotation (Rotation As Double)
	Graph.Rotation = Rotation
	xBase.Rotation = Graph.Rotation
End Sub

'gets or sets the DrawOuterFrame property of the Chart
'draws an outer frame around the chart
Public Sub getDrawOuterFrame As Boolean
	Return Graph.DrawOuterFrame
End Sub

Public Sub setDrawOuterFrame (DrawOuterFrame As Boolean)
	Graph.DrawOuterFrame = DrawOuterFrame
End Sub

'gets or sets the IncludeMinLine property, only for single line Chart
'inserts a line at the level of the min value
Public Sub getIncludeMinLine As Boolean
	Return Graph.IncludeMinLine
End Sub

Public Sub setIncludeMinLine (IncludeMinLine As Boolean)
	Graph.IncludeMinLine = IncludeMinLine
'	DrawChart	'removed it
End Sub

'gets or sets the IncludenMaxLine property, only for single line Chart
'inserts a line at the level of the max value
Public Sub getIncludeMaxLine As Boolean
	Return Graph.IncludeMaxLine
End Sub

Public Sub setIncludeMaxLine (IncludeMaxLine As Boolean)
	Graph.IncludeMaxLine = IncludeMaxLine
'	DrawChart	'removed it
End Sub

'gets or sets the IncludeMeanLine property, only for single line Chart
'inserts a line at the level of the mean value
Public Sub getIncludeMeanLine As Boolean
	Return Graph.IncludeMeanLine
End Sub

Public Sub setIncludeMeanLine (IncludeMeanLine As Boolean)
	Graph.IncludeMeanLine = IncludeMeanLine
'	DrawChart	'removed it
End Sub

'removes the data of the point with the given index
Public Sub RemovePointData(Index As Int)
	Points.RemoveAt(Index)
End Sub

'sets a custom numberformat for the bar mean line value, values like NumberFormat2
'if set, it overides the default format
'to go back to the default format, comment the line defining the custom number format
Public Sub SetBarMeanValueFormat(MinimumIntegers As Int, MaximumFractions As Int, MinimumFractions As Int, GroupingUsed As Boolean)
	BMVNFUsed = True
	BMVNF.MinimumIntegers = MinimumIntegers
	BMVNF.MaximumFractions = MaximumFractions
	BMVNF.MinimumFractions = MinimumFractions
	BMVNF.GroupingUsed = GroupingUsed
End Sub

'gets or sets the Subtitle property
Public Sub getSubtitle As String
	Return Graph.Subtitle
End Sub

Public Sub setSubtitle(Subtitle As String)
	Graph.Subtitle = Subtitle
End Sub

'gets or sets the SubtitleTextSize property
'setting this text size sets automatically AutomaticTextSizes = False
Public Sub getSubtitleTextSize As Float
	Return Texts.AxisTextSize
End Sub

Public Sub setSubtitleTextSize(SubtitleTextSize As Float)
	Texts.SubtitleTextSize = SubtitleTextSize
	Texts.SubtitleFont = xui.CreateDefaultFont(Texts.SubtitleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'sets the SubitleTextColor property
'the color must be an xui.Color
'Example code: <code>xChart1.SubitleTextColor = xui.Color_Black</code>
Public Sub setSubitleTextColor(Color As Int)
	Texts.SubtitleTextColor = Color
End Sub

'gets or sets the BarValueOrientation property
'Possible values: VERTICAL, HORIZONTAL
Public Sub getBarValueOrientation As String
	Return Graph.BarValueOrientation
End Sub

Public Sub setBarValueOrientation(BarValueOrientation As String)
	If BarValueOrientation = "HORIZONTAL" Or BarValueOrientation = "VERTICAL" Then
		Graph.BarValueOrientation = BarValueOrientation
	Else
		Log("Error: wrong BarValueOrientation value")
	End If
End Sub

'gets or sets the number of fractions for pie percentage values
'min = 0  max = 2
Public Sub getPiePercentageNbFractions As Int
	Return mPiePercentageNbFractions
End Sub

Public Sub setPiePercentageNbFractions(PiePercentageNbFractions As Int)
	mPiePercentageNbFractions = Max(PiePercentageNbFractions, 0)
	mPiePercentageNbFractions = Min(mPiePercentageNbFractions, 2)
End Sub

'gets or sets the Y scale to logarithmic
'valid only for positive numbers and for LINE and YX_CHART
Public Sub getYScaleLogaritmic As Boolean
	Return Scale(sY(0)).Logarithmic
End Sub

Public Sub setYScaleLogaritmic(YScaleLogarithmic As Boolean)
	Scale(sY(0)).Logarithmic = YScaleLogarithmic
End Sub

'gets or sets the X scale to logarithmic
'valid only for positive numbers and for YX_CHART
Public Sub getXScaleLogarithmic As Boolean
	Return Scale(sX).Logarithmic
End Sub

Public Sub setXScaleLogarithmic(XScaleLogarithmic As Boolean)
	Scale(sX).Logarithmic = XScaleLogarithmic
End Sub

'gets or sets the X Min scale value
Public Sub getXMinValue As Double
	Return Scale(sX).MinManu
End Sub

Public Sub setXMinValue(MinValue As Double)
	Scale(sX).MinManu = MinValue
	Scale(sX).MinVal = MinValue
End Sub

'gets or sets the X Max scale value
Public Sub getXMaxValue As Double
	Return Scale(sX).MaxManu
End Sub

Public Sub setXMaxValue(MaxValue As Double)
	Scale(sX).MaxManu = MaxValue
	Scale(sX).MaxVal = MaxValue
End Sub

'gets or sets the Y Min scale value
Public Sub getYMinValue As Double
	Return Scale(sY(0)).MinManu
End Sub

Public Sub setYMinValue(MinValue As Double)
	Scale(sY(0)).MinManu = MinValue
	Scale(sY(0)).MinVal = MinValue
End Sub

'gets or sets the Y Max scale value
Public Sub getYMaxValue As Double
	Return Scale(sY(0)).MaxManu
End Sub

Public Sub setYMaxValue(MaxValue As Double)
	Scale(sY(0)).MaxManu = MaxValue
	Scale(sY(0)).MaxVal = MaxValue
End Sub

#If B4i
Private Sub Round2(Number As Double, DecimalPlaces As Int) As Double
	Private str As String
	
	str = NumberFormat(Number, 1, DecimalPlaces)
	Number = str
	Return Number
End Sub
#End If

