<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Contacto.aspx.cs" Inherits="Contacto" Title="Página sin título" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Contacto</b>"></asp:Label>        
            <br /><br />
            Para ponerse en contacto escriba un e mail a comunicacion@kailua.com
        </asp:Panel>
    </div>
</asp:Content>

