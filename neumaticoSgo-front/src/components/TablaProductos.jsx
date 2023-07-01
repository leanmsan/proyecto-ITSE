import React, { useEffect, useState } from 'react';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';
import axios from 'axios';

export const TablaProductos = () => {
  const [productos, setData] = useState([]);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/productos/'); // Reemplaza 'URL_DE_TU_API' con la URL real de tu API
      setData(response.data.productos);
      console.log(response.data.productos)
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };

  return (
    <TableContainer style={{"margin-top": "80px", "margin-left": "10px", "padding": "5px"}} component={Paper}>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>Nombre</TableCell>
            <TableCell>Rubro</TableCell>
            <TableCell>Marca</TableCell>
            <TableCell>Precio Compra</TableCell>
            <TableCell>Precio Venta</TableCell>
            <TableCell>Stock</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {productos.map((row) => (
            <TableRow key={row.idproducto}>
              <TableCell>{row.nombre}</TableCell>
              <TableCell style={{ textTransform: 'capitalize'}}>{row.rubro_id}</TableCell>
              <TableCell>{row.marca}</TableCell>
              <TableCell>{row.preciocompra}</TableCell>
              <TableCell>{row.precioventa}</TableCell>
              <TableCell>{row.stockdisponible}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};
