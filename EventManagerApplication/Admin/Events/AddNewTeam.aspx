<%@ Page Title="Add New Team" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddNewTeam.aspx.vb" Inherits="EventManagerApplication.AddNewTeam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <style>
        .form-group {
            margin-bottom: 10px;
        }

        div.RadListBox .rlbTransferTo,
        div.RadListBox .rlbTransferToDisabled,
        div.RadListBox .rlbTransferAllToDisabled,
        div.RadListBox .rlbTransferAllTo {
            display: none;
        }

        .title {
            font-size: 14px;
            padding-bottom: 0px;
        }

        .list-containers .list-container {
            text-align: left;
            display: inline-block;
            vertical-align: top;
        }

        .background-silk .demo-container {
            background-color: #F3F3F3;
        }

        .list-container.size-thin {
            max-width: 380px;
        }

        .list-container {
            margin: 0px auto;
            padding: 10px;
            border: 1px solid #E2E4E7;
            background-color: #F5F7F8;
        }

        .label-standard {
            background-color: #000;
        }

        .rlvI1 {
            font-size: 14px;
            border-bottom: 0px solid;
            padding-top: 5px;
            padding-bottom: 3px;
        }

        .rlvIEdit1 {
            width: 400px;
            margin: 15px;
        }

        .RadListView_Metro {
            margin: 5px;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit1 {
            border-bottom: 0px solid;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container">
    <div class="row">
        <div class="col-md-12">
                    
            <div style="margin: 0 0 15px 0">
                <h2>Client:
                <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />

                </h2>
                <h3>Add New Team</h3>
            </div>

            <div class="row">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>

        </div>
    </div>

<asp:Panel ID="Panel1" runat="server">
    <div class="widget stacked">
     <div class="widget-content">

        <div class="row">
            <div class="col-md-12">                
                <h2>Default Information</h2>

                    <asp:LinkButton ID="btnSave" runat="server" Text="Save" CssClass="btn btn-md btn-primary"></asp:LinkButton>
                    
                    <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-md btn-default"></asp:LinkButton>

                <hr />

                <div class="form-horizontal">

                    <div class="form-group">
                        <label for="TeamNameTextBox" class="col-sm-2 control-label">Team Name: <span class="text-danger">*</span></label>

                        <div class="col-sm-6">
                            <asp:TextBox ID="TeamNameTextBox" runat="server" CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Team Name is required" CssClass="errorlabel" ControlToValidate="TeamNameTextBox"
                                Display="Dynamic" ValidationGroup="billing"></asp:RequiredFieldValidator>
                        </div>
                    </div>


                    <div class="form-group">

                        <label for="TeamNameTextBox" class="col-sm-2 control-label">Active:</label>

                        <div class="col-sm-6">
                                    
                            <telerik:RadComboBox ID="ActiveComboBox" runat="server">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Yes" Value="True" />
                                    <telerik:RadComboBoxItem Text="No" Value="False" />
                                </Items>
                            </telerik:RadComboBox>

                            
                        </div>

                    </div>


                    <div class="form-group">
                        <label for="TeamNameTextBox" class="col-sm-2 control-label">Markets:</label>
                        
                                                <div class="col-sm-4" style="top: 6px;">
                                                    <p>Assign this team to market.</p>

                                                    <asp:CheckBox ID="EnableAllMarketsCheckBox" runat="server" Text="Enable All Markets" AutoPostBack="true" />

                                                    <telerik:RadListBox ID="MarketListBox" runat="server" CheckBoxes="true" Width="100%" Font-Bold="false" DataSourceID="GetMarketList" DataTextField="marketName" DataValueField="marketID" Height="350px">
                                                    </telerik:RadListBox>
                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetMarketList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="marketName" TableName="tblMarkets" Where="active == @active">
                                                        <WhereParameters>
                                                            <asp:Parameter DefaultValue="True" Name="active" Type="Boolean"></asp:Parameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>



                                                   
                                               

                        </div>
                    </div>
                            

                </div>

                    


            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="pull-right">

                  

                </div>
            </div>
        </div>

      </div>
    </div>
</asp:Panel>
</div>
    
</asp:Content>
