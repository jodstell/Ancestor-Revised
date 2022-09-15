<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QuestionaireControl.ascx.vb" Inherits="EventManagerApplication.QuestionaireControl" %>

<style>
    .headerLabel {
         color: #F90;
        border: 0;
        font-family: 'Open Sans';
        font-weight: normal;
        font-size: 24px;
        width: 100%;
    }

   .dataGroup fieldset legend {
        color: #F90;
        border: 0;
        font-family: 'Open Sans';
        font-weight: normal;
        font-size: 24px;
        width: 100%;
}

    legend {
        padding: 0;
    }

    fieldset {
    margin-top: 0;
    border: solid 0 #e2e4e7 !important;
    height: 100%;
    width: 780px;
}

 /*
    .faq-list {
        padding: 0;
        margin: 0 0 0;
        list-style: none;
    }

    fieldset {
        margin-top: 0;
        border: solid 0 #e2e4e7 !important;
        height: 100%;
        width: 780px;
    }*/
</style>

<%--<link href="/events/css/recap.css" rel="stylesheet" />--%>


<div>
<telerik:RadListView ID="RadListView1" runat="server" DataKeyNames="eventRecapQuestionID" 
    ItemPlaceholderID="ItemPlaceHolder"  BorderWidth="0" Width="100%">
    <LayoutTemplate>
        <table class="table table-bordered" style="margin-bottom:0; border-bottom-color:white">
            <asp:Panel ID="GroupPlaceHolder" runat="server"></asp:Panel>
        </table>
    </LayoutTemplate>

    <ItemTemplate>
        <tr>
            <td style="width:50% !important;"><asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question") %>' /></td>
            <td style="width:50% !important;" class="active"><asp:Label ID="answerLabel" runat="server" Text='<%# Eval("answer") %>' ForeColor="#23527c" /></td>
        </tr>
    </ItemTemplate>
   
    <DataGroups>
        <telerik:ListViewDataGroup GroupField="brandID" DataGroupPlaceholderID="GroupPlaceHolder">
            <DataGroupTemplate>
                <asp:Panel runat="server" ID="Panel3" CssClass="dataGroup">
                    <tr>
                        <td>
                             <h3><%# getBrandName(CType(Container, RadListViewDataGroupItem).DataGroupKey) %></h3>         
                        </td>
                        <td>
                            </td>
                    </tr>
                           <asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder>
                    </asp:Panel>
            </DataGroupTemplate>
        </telerik:ListViewDataGroup>
    </DataGroups>
</telerik:RadListView>




<asp:Button ID="btnRebuildEventTypeRecap" runat="server" Text="Rebuild Recap Questions" Visible="false" />

<asp:Repeater ID="EventRecapQuestions" runat="server">
   <HeaderTemplate>
        <table class="table table-bordered">
            <tr>
                <td>
                    <h3><asp:Label ID="EventTypeRecapHeaderLabel" runat="server" Text='<%# getTitleLabel() %>' /></h3>
                </td>
                <td></td>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td style="width:50%">
                
                <asp:Label ID="questionLabel" runat="server" CssClass='<%# getQuestionFormat(Eval("questionType")) %>' Text='<%# Eval("question") %>'></asp:Label></td>
            <td style="width:50%" class='<%# getAnswerFormat(Eval("questionType")) %>' >
                <asp:Label ID="answerLabel" runat="server" Text='<%# Eval("answer") %>' ForeColor="#23527c"></asp:Label></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>

</div>

<asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventRecapQuestions" 
    ContextTypeName="EventManagerApplication.DataClassesDataContext" 
    TableName="tblEventRecapQuestions" Where="eventID == @eventID && recapID == @recapID" OrderBy="sortorder">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
        <asp:Parameter DefaultValue="2" Name="recapID" Type="Int32"></asp:Parameter>
    </WhereParameters>
</asp:LinqDataSource>

<asp:LinqDataSource runat="server" EntityTypeName="" ID="getTempEventRecapQuestions" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tempEventRecapQuestions" Where="eventID == @eventID && recapID == @recapID" OrderBy="sortorder">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
        <asp:Parameter DefaultValue="2" Name="recapID" Type="Int32"></asp:Parameter>
    </WhereParameters>
</asp:LinqDataSource>

<asp:LinqDataSource runat="server" EntityTypeName="" ID="getRecapQuestionsByGroup" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tempEventRecapQuestions" Where="eventID == @eventID">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
    </WhereParameters>
</asp:LinqDataSource>

<asp:SqlDataSource runat="server" ID="getBrandList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
    SelectCommand="SELECT * FROM tempEventRecapQuestions WHERE (eventID = @eventID) AND (NOT (brandID IS NULL))">
    <SelectParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID"></asp:QueryStringParameter>
    </SelectParameters>
</asp:SqlDataSource>




<asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventRecapQuestions2" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblEventRecapQuestions" Where="eventID == @eventID && recapID == @recapID" OrderBy="sortorder">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
        <asp:Parameter DefaultValue="2" Name="recapID" Type="Int32"></asp:Parameter>
    </WhereParameters>
</asp:LinqDataSource>

<asp:LinqDataSource runat="server" EntityTypeName="" ID="getRecapQuestionsByGroup2" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblEventRecapQuestions" Where="eventID == @eventID">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
    </WhereParameters>
</asp:LinqDataSource>

<asp:SqlDataSource runat="server" ID="getBrandList2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
    SelectCommand="SELECT eventRecapQuestionID, eventID, brandID, question, answer FROM tblEventRecapQuestions 
    WHERE (eventID = @eventID) AND (NOT (brandID IS NULL))">
    <SelectParameters>
        <asp:QueryStringParameter QueryStringField="ID" Name="eventID"></asp:QueryStringParameter>
    </SelectParameters>
</asp:SqlDataSource>




<asp:HiddenField ID="HiddenEventTypeID" runat="server" />

<%--<script src="/events/js/faq.js"></script>
<script src="/events/js/recap.js"></script>--%>

