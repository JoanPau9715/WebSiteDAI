﻿<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaPro.aspx.cs" Inherits="ZonaPro" Title="Comunicación y tecnología" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server" title="Comunicación y tecnología">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Mi Carpeta</b>"></asp:Label>        
            
            <br /><br />
                <span id="tablecarpeta" class="spancarpeta"></span>            
            <br />                        
        </asp:Panel>
    </div>
</asp:Content>

