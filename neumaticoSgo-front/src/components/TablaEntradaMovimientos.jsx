import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';

export const TablaEntradasMovimientos = () => {
  const [entradas, setEntradas] = useState([]);
  const [entradasDetalle, setEntradaDetalle] = useState([])


  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const responseEntradas = await axios.get('http://127.0.0.1:8000/api/entradas/'); // Reemplaza 'URL_DE_TU_API' con la URL real de tu API
      const responseEntradasDetalles = await axios.get('http://127.0.0.1:8000/api/entrada_detalles/')
      setEntradas(responseEntradas.data.entradas);
      console.log(responseEntradas.data.entradas)
      setEntradaDetalle(responseEntradasDetalles.data.entradas)
      console.log('esto es entradas detalle', responseEntradasDetalles.data)
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };
  const renderEntradas = () => {
    return (
      <TableContainer component={Paper} style={{"margin-top": "80px", "margin-left": "260px", "padding": "5px"}}>
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
              <TableRow key={entrada.identrada}>
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
    return (
      <TableContainer component={Paper} style={{"margin-top": "80px", "margin-left": "260px", "padding": "5px"}}>
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
            {entradasDetalle.map((entradaDetalle) => (
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
    );
  };

  return (
    <div>
      <Sidebar/>
      <NavBar/>
      <div>
      <h2>Entradas</h2>
      {renderEntradas()}
      <h2>Entradas Detalles</h2>
      {renderEntradasDetalle()}

      </div>
    </div>
  );
};
