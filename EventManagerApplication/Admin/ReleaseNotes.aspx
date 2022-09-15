<%@ Page Title="Release Notes" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ReleaseNotes.aspx.vb" Inherits="EventManagerApplication.ReleaseNotes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <h1>Release Notes</h1>
        <a href="/admin/siteadministration" class="btn btn-default">Back to Site Administration</a>
        <hr />

        <h3>3/17/2017</h3>
        <h3>Version 0.1.3</h3>

        <div class="title">New</div>
        <ul>
            <li>New: Ambassador Registration now requires the head and bodyshot uploads.</li>
            <li>New: Image drop box added to Event Recap </li>
            <li>Added: Return Tracking text box to POS Kits</li>

        </ul>

         <div class="title">Fixed</div>
        <ul>
            <li>Fixed: Bugs with the Add and Edit POS items</li>
            <li>Fixed: Import events from excel</li>
            <li>Fixed: POS cost didn't save</li>

        </ul>

         <div class="title">Known Issues</div>
        <ul>
            <li></li>

        </ul>

        <hr />


        <h3>3/8/2017</h3>
        <h3>Version 0.1.2</h3>


        <div class="title">New</div>
        <ul>
            <li>Added Ambassador Notes to the BA pages</li>

        </ul>

        <div class="title">Fixed</div>
        <ul>
            <li>Fixed: Updated the Event Status automatically after BA's are assigned</li>
            <li>Fixed: Corrected the registration date and last login dates to show local time not server time</li>
        </ul>

        <div class="title">Known Issues</div>
        <ul>
            <li>Mouse over does not work on site stats links on the site administration page</li>
        </ul>

        <hr />

        <h3>3/6/2017</h3>
        <h3>Version 0.1.1</h3>


        <div class="title">New</div>
        <ul>
            <li>Added Release Notes to the site administration</li>
            <li>Added Additional Information to the Event Details screen</li>
            <li>Added Ambassador Notes</li>
        </ul>

        <div class="title">Fixes</div>
         <ul>
            <li>Fixed: Validate if user already exists when adding a new user</li>
            <li>Fixed: Validate if user already exists when adding a new ambassador</li>
            <li>Fixed: Validate if user already exists when adding a approving new ambassador</li>
            <li>Fixed: Recap questions on Event Details page update when add, edit, or delete Brand Questions</li>
            <li>Corrected misspelled "Piercings"</li>

        </ul>

        <div class="title">Known Issues</div>
         <ul>
            <li>Mouse over does not work on site stats links on the site administration page</li>
        </ul>

    </div>
</asp:Content>
