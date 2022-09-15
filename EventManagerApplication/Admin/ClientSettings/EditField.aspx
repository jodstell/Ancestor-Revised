<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditField.aspx.vb" Inherits="EventManagerApplication.EditField" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

        <div class="container" style="min-height: 500px;">
            <div class="row">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>


            <div class="row">
                <div class="col-md-12">

                    <div style="margin: 0 0 15px 0">
                        <h2>Edit Column: 
                        <asp:Label ID="ActivityTypeNameLabel" runat="server" Font-Bold="true" /></h2>

                    </div>

                    <div style="margin: 12px 0 12px 0">
                        <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="True" Text="Update" CssClass="btn btn-primary btn-sm" />
                        &nbsp;<asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default btn-sm" />
                    </div>

                    <hr />
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="ColumnNameTextBox" class="col-sm-2 control-label">Column Name</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="ColumnNameTextBox" runat="server" CssClass="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="ColumnNameTextBox" class="col-sm-2 control-label">Required Field</label>
                            <div class="col-sm-8">
                                <asp:RadioButtonList ID="RequiredFieldTextBox" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="accountNameTextBox" class="col-sm-2 control-label">Column Type</label>
                            <div class="col-sm-10">
                                 <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true" Width="100%">
                        <asp:ListItem Text="Single line of text" Value="text"></asp:ListItem>
                        <asp:ListItem Text="Multiple lines of text" Value="multiline"></asp:ListItem>
                        <asp:ListItem Text="Yes/No (check box)" Value="yes/no"></asp:ListItem>
                        <asp:ListItem Text="Choice (menu to choose from)" Value="choice"></asp:ListItem>
                        <asp:ListItem Text="Number (1, 1.0, 100)" Value="number"></asp:ListItem>
                        <asp:ListItem Text="Date" Value="date"></asp:ListItem>
                        <asp:ListItem Text="Time" Value="time"></asp:ListItem>
                        <asp:ListItem Text="Currency ($)" Value="currency"></asp:ListItem>
                    </asp:RadioButtonList>
                            </div>
                        </div>

                                   <asp:Panel ID="DescriptionPanel" runat="server">
                <div class="form-group">
                    <label for="txtDescription" class="col-sm-2 control-label">Description Text</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                        <span id="helpBlock" class="help-block">Specify detailed options for the type of information you selected.</span>
                    </div>
                </div>

            </asp:Panel>

            <!-- Multiple Lines Option -->
            <asp:Panel ID="MultilinePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="txtLines" class="col-sm-2 control-label">Number of lines for text</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtLines" runat="server" Text="4" CssClass="form-control" Width="50px"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>


            <!-- Choice Option -->
            <asp:Panel ID="ChoicePanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="txtChioces" class="col-sm-2 control-label">Choices</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtChioces" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                        <span id="helpBlock3" class="help-block">Type each choice on a separate line.</span>


                    </div>
                </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-2 control-label">Display Options</label>
                    <div class="col-sm-10">
                        <asp:RadioButtonList ID="DisplayOptions" runat="server">
                            <asp:ListItem Selected="True" Text="Drop-Down Menu" Value="drop"></asp:ListItem>
                            <asp:ListItem Text="Radio Buttons" Value="radio"></asp:ListItem>
                            <asp:ListItem Text="Checkboxes (allow multiple selections)" Value="check"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>

            </asp:Panel>

             <!-- Choice Option -->
            <asp:Panel ID="YesNoPanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="ckbYesNo" class="col-sm-2 control-label">Default Value</label>
                    <div class="col-sm-4">
                        
                         <asp:RadioButtonList ID="ckbYesNo" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="No"></asp:ListItem>
                        </asp:RadioButtonList>


                    </div>
                </div>
                </asp:Panel>


            <!-- Number Option -->
            <asp:Panel ID="NumberPanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="txtDecimalPlace" class="col-sm-2 control-label">Number of decimal places</label>
                    <div class="col-sm-1">
                        <asp:DropDownList ID="txtDecimalPlace" runat="server" CssClass="form-control">
                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtDefaultNumber" class="col-sm-2 control-label">Default value</label>
                    <div class="col-sm-1">
                        <asp:TextBox ID="txtDefaultNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-2 control-label">Show as percentage</label>
                    <div class="col-sm-10">
                        <asp:RadioButtonList ID="ckbPercentage" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                            <asp:ListItem Text="No" Selected="True" Value="False"></asp:ListItem>
                        </asp:RadioButtonList>
                        (for example, 50%)
                    </div>
                </div>

            </asp:Panel>

            <!-- Date Option -->
            <asp:Panel ID="DatePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="ckbDateFormat" class="col-sm-2 control-label">Date and Time Format</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbDateFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Date Only" Selected="True" Value="Date"></asp:ListItem>
                            <asp:ListItem Text="Date & Time" Value="DateTime"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-2 control-label">Display Format</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbDateDisplayFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Standard" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Friendly"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

                <div class="form-group">
                    <label for="ckbDateDefualtValue" class="col-sm-2 control-label">Default Value</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbDateDefualtValue" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="None" Selected="True" Value="None"></asp:ListItem>
                            <asp:ListItem Text="Current Date" Value="Current"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

            </asp:Panel>

            <!-- Date Option -->
            <asp:Panel ID="TimePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="ckbTimeFormat" class="col-sm-2 control-label">Time Format</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbTimeFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="12 hours" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="24 hours"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>
            </asp:Panel>

            <!-- Currency Option -->
            <asp:Panel ID="CurrencyPanel" runat="server" Visible="false">
            </asp:Panel>

                    </div>
                </div>

            </div>

        </div>

    </telerik:RadAjaxPanel>


    <script src="/Scripts/jquery-1.10.2.js"></script>

<link href="/skins/square/blue.css" rel="stylesheet" />

    <style>
        .icheckbox_square-blue, .iradio_square-blue {
            margin: 0 5px 0 5px;
        }
    </style>

    <script src="/js/icheck.js"></script>

    <script>
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional

            });
        });

        function formatCheckBox() {
        $('input').iCheck({
                        checkboxClass: 'icheckbox_square-blue',
                        radioClass: 'iradio_square-blue',
                        increaseArea: '20%' // optional

            });
}
    </script>

</asp:Content>


