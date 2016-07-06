<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaEnvioMensajes.aspx.cs" Inherits="ZonaEnvioMensajes" Title="Página sin título" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Mensaje</b>"></asp:Label>
        </asp:Panel>            
        <asp:Panel ID="Panel2" CssClass="panelSolicitudes" runat="server">        
            <p>
                <asp:Label ID="Label5" runat="server" CssClass="labels2" Text="Destinatario"></asp:Label>
                <asp:TextBox ID="txtBoxDest" CssClass="txtBoxPro" runat="server" onkeyup="verDestinatarios(this.value)" 
                    onfocus="mostrarListBoxDestinatarios()"></asp:TextBox>
                <asp:Label ID="errProgrammer" runat="server" CssClass="etqError" Text="!"></asp:Label>                    
            </p>
            <p>
                <asp:Label ID="Label3" CssClass="labels2" runat="server" Text="Asunto"></asp:Label>
                <asp:TextBox ID="txtBoxAsunto" CssClass="txtBoxPro" runat="server" onfocus="ocultarListBoxDestinatarios()"
                 onkeypress="return permiteCaracteres(event, 'numscars')" >
                </asp:TextBox>
                <asp:Label ID="errTipo" runat="server" CssClass="etqError" Text="!"></asp:Label>                                    
            </p>                        
            <p>
                <asp:Label ID="Label4" CssClass="labels2" runat="server" Text="Texto"></asp:Label>
                <asp:TextBox ID="txtText" runat="server" TextMode="MultiLine" CssClass="txtmensaje"
                 onfocus="ocultarListBoxDestinatarios()" onkeypress="return permiteCaracteres(event, 'numscars')" Text=""></asp:TextBox>
                <asp:Label ID="errDescripcion" runat="server" CssClass="etqError" Text="!"></asp:Label>                                    
            </p>    
            <p>
                <asp:Image ID="preloader" runat="server" ImageUrl="FOTOS/loading.gif" CssClass="preloader" />            
            </p>   
        </asp:Panel>                        
        <p>
            <input id="btnEnviar" type="button" value="Enviar" onclick="enviarMensaje()" class="Botonenvio" />
        </p>        
        <asp:ListBox ID="listBoxDestinatarios" CssClass="listBoxPro" runat="server" onclick="seleccionarDestinatario(this.value)">                
        </asp:ListBox>        
        <p>
            <asp:Label ID="lblEnviado" runat="server" Text="<b>Maika'i. Su mensaje ha sido enviado</b>" CssClass="enviado"></asp:Label>
        </p>                                                     
    </div>
</asp:Content>

