Sub VBA_Homework():

'INSTRUCTIONS:

'=========================================================================================================================
'Part I
'A script was created to loop through all the stocks for one year & output the following:
    'The ticker symbol.
    'Yearly change from opening price at the beginning of a given year to the closing price at the end of that year.
    'Percent change from opening price at the beginning of a given year to the closing price at the end of that year.
    'Total stock volume of the stock.

'Conditional formatting was used to highlight positive change in green and negative change in red.

'=========================================================================================================================

'Part II - Challenge
'Return the following:
    'The stock with the "Greatest % increase",
    'The stock with the "Greatest % decrease",and
    'The stock with the "Greatest total volume".

'=========================================================================================================================

'Part I:

'Assign Variables via Dimensions:

Dim Ticker As String
Dim Ticker_Vol As Double
Dim Yearly_Change As Double
Dim Percent_Change As Double
Dim Total_Stock_Volume As Long

Dim j As Integer
'Where j is a column
Dim ws As Worksheet

Dim Start_Row As Integer
Dim Last_Row As Long

Dim Value As Double
Last_Row = Cells(Rows.Count, "A").End(xlUp).Row

'For all worksheets
For Each ws In Worksheets
        
        'Column Labels for Part I results
            ws.Range("I1").Value = "Ticker"
            ws.Range("J1").Value = "Yearly Change"
            ws.Range("K1").Value = "Percent Change"
            ws.Range("L1").Value = "Total Stock Volume"
            
        'Row & Column Labels for Part II results
            ws.Range("O2").Value = "Greatest % Increase"
            ws.Range("O3").Value = "Greatest % Decrease"
            ws.Range("O4").Value = "Greatest Total Volume"
                
            ws.Range("P1").Value = "Ticker"
            ws.Range("Q1").Value = "Value"
            
    'Count rows to the last rows for each ws.
        
        j = 0
        Start_Row = 2
        Yearly_Change = 0
        
        'Create a Loop for each row of data as follows:
        
            For i = 2 To Last_Row
                If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                    Ticker_Vol = Ticker_Vol + ws.Cells(i, 7).Value
                    If Ticker_Vol = 0 Then
                        'Print the results in designated column locations
                        ws.Range("I" & 2 + j).Value = ws.Cells(i, 1).Value
                        ws.Range("J" & 2 + j).Value = 0
                        ws.Range("K" & 2 + j).Value = "%" & 0
                        ws.Range("L" & 2 + j).Value = 0
                        
                    Else
                        'Find 1st non-zero starting value
                        If ws.Cells(Start_Row, 3) = 0 Then
                            For find_value = Start_Row To 1
                                If ws.Cells(find_value, 3).Value <> 0 Then
                                    Start = find_value
                                    Exit For
                                End If
                            Next find_value
                        End If
                        
                        'Calculate Yearly Change & Percent Change
                        Yearly_Change = (ws.Cells(i, 6) - ws.Cells(Start_Row, 3))
                        Percent_Change = Round((Yearly_Change / ws.Cells(Start_Row, 3) * 100), 2)
                        
                        'Start next stock ticker
                        Start = i + 1
                        
                        'Print the results in the designated column locations
                        ws.Range("I" & 2 + j).Value = ws.Cells(i, 1).Value
                        ws.Range("J" & 2 + j).Value = Round(Yearly_Change, 2)
                        ws.Range("K" & 2 + j).Value = "%" & Percent_Change
                        ws.Range("L" & 2 + j).Value = Ticker_Vol
                        
                        'Conditional format positive changes in green and negative changes in red
                        Select Case Yearly_Change
                            Case Is > 0
                                ws.Range("J" & 2 + j).Interior.ColorIndex = 4
                            Case Is < 0
                                ws.Range("J" & 2 + j).Interior.ColorIndex = 3
                            Case Is = 0
                                ws.Range("J" & 2 + j).Interior.ColorIndex = 0
                        End Select
                    End If
                    
                    'Reset variables for new stock ticker
                    Ticker_Vol = 0
                    Yearly_Change = 0
                    j = j + 1
                    
            Else
                Ticker_Vol = Ticker_Vol + ws.Cells(i, 7).Value
            
            End If
        
        'Part II - Challenge
        
        Next i
        
        Max = 0
        Min = 0
              
        'Create a loop to find the Greatest % Increase
            For i = 2 To Last_Row
               If ws.Cells(i, 11).Value > Max Then
               Max = ws.Cells(i, 11).Value
               Ticker = ws.Cells(i, 9).Value
               ws.Range("Q2") = Ticker
               ws.Range("P2") = Max * 100 & "%"
            
            End If
            Next i
            
        'Create a loop to find the Greatest % Decrease
            For i = 2 To Last_Row
               If ws.Cells(i, 11).Value < Min Then
               Min = ws.Cells(i, 11).Value
               Ticker = ws.Cells(i, 9).Value
               ws.Range("Q3") = Ticker
               ws.Range("P3") = Min * 100 & "%"
            
            End If
            Next i
       
         'Create a loop to find the Greatest Total Value
            For i = 2 To Last_Row
                If ws.Cells(i, 12).Value > Max Then
                Max = ws.Cells(i, 12).Value
                Ticker = ws.Cells(i, 9).Value
                ws.Range("Q4") = Ticker
                ws.Range("P4") = Max & "0,000"
                                
            End If
            Next i
                  
Next ws

For Each ws In ActiveWorkbook.Worksheets
    ws.Columns.AutoFit
Next ws

End Sub
