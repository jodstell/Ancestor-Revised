Imports LinqToExcel
Imports CoreLibrary

Public Class ImportAccounts
    Inherits System.Web.UI.Page
    Dim db As New DataClassesDataContext
    Dim count As Integer = 0
    Dim failed As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Private Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click

        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts1.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts") _
                        Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try



    End Sub

    Private Sub btnImport2_Click(sender As Object, e As EventArgs) Handles btnImport2.Click

        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts2.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts") _
                        Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub btnImport3_Click(sender As Object, e As EventArgs) Handles btnImport3.Click

        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts3.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts") _
                        Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub btnImport4_Click(sender As Object, e As EventArgs) Handles btnImport4.Click

        Try

            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts4.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts") _
                        Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub btnImport5_Click(sender As Object, e As EventArgs) Handles btnImport5.Click

        Try

            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts5.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts") _
                        Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try

    End Sub

    Private Sub btnImport6_Click(sender As Object, e As EventArgs) Handles btnImport6.Click
        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts6.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts")
                           Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub btnImport7_Click(sender As Object, e As EventArgs) Handles btnImport7.Click
        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts7.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts")
                           Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub btnImport8_Click(sender As Object, e As EventArgs) Handles btnImport8.Click
        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts8.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts")
                           Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub

    Private Sub btnImport9_Click(sender As Object, e As EventArgs) Handles btnImport9.Click
        Try
            count = 0

            Dim excel = New ExcelQueryFactory(Server.MapPath("/Import/Accounts9.xls"))

            ' Dim book = New LinqToExcel.ExcelQueryFactory(excel)

            Dim accounts = From x In excel.Worksheet(Of AccountList)("accounts")
                           Select x

            For Each u In accounts
                Try
                    Dim i As New tblAccount With {.accountID = u.ID, .Vpid = u.Vpid, .accountName = u.AccountName, .streetAddress1 = u.StreetAddress1, .city = u.City, .state = u.State, .zipCode = u.Zip, .accountTypeName = u.AccountType, .marketName = u.Market}

                    db.tblAccounts.InsertOnSubmit(i)
                    db.SubmitChanges()

                    count = count + 1
                Catch ex As Exception
                    failed = failed + 1
                End Try

            Next

            msgLabel.Text = count & " records have been added.  " & failed & " records failed."
        Catch ex As Exception
            msgLabel.Text = ex.Message
        End Try
    End Sub
End Class