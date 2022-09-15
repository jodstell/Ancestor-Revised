<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewEventType.aspx.vb" Inherits="EventManagerApplication.NewEventType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Theme/css/custom1.css" rel="stylesheet" />

    <style>
        input[type="checkbox"], input[type="radio"] {
            margin: 0 8px 0;
            line-height: normal;
        }

        .form-group span.errorlabel {
            color: #B94A48;
            font-size: 11px;
            font-weight: 600;
            position: relative;
            left: -15px;
            padding: 4px 8px;
            margin-bottom: 1em;
            color: #FFF;
            background: #B94A48;
            border-top-right-radius: 3px;
            border-top-left-radius: 3px;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.35);
        }

        .form-horizontal .form-group span.errorlabel {
            margin-left: 1.5em;
            margin-left: 15px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <div class="row">
            <div class="col-md-12">

 <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

                <div style="margin: 0 0 15px 0">
                    <h2>New Event Type 
                    </h2>
                    <p>
                        Use this form to add a new event type.  Complete each section below and click on the Next button to continue to the next tab.<br />
                        Fields marked with asterisk (<span class="text-danger">*</span>) are required.
                    </p>

                    <asp:Label ID="msgLabel" runat="server" />

                </div>

               


                    <div class="widget stacked">
                        <div class="widget-content">

                            <asp:TextBox ID="tempGUID" runat="server" Visible="false" />

                            <telerik:RadWizard ID="NewEventTypeWizard" runat="server" DisplayCancelButton="true" DisplayProgressBar="false" Skin="Bootstrap">
                                <WizardSteps>
                                    <telerik:RadWizardStep Title="Details" ValidationGroup="Details">

                                        <div class="col-md-12">
                                            <div class="form-horizontal">

                                             <%--   <div class="form-group">
                                                    <label for="IDTextBox" class="col-sm-2 control-label">ID:</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="IDTextBox" runat="server" CssClass="form-control input-sm" Width="100px" />
                                                        <span id="helpBlock" class="help-block">(For testing purpose only.  This field will be removed on the live site.)</span>
                                                    </div>
                                                </div>--%>

                                                <div class="form-group">

                                                    <label for="EventTypeNameTextBox" class="col-sm-2 control-label">Event Type Title: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-4">

                                                        <asp:TextBox ID="EventTypeNameTextBox" runat="server" CssClass="form-control input-sm" />
                                                        <asp:RequiredFieldValidator ID="VPIDTextBoxRequiredFieldValidator" runat="server"
                                                            ErrorMessage="This field is required." CssClass="errorlabel" ControlToValidate="EventTypeNameTextBox"
                                                            Display="Dynamic" ValidationGroup="Details"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ActiveTextBox" class="col-sm-2 control-label">Active: <span class="text-danger">*</span></label>
                                                    <div class="col-sm-8">
                                                        <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="100px">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span id="helpBlock1" class="help-block">Select Yes to enable this Event Type for the current client.</span>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </telerik:RadWizardStep>
                                    <telerik:RadWizardStep Title="Tasks">

                                        <div class="col-md-12">
                                            

                                            <telerik:RadListView ID="TaskList" runat="server"
                                                DataKeyNames="tempEventTypeTaskID" DataSourceID="getTempEventTypeTasks" InsertItemPosition="FirstItem">
                                                <LayoutTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                        <table class="table" cellspacing="0" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th>Task</th>
                                                                    <th>Due Date Offset</th>
                                                                    <th>Notes</th>
                                                                    <th>&nbsp;</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr id="itemPlaceholder" runat="server">
                                                                </tr>
                                                            </tbody>
                                                            <tfoot>
                                                                <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                    CssClass="btn btn-success pull-right"><i class="fa fa-plus"></i> Add New Task</asp:LinkButton>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <tr class="rlvI">
                                                        <td>
                                                            <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("taskTitle")%>' /></td>
                                                        <td>
                                                            <asp:Label ID="contactNameLabel" runat="server" Text='<%# formatTimeOffset(Eval("dateDueOffset"))%>' /></td>
                                                        <td>
                                                            <asp:Label ID="contactPhoneLabel" runat="server" Text='<%# Eval("Notes")%>' /></td>

                                                        <td>
                                                            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-danger" Text="Remove" ToolTip="Delete" /></td>
                                                    </tr>
                                                </ItemTemplate>

                                                <EditItemTemplate>
                                                    <tr class="rlvIEdit">
                                                        <td>
                                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("taskTitle")%>' CssClass="form-control"></asp:TextBox></td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control" SelectedValue='<%# Bind("dateDueOffset")%>'>
                                        <asp:ListItem value='0'>0 days</asp:ListItem>
                                        <asp:ListItem value='-1'>1 day prior</asp:ListItem>
                                        <asp:ListItem value='-2'>2 days prior</asp:ListItem>
                                        <asp:ListItem value='-3'>3 days prior</asp:ListItem>
                                        <asp:ListItem value='-4'>4 days prior</asp:ListItem>
                                        <asp:ListItem value='-5'>5 days prior</asp:ListItem>
                                        <asp:ListItem value='-6'>6 days prior</asp:ListItem>
                                        <asp:ListItem value='-7'>7 days prior</asp:ListItem>
                                        <asp:ListItem value='-14'>14 days prior</asp:ListItem>
                                        <asp:ListItem value='-30'>30 days prior</asp:ListItem>
                                        <asp:ListItem value='1'>1 day after</asp:ListItem>
                                        <asp:ListItem value='2'>2 days after</asp:ListItem>
                                        <asp:ListItem value='3'>3 days after</asp:ListItem>
                    </asp:DropDownList>

                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("notes")%>' CssClass="form-control"></asp:TextBox></td>

                                                        <td style="width: 150px;">
                                                            <div class="btn-group" role="group" aria-label="...">

                                                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-primary" Text="Save" ToolTip="Update" />
                                                                <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-default" Text="Cancel" ToolTip="Cancel" />
                                                            </div>
                                                        </td>
                                                </EditItemTemplate>

                                                <InsertItemTemplate>
                                                    <tr class="rlvIEdit">
                                                        <td>
                                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("taskTitle")%>' CssClass="form-control"></asp:TextBox></td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlEndTimeOffSet" runat="server" CssClass="form-control" SelectedValue='<%# Bind("dateDueOffset")%>'>
                                        <asp:ListItem value='0'>0 days</asp:ListItem>
                                        <asp:ListItem value='-1'>1 day prior</asp:ListItem>
                                        <asp:ListItem value='-2'>2 days prior</asp:ListItem>
                                        <asp:ListItem value='-3'>3 days prior</asp:ListItem>
                                        <asp:ListItem value='-4'>4 days prior</asp:ListItem>
                                        <asp:ListItem value='-5'>5 days prior</asp:ListItem>
                                        <asp:ListItem value='-6'>6 days prior</asp:ListItem>
                                        <asp:ListItem value='-7'>7 days prior</asp:ListItem>
                                        <asp:ListItem value='-14'>14 days prior</asp:ListItem>
                                        <asp:ListItem value='-30'>30 days prior</asp:ListItem>
                                        <asp:ListItem value='1'>1 day after</asp:ListItem>
                                        <asp:ListItem value='2'>2 days after</asp:ListItem>
                                        <asp:ListItem value='3'>3 days after</asp:ListItem>
                    </asp:DropDownList></td>
                                                        <td>
                                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("notes")%>' CssClass="form-control"></asp:TextBox></td>

                                                        <td style="width: 150px;">

                                                            <div class="btn-group" role="group" aria-label="...">

                                                                <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-primary" Text="Save" ToolTip="Insert" />
                                                                <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-default" Text="Cancel" ToolTip="Cancel" />
                                                            </div>


                                                        </td>
                                                </InsertItemTemplate>


                                                <EmptyDataTemplate>
                                                    <div class="RadListView RadListView_Default">
                                                        <table class="table" cellspacing="0" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th>Task</th>
                                                                    <th>Due Date Offset</th>
                                                                    <th>Notes</th>
                                                                    <th>&nbsp;</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td colspan="7">
                                                                        <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Task</strong> button above.</div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                            <tfoot>
                                                                <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                    Text="Add New Task" CssClass="btn btn-success pull-right"><i class="fa fa-plus"></i> Add New Task</asp:LinkButton>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </EmptyDataTemplate>

                                            </telerik:RadListView>

                                            <!-- LinqDataSource -->
                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getTempEventTypeTasks" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tempEventTypeTasks" Where="tempGuid == @tempGuid" EnableDelete="True" EnableInsert="True" EnableUpdate="True">
                                                <WhereParameters>
                                                    <asp:ControlParameter ControlID="tempGUID" PropertyName="Text" Name="tempGuid" Type="String"></asp:ControlParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>
                                        </div>

                                    </telerik:RadWizardStep>

                                    
                                    <telerik:RadWizardStep Title="Recap Questions">
                                        <div class="col-md-12">
                                            <div class="pull-right">

                                                <asp:LinkButton ID="btnAddNewQuestion" runat="server" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Recap Question</asp:LinkButton>
                                            </div>


                                            <asp:Repeater ID="RecapQuestionList" runat="server" DataSourceID="getTempRecapQuestions">
                                                <HeaderTemplate>
                                                    <table class="table" cellspacing="0" style="width: 100%;">
                                                        <thead>
                                                            <tr>

                                                                <th>Recap Question</th>
                                                                <th>Question Type</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%# Eval("question")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("questionType")%>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tbody>
                                                    </table>

                                                    <asp:Label ID="lblEmptyData"
                                                        Text='<%# Common.ShowAlertNoClose("warning", "There are no recap questions for this Event Type.  Click on the Add New Recap Question button above to create a recap question.")%>' runat="server" Visible="false">
                                                    </asp:Label>

                                                </FooterTemplate>
                                            </asp:Repeater>

                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getTempRecapQuestions" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tempEventTypeRecapQuestions" Where="tempGUID == @tempGUID">
                                                <WhereParameters>
                                                    <asp:ControlParameter ControlID="tempGUID" PropertyName="Text" Name="tempGUID" Type="String"></asp:ControlParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>
                                            <div class="clearfix"></div>


                                            <asp:Panel ID="NewRecapQuestionPanel" runat="server" Visible="false" Style="margin-top: 15px;">

                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question</label>
                                                        <div class="col-sm-8">
                                                            <asp:TextBox ID="ColumnNameTextBox" runat="server" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="RequiredFieldTextBox" class="col-sm-2 control-label">Required Field</label>
                                                        <div class="col-sm-8">
                                                            <asp:RadioButtonList ID="RequiredFieldTextBox" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                                <asp:ListItem Selected="True" Text="Yes"></asp:ListItem>
                                                                <asp:ListItem Text="No"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="columnTypeList" class="col-sm-2 control-label">Column Type</label>
                                                        <div class="col-sm-10">
                                                            <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true">
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



                                                    <!-- Text Option -->
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
                        <asp:TextBox ID="txtLines" runat="server" Text="6" CssClass="form-control"></asp:TextBox>
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

                                                    <!-- End of Form  -->


                                                    <div class="form-group">
                                                        <label for="accountNameTextBox" class="col-sm-2 control-label"></label>
                                                        <div class="col-sm-6">
                                                            <asp:Button ID="btnInsertQuestion" runat="server" Text="Save" CssClass="btn btn-primary" />
                                                            <asp:Button ID="btnCancelNewQuestion" runat="server" Text="Cancel" CssClass="btn btn-default" />
                                                        </div>
                                                    </div>

                                                    <asp:Label ID="Label1" runat="server" />

                                                </div>

                                            </asp:Panel>

                                        </div>

                                    </telerik:RadWizardStep>
                                </WizardSteps>
                            </telerik:RadWizard>

                        </div>

                    </div>

                </telerik:RadAjaxPanel>





            </div>
        </div>
    </div>


</asp:Content>
