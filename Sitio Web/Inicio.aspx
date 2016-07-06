<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Inicio.aspx.cs" Inherits="Inicio" Title="Comunicación y tecnología" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" runat="server" Height="640px">
            <asp:Label ID="lblBienvenida" runat="server" Text="<b>Bienvenido a Kailua ©</b><br/><br/>Software a medida, Web Development e 
                                          Integración de Bases de Datos<br />para su negocio" CssClass="TextoBienvenida"></asp:Label>
            <div class="CuadroAcceso">
                <asp:Label CssClass="Etiquetas" ID="Label2" runat="server" Text="Acceso"></asp:Label>
                <br />
                <asp:DropDownList CssClass="DDList" ID="ddTipoAcceso" runat="server" onchange="setFocusUsuario()">
                    <asp:ListItem Value="aCliente" Text="Cliente" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="aProgramador" Text="Programador"></asp:ListItem>                    
                </asp:DropDownList>
                <asp:Panel ID="Panel2" runat="server" CssClass="PanelLogin">
                    <asp:Label ID="lblAcceso" runat="server" Text="Nick" CssClass="Etiquetas"></asp:Label>
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="Edits" onkeypress="return permiteCaracteres(event, 'numscars')"></asp:TextBox>
                    <br /><br />
                    <asp:Label ID="lblPwd" runat="server" Text="Contraseña" CssClass="Etiquetas"></asp:Label>
                    <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" CssClass="Edits"></asp:TextBox> 
                    <asp:Label ID="errAcceso" runat="server" Text="" CssClass="EtiquetaError"></asp:Label>  
                </asp:Panel>
                <p>
                    <asp:CheckBox ID="chkRecordar" runat="server" Text="Recordar tipo de acceso" CssClass="EtiquetaRecordar" />
                    <asp:Button ID="btnAcceder" runat="server" Text="Log in" CssClass="Botones" 
                        onclick="btnAcceder_Click" OnClientClick="return ValidarUsers()" />
                </p>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

