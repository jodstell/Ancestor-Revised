Imports System.Xml
Imports System.Xml.Linq

Public Class savedata
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        WriteToFile()



        Dim Counter As Integer
        For Counter = 1 To 2
            Response.Write("The value of loop Counter is " & Counter & "<br>")
        Next


    End Sub

    Sub WriteToFile()

        Try
            Dim xmlDoc As XDocument = XDocument.Load(Server.MapPath("\documents\Events.xml"))

            Dim root As New XElement("Event", New XAttribute("EventID", "500100"),
                                     New XAttribute("CreatedDate", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss")),
                                     New XAttribute("CreatedBy", "Me"),
                                     New XElement("Details",
                                                  New XElement("EventDate", "Date"),
                                                  New XElement("EventTitle", "Title"),
                                                  New XElement("Supplier", "Supplier"),
                                                  New XElement("Market", "Market"),
                                                  New XElement("Brands",
                                                               New XElement("BrandID", "transID"),
                                                               New XElement("BrandName", "details")),
                                                  New XElement("EventType", "Retail/Off-Premise"),
                                                  New XElement("Location",
                                                               New XElement("Name", "transID"),
                                                               New XElement("Address", "details"),
                                                               New XElement("City", "Phoenix"),
                                                               New XElement("State", "AZ"))
                                                               ))

            xmlDoc.Root.Add(root)
            xmlDoc.Save(Server.MapPath("\documents\Events.xml"))
        Catch ex As Exception
            Label1.Text = ex.Message()
        End Try






    End Sub

End Class