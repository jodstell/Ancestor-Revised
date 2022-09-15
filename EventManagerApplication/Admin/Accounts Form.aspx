<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Accounts Form.aspx.vb" Inherits="EventManagerApplication.Accounts_Form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="/Theme/css/bootstrap.css" rel="stylesheet" />
    <link href="/Theme/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/Theme/css/bootstrap-responsive.min.css" rel="stylesheet" />

    <title>Accounts Form</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">

        <div class="row">

            <div class="col-md-6">
                <div class="form-horizontal">
                    <div class="form-group"> 
                        <label for="#" class="col-md-5 control-label" style="color: black; font-weight: bold; text-align: right;">Corporate Address</label> 
                    </div>

               
                <div class="form-group">
                         <label for="#" class="col-sm-6 control-label">Supplier Address 1:</label>
                    <div class="col-sm-6">
                          <asp:TextBox ID="SupplierAddress1" runat="server" />
                    </div>
                </div>
                
                 <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">Supplier Address 2:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="SupplierAddress2" runat="server" />
                    </div>
                </div> 
                
                <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">City:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="city" runat="server" />
                    </div>
                </div> 
                
             <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">State:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="state" runat="server" Width="45px" />
                    </div>
                </div> 
                
             <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">Zip:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="zip" runat="server" Width="90px" />
                    </div>
                </div>
            </div> 
            

            </div> 


            <div class="col-md-6">

               <div class="form-horizontal">
                <div class="form-group"> 
                    <label for="#" class="col-md-5 control-label" style="color: black; font-weight: bold;">Primary Contact</label> 
                </div>

                <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">Contact Name:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="ContactName" runat="server" />
                    </div>
                </div> 

                 <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">Email:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="email" runat="server" />
                    </div>
                </div> 

                 <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">Phone Number:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="PhoneNumber" runat="server" />
                    </div>
                </div> 
                  
                 <div class="form-group">
                    <label for="#" class="col-sm-6 control-label">Supplier Web Site:</label>
                     <div class="col-sm-6">
                          <asp:TextBox ID="WebSite" runat="server" />
                    </div>
                </div> 
              </div>
            

            </div>

      </div>


        <div class="row">
          
            <div class="col-md-5">
    
                <h5 style="color: black; font-weight: bold;">Invioce Header/Bill To:</h5>
                    <asp:TextBox ID="InvioceHeader" TextMode="multiline" runat="server" Height="130px" Width="230px" />
      
            </div>


            <div class="col-md-7">

                <div class="form-horizontal">

                <div class="form-group">
                    <label for="#" class="col-sm-4 control-label">Billing Contact Name:</label>
                     <div class="col-sm-8">
                          <asp:TextBox ID="BillingContactName" runat="server" Width="345px" />
                    </div>
                </div> 

                 <div class="form-group">
                    <label for="#" class="col-sm-4 control-label">Billing Contact Email:</label>
                     <div class="col-sm-8">
                          <asp:TextBox ID="BillingContactEmail" runat="server" Width="345px" />
                    </div>
                </div> 

                 <div class="form-group">
                    <label for="#" class="col-sm-4 control-label">Billing Contact Phone #:</label>
                     <div class="col-sm-8">
                          <asp:TextBox ID="BillingContactPhone" runat="server" Width="345px" />
                    </div>
                </div> 
                   
              </div>



            </div>

        </div>


        <div class="row">

            <div class="col-md-12">
                
                <h5 style="color: black; font-weight: bold;">Billing Notes</h5>
                    <asp:TextBox ID="BillingNotes" TextMode="multiline" runat="server" Height="100px" Width="1190px" />
                
                </div>

            </div>


        </div>

     
    
    </form>
</body>
</html>
