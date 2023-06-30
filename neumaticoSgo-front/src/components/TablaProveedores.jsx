import React, { useEffect, useState } from 'react';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';
import axios from 'axios';

export const TablaProveedores = () => {
  const [proveedores, setData] = useState([]);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/proveedores/'); // Reemplaza 'URL_DE_TU_API' con la URL real de tu API
      setData(response.data.proveedores);
      console.log(response.data.proveedores)
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };

  return (
    <TableContainer style={{"margin-top": "80px", "margin-left": "260px", "padding": "5px"}} component={Paper}>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>Nombre</TableCell>
            <TableCell>CUIT</TableCell>
            <TableCell>Razon Social</TableCell>
            <TableCell>Direccion</TableCell>
            <TableCell>Localidad</TableCell>
            <TableCell>Provincia</TableCell>
            <TableCell>Contacto</TableCell>
            <TableCell>Estado</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {proveedores.map((row) => (
            <TableRow key={row.idproveedor}>
              <TableCell>{row.nombre}</TableCell>
              <TableCell style={{ textTransform: 'capitalize'}}>{row.cuitproveedor}</TableCell>
              <TableCell>{row.razonsocial}</TableCell>
              <TableCell>{row.direccion}</TableCell>
              <TableCell>{row.localidad}</TableCell>
              <TableCell>{row.provincia}</TableCell>
              <TableCell>{row.contacto}</TableCell>
              <TableCell>{row.estado}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};
