import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';

export const TablaEntradasMovimientos = () => {
  const [entradas, setEntradas] = useState([]);
  const [entradasDetalle, setEntradasDetalle] = useState([]);
  const [selectedEntrada, setSelectedEntrada] = useState(null);
  const [showEntradasDetalle, setShowEntradasDetalle] = useState(false);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const responseEntradas = await axios.get('http://127.0.0.1:8000/api/entradas/');
      const responseEntradasDetalles = await axios.get('http://127.0.0.1:8000/api/entrada_detalles/');
      setEntradas(responseEntradas.data.entradas);
      setEntradasDetalle(responseEntradasDetalles.data.entradas);
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };

  const renderEntradas = () => {
    const handleEntradaClick = (identrada) => {
      setSelectedEntrada(identrada);
      setShowEntradasDetalle(true);
    };

    return (
      <TableContainer component={Paper} style={{"margin-top": "10px", "margin-left": "260px", "padding": "5px"}}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Id Entrada</TableCell>
              <TableCell>ID Proveedor</TableCell>
              <TableCell>Fecha</TableCell>
              <TableCell>Monto Total</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {entradas.map((entrada) => (
              <TableRow key={entrada.identrada} onClick={() => handleEntradaClick(entrada.identrada)}>
                <TableCell>{entrada.identrada}</TableCell>
                <TableCell>{entrada.idproveedor_id}</TableCell>
                <TableCell>{entrada.fecha}</TableCell>
                <TableCell>{entrada.montototal}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    );
  };

  const renderEntradasDetalle = () => {
    const filteredEntradasDetalle = entradasDetalle.filter(
      (entradaDetalle) => entradaDetalle.identrada_id === selectedEntrada
    );

    const handleCloseEntradasDetalle = () => {
      setShowEntradasDetalle(false);
    };

    return (
      <>
        {showEntradasDetalle && (
          <>
            <button onClick={handleCloseEntradasDetalle} 
              style={{"margin-top": "20px", "margin-left": "260px", "padding": "5px", "width": "15%",
              "color": "white", "background-color": "#003084", "border-radius": "4px", "border": "none",
              "font-size": "16px",  "font-weight": "bold"}}>Cerrar Detalles
            </button>
            <TableContainer component={Paper} style={{"margin-top": "20px", "margin-left": "260px", "padding": "5px"}}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>ID Entrada</TableCell>
                    <TableCell>ID Producto</TableCell>
                    <TableCell>Cantidad</TableCell>
                    <TableCell>Precio Unitario</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {filteredEntradasDetalle.map((entradaDetalle) => (
                    <TableRow key={`${entradaDetalle.identrada_id}-${entradaDetalle.idproducto_id}`}>
                      <TableCell>{entradaDetalle.identrada_id}</TableCell>
                      <TableCell>{entradaDetalle.idproducto_id}</TableCell>
                      <TableCell>{entradaDetalle.cantidad}</TableCell>
                      <TableCell>{entradaDetalle.preciounitario}</TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
          </>
        )}
      </>
    );
  };

  return (
    <div>
      <Sidebar/>
      <NavBar/>
      <div>
        <h2 style={{"margin-top": "100px", "margin-left": "260px", "margin-bottom": "0px", "padding": "5px",
              "color": "#003084", "border": "none", "font-size": "24px", "font-weight": "bold"}}>Entradas
        </h2>
        {renderEntradas()}
        {selectedEntrada && (
          <>
            <h2 style={{"margin-top": "50px", "margin-left": "260px", "margin-bottom": "0px", "padding": "5px",
              "color": "#003084", "border": "none", "font-size": "24px", "font-weight": "bold"}}>Entradas Detalle</h2>
            {renderEntradasDetalle()}
          </>
        )}
      </div>
    </div>
  );
};