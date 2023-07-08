import React, { useEffect, useState } from 'react';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';
import axios from 'axios';

export const TablaProveedores = () => {
  const [proveedores, setData] = useState([]);
  const [tablaProveedores, setTablaProveedores] = useState([]);
  const [busqueda, setBusqueda]= useState("");

  const handleChange = (event) => {
    console.log(event.target.value);
    setBusqueda(event.target.value);
    filtrar(event.target.value);
  }

  const filtrar = (terminoBusqueda) => {
    let resultadosBusqueda = tablaProveedores.filter((elemento) => {
      if(elemento.nombre.toString().toLowerCase().includes(terminoBusqueda.toLowerCase())){
        return elemento;
      }
    })
    setData(resultadosBusqueda);
  }

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async (searchTerm = '') => {
    try {
      const response = await axios.get(`http://127.0.0.1:8000/api/proveedores/?search=${searchTerm}`);
      setData(response.data.proveedores);
      setTablaProveedores(response.data.proveedores)
      console.log(response.data.proveedores);
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };

  return (
    <div>
      <div className='barra-busqueda'>
      <input type="text" placeholder="Buscar proveedores..." value={busqueda} 
        onChange={handleChange}
      />
      </div>
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
    </div>
  );
};
