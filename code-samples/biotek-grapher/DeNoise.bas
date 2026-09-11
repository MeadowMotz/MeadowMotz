Attribute VB_Name = "Module2"
Sub DeNoise()
    Dim src As Range
    Dim dst As Range
    Dim data As Range
    Dim area As Range
    Dim repeat As Integer
    Dim i As Integer
    Dim k As Integer

    ' Get data and user input
    Set src = GetRange("Select the noise data points")
    Set data = GetRange("Select the data points to be de-noised")
    
    If src.Rows.Count <> data.Rows.Count Then
        MsgBox "Selected ranges are not the same shape."
        Exit Sub
    End If

    Set dst = GetRange("Select the destination range")
    If src.Rows.Count <> dst.Rows.Count Then
        MsgBox "Selected ranges are not the same shape."
        Exit Sub
    End If

    repeat = GetIntegerInput("How many rows (on the plate) do you want to repeat?")
    
    Set area = GetRange("Select the cell where you want the first graph to be placed.")

    ' Set de-noised column (dst) to test data - noise data columns
    Dim plate_col as Integer
    For i = 0 To repeat - 1 ' For repeated rows on plate
        Set plate_col = i * (dst.Rows.Count + 2) ' Across each plate col data block
        For k = 0 To dst.Rows.Count - 1 ' For each data point
            Cells(dst.Row + plate_col + k, dst.Column) = Cells(dst.Row + plate_col + k, data.Column) - src.Cells(k + 1, 1)
        Next k
        Cells(dst.Row + plate_col - 1, dst.Column) = "De-noise"
    Next i
    
    Dim blockSize As Integer
    Dim initialArea As Integer
    initialArea = area.Row
    
    ' Graphs
    For i = 0 To repeat - 1
        Set plate_col = i * (dst.Rows.Count + 2) ' Across each plate col data block
        Set area = Cells(initialArea + plate_col, area.Column)
        
        Dim chartShape As Shape
        Dim graph As Chart
        Set chartShape = ActiveSheet.Shapes.AddChart2(240, xlXYScatter)
        Set graph = chartShape.Chart
        
        Do While graph.SeriesCollection.Count > 0
            graph.SeriesCollection(1).Delete
        Loop
        
        ' Plot avg points
        With graph.SeriesCollection.NewSeries
            .XValues = Range(Cells(dst.Row + plate_col, 1), Cells(dst.Row + plate_col + blockSize - 1, 1)) ' X-axis
            .Values = Range(Cells(dst.Row + plate_col, dst.Column), Cells(dst.Row + plate_col + blockSize - 1, dst.Column)) ' Y-axis
            .Name = "Data Points"
        End With
        
        ' Delete extra data points
        With graph
            ' Loop backward because deleting alters the collection index
            For j = .SeriesCollection.Count To 1 Step -1
                If .SeriesCollection(j).Name <> "Data Points" Then
                    .SeriesCollection(j).Delete
                End If
            Next j
        End With

        ' Set axes
        graph.HasTitle = True
        graph.ChartTitle.Text = "De-noise"
        With graph.Axes(xlValue)
            .HasTitle = True
            .AxisTitle.Text = "Absorbance"
            .MinimumScaleIsAuto = True
            .MaximumScaleIsAuto = True
        End With
        With graph.Axes(xlCategory)
            .HasTitle = True
            .AxisTitle.Text = "Time"
            .MinimumScaleIsAuto = True
            .MaximumScaleIsAuto = True
        End With
        
        ' Position the chart on area
        chartShape.Top = area.Top
        chartShape.Left = area.Left
        
        ' Add trendline
        graph.FullSeriesCollection(1).Trendlines.Add Type:=xlLinear, Forward _
            :=0, Backward:=0, DisplayEquation:=1, DisplayRSquared:=1, Name:= _
            "Linear Reg"
        graph.FullSeriesCollection(1).Trendlines(1).DataLabel.Left = 245
        graph.FullSeriesCollection(1).Trendlines(1).DataLabel.Top = 30
    Next i
End Sub

Function GetRange(msg As String) As Range
    Dim userRange As Range

    On Error Resume Next
    Set userRange = Application.InputBox(msg, "Select Range", Type:=8)
    On Error GoTo 0

    If userRange Is Nothing Then
        MsgBox "No range selected.", vbExclamation
        Exit Function
    End If
    Set GetRange = userRange
End Function

Function GetIntegerInput(prompt As String) As Integer
    Dim userInput As Variant

    Do
        userInput = Application.InputBox(prompt, "Enter an Integer", Type:=1)

        ' Handle cancel
        If userInput = False Then
            MsgBox "Cancelled by user.", vbExclamation
            Exit Function
        End If

        ' Check if numeric and whole number
        If IsNumeric(userInput) And userInput = Int(userInput) Then
            GetIntegerInput = CInt(userInput)
            Exit Function
        Else
            MsgBox "Please enter a valid integer.", vbExclamation
        End If
    Loop
End Function


