<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClassRoomNavBar.ascx.vb" Inherits="EventManagerApplication.ClassRoomNavBar" %>

<style>
    .smallradcombo{
        width: 100% !important;
    }

    .RadComboBoxDropDown_Bootstrap .rcbTemplate, a {
        color: black;
        text-decoration: none;
        font-size: 14px;
        font-weight: bold;
        font-size: larger;
    }

    .rcbReadOnly {
        height: 50px !important;
    }
</style>

<telerik:RadCodeBlock runat="server">

<div class="hidden-xs">
    <asp:Repeater ID="LeftNavBar" runat="server">
        <HeaderTemplate>
            <ul id="myTab" class="nav nav-pills nav-stacked">

                <li id="summary">
                    <a href='dashboard?CourseID=<%: Request.QueryString("CourseID") %>'>
                        <i class="fa fa-slideshare"></i>
                        &nbsp;&nbsp;My Classroom
                    </a>
                </li>

        </HeaderTemplate>

        <ItemTemplate>
            <li id='<%# String.Format(Eval("WidgetName")).ToLower%>'>
                <a href="<%# String.Format(Eval("PageURL")).ToLower%>?CourseID=<%: Request.QueryString("CourseID")%>">
                <i class='<%# getIcon(Eval("Icon"))%>'></i>
                &nbsp;&nbsp;
                    <%# MyCulture.getCulture(Eval("WidgetID"), "Title", Session("MyCulture"), Eval("Title"))%>
            </a>
        </li>
        </ItemTemplate>

        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
</div>

<div class="visible-xs" style="margin-bottom: 10px;">

  <div class="dropdown">
  <button class="btn btn-default dropdown-toggle btn-lg " type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
    <%: GetWidgetName()%>
    <span class="caret"></span>
  </button>
  
   
       <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">

                <li id="summary">
                    <a href='dashboard?CourseID=<%: Request.QueryString("CourseID") %>'>
                        <i class="fa fa-slideshare"></i>
                        &nbsp;&nbsp;My Classroom
                    </a>
                </li>

        </HeaderTemplate>

        <ItemTemplate>
            <li id='<%# String.Format(Eval("WidgetName")).ToLower%>'>
                <a href="<%# String.Format(Eval("PageURL")).ToLower%>?CourseID=<%: Request.QueryString("CourseID")%>">
                <i class='<%# getIcon(Eval("Icon"))%>'></i>
                &nbsp;&nbsp;
                    <%# MyCulture.getCulture(Eval("WidgetID"), "Title", Session("MyCulture"), Eval("Title"))%>
            </a>
        </li>
        </ItemTemplate>

        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>



</div>

    <telerik:RadComboBox ID="LeftNavBarComboBox" runat="server" Skin="MetroTouch" DataTextField="Title" CssClass="smallradcombo" Font-Size="X-Large" Visible="false">
        <ItemTemplate>  
        <a href="<%# String.Format(Eval("PageURL")).ToLower%>?CourseID=<%: Request.QueryString("CourseID")%>"> 
            <%# MyCulture.getCulture(Eval("WidgetID"), "Title", Session("MyCulture"), Eval("Title"))%></a>
    </ItemTemplate>  

    </telerik:RadComboBox>
</div>
    
</telerik:RadCodeBlock>
