Imports Telerik.Web.UI
Imports System
Imports System.Web.UI.WebControls
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports BingGeocoder
Imports Microsoft.AspNet.Identity.EntityFramework
Imports System.Drawing

Public Class AddUserControl
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub AccountWizard_FinishButtonClick(sender As Object, e As WizardEventArgs) Handles AccountWizard.FinishButtonClick

        Try
            'add asp.net user and roles
            Dim userName As String = userNameTextBox.Text
            Dim manager = New UserManager()
            manager.UserValidator = New UserValidator(Of ApplicationUser)(manager) With {.AllowOnlyAlphanumericUserNames = False}

            Dim user = New ApplicationUser() With {.UserName = userName}
            Dim result = manager.Create(user, passwordTextBox.Text)
            If result.Succeeded Then
                user.Email = emailAdressTextBox.Text
                manager.Update(user)

                Dim collection As IList(Of RadListBoxItem) = RolesListBox.CheckedItems

                For Each item As RadListBoxItem In collection
                    manager.AddToRole(user.Id, item.Value)
                    manager.Update(user)
                Next

            End If

        Catch ex As Exception

        End Try


    End Sub

    Private Sub EnableAllClientsCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllClientsCheckBox.CheckedChanged
        If EnableAllClientsCheckBox.Checked = True Then
            ClientListBox.Visible = False
        Else
            ClientListBox.Visible = True
        End If
    End Sub

    Private Sub EnableAllMarketsCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllMarketsCheckBox.CheckedChanged

        If EnableAllMarketsCheckBox.Checked = True Then
            MarketListBox.Visible = False
        Else
            MarketListBox.Visible = True
        End If
    End Sub

    Private Sub EnableAllSupplierCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles EnableAllSupplierCheckBox.CheckedChanged
        If EnableAllSupplierCheckBox.Checked = True Then
            SupplierListBox.Visible = False
        Else
            SupplierListBox.Visible = True
        End If
    End Sub
End Class