<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TitleBlockControl.ascx.vb" Inherits="EventManagerApplication.TitleBlockControl" %>

<style type="text/css">
          @media (min-width: 200px) and (max-width: 980px) {

               .subnavbar {
            margin-bottom: .5em;
        }

             h3 {
            margin-top: 3px;
        }
        }
    </style>

<div class="row" style="margin-bottom:24px;">
    <div class="col-xs-12 col-sm-6 col-md-8">
         <div class="title">
                        <telerik:RadCodeBlock runat="server">
                            <h1>
                            <asp:Label ID="TitleLabel" runat="server" /></h1>

                        </telerik:RadCodeBlock>
                      
                    </div>


                <asp:Panel ID="SubTitlePanel" runat="server">
                    <span class="sub-title">
                        <telerik:RadCodeBlock runat="server"><%: getCourseInfo()%></telerik:RadCodeBlock>
                    </span>
                </asp:Panel>

    </div>

    <%--<div class="col-xs-12 col-md-4">
        <div class="col-md-12 pull-right">
 <asp:LinkButton ID="btnViewClassrooms" runat="server" CssClass="btn btn-md btn-primary pull-right" PostBackUrl="/application/classrooms" Text="<%$ Resources:Resource, ViewMyClassroomButton %>"></asp:LinkButton>
</div>
        </div>--%>
</div>
        <div class="clear"></div>