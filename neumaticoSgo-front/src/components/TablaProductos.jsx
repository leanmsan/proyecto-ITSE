import React, { useEffect, useState } from 'react';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';
import axios from 'axios';

export const TablaProductos = () => {
  const [productos, setData] = useState([]);
  const [tablaProductos, setTablaProductos] = useState([]);
  const [busqueda, setBusqueda]= useState("");

  const handleChange = (event) => {
    console.log(event.target.value);
    setBusqueda(event.target.value);
    filtrar(event.target.value);
  }

const filtrar = (terminoBusqueda) => {
let resultadosBusqueda = tablaProductos.filter((elemento) => {
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
      const response = await axios.get(`http://127.0.0.1:8000/api/productos/?search=${searchTerm}`);
      setData(response.data.productos);
      setTablaProductos(response.data.productos)
      console.log(response.data.productos);
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };
  

  return (
    <div>
      <div className='barra-busqueda'>
      <input type="text" placeholder="Buscar productos..." value={busqueda} 
        onChange={handleChange}
      />
      </div>
      <TableContainer style={{"margin-top": "80px", "margin-left": "260px", "padding": "5px"}} component={Paper}>
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
    </div>
    
  );
};
