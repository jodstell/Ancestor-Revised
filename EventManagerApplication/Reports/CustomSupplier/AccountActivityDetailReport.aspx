<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AccountActivityDetailReport.aspx.vb" Inherits="EventManagerApplication.AccountActivityDetailReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">
        <div class="row">
            <div class="col-xs-12">
                <h2>Reporting Dashboard - Reports</h2>
                <hr />
            </div>
        </div>



         <div class="row">
            <div class="col-xs-12">

                <h3>Activity Report: <asp:Label ID="ActivityTypeLabel" runat="server" /></h3>
                <span style="font-size:20px"><asp:Label ID="selectedDateLabel" runat="server" /></span><br />
                <asp:Label ID="CountLabel" runat="server" />


                <div class="pull-right marginbottom10 marginbotton10">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-default" Text="Return to Dashboard" PostBackUrl="/Reports/CustomSupplier/AccountActivityReport" />

                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                 <asp:PlaceHolder ID="ResultsGridPlaceHolder" runat="server"></asp:PlaceHolder>

                </div>

            </div>



        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
            SelectCommand="SELECT * FROM [qryViewAccountActivity] WHERE (([activityTypeID] = @activityTypeID) AND ([activityDate] >= @activityDate) AND ([activityDate] <= @activityDate2)) ORDER BY [activityDate]">
            <SelectParameters>
                <asp:SessionParameter SessionField="CurrentActivityTypeID" Name="activityTypeID" Type="Int32"></asp:SessionParameter>
                <asp:SessionParameter SessionField="sDate" Name="activityDate" Type="DateTime"></asp:SessionParameter>
                <asp:SessionParameter SessionField="eDate" Name="activityDate2" Type="DateTime"></asp:SessionParameter>
            </SelectParameters>
                </asp:SqlDataSource>




        </div>



</asp:Content>
