import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import { TableContainer, Table, TableHead, TableRow, TableCell, TableBody, Paper } from '@mui/material';

export const TablaSalidasMovimientos = () => {
  const [salidas, setSalidas] = useState([]);
  const [salidasDetalle, setSalidasDetalle] = useState([]);
  const [selectedSalidas, setSelectedSalidas] = useState(null);
  const [showSalidasDetalle, setShowSalidasDetalle] = useState(false);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const responseSalida = await axios.get('http://127.0.0.1:8000/api/salidas/');
      const responseSalidaDetalles = await axios.get('http://127.0.0.1:8000/api/salida_detalles/');
      setSalidas(responseSalida.data.salidas);
      setSalidasDetalle(responseSalidaDetalles.data.salidas);
    } catch (error) {
      console.error('Error al obtener los datos:', error);
    }
  };

  const renderSalidas = () => {
    const handleSalidasClick = (idsalida) => {
      setSelectedSalidas(idsalida);
      setShowSalidasDetalle(true);
    };

    return (
      <TableContainer component={Paper} style={{ "margin-top": "10px", "margin-left": "260px", "padding": "5px" }}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Id Salida</TableCell>
              <TableCell>ID Proveedor</TableCell>
              <TableCell>Fecha</TableCell>
              <TableCell>Monto Total</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {salidas.map((salida) => (
              <TableRow key={salida.idsalida} onClick={() => handleSalidasClick(salida.idsalida)}>
                <TableCell>{salida.idsalida}</TableCell>
                <TableCell>{salida.idproveedor_id}</TableCell>
                <TableCell>{salida.fecha}</TableCell>
                <TableCell>{salida.montototal}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    );
  };

  const renderSalidasDetalle = () => {
    const filteredSalidasDetalle = salidasDetalle.filter(
      (salidasDetalle) => salidasDetalle.idsalida_id === selectedSalidas
    );

    const handleCloseSalidasDetalle = () => {
      setShowSalidasDetalle(false);
      setSelectedSalidas(null);
    };

    return (
      <>
        {showSalidasDetalle && (
          <>
            <button onClick={handleCloseSalidasDetalle}
              style={{
                "margin-top": "20px", "margin-left": "260px", "padding": "5px", "width": "15%",
                "color": "white", "background-color": "#003084", "border-radius": "4px", "border": "none",
                "font-size": "16px", "font-weight": "bold"
              }}>Cerrar Detalles
            </button>
            <TableContainer component={Paper} style={{ "margin-top": "20px", "margin-left": "260px", "padding": "5px" }}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>ID Salidas</TableCell>
                    <TableCell>ID Producto</TableCell>
                    <TableCell>Cantidad</TableCell>
                    <TableCell>Precio Unitario</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {filteredSalidasDetalle.map((salidasDetalle) => (
                    <TableRow key={`${salidasDetalle.idsalida_id}-${salidasDetalle.idproducto_id}`}>
                      <TableCell>{salidasDetalle.idsalida_id}</TableCell>
                      <TableCell>{salidasDetalle.idproducto_id}</TableCell>
                      <TableCell>{salidasDetalle.cantidad}</TableCell>
                      <TableCell>{salidasDetalle.preciounitario}</TableCell>
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
      <Sidebar />
      <NavBar />
      <div>
        <h2 style={{
          "margin-top": "100px", "margin-left": "260px", "margin-bottom": "0px", "padding": "5px",
          "color": "#003084", "border": "none", "font-size": "24px", "font-weight": "bold"
        }}>Salidas
        </h2>
        {renderSalidas()}
        {selectedSalidas && (
          <>
            <h2 style={{
              "margin-top": "50px", "margin-left": "260px", "margin-bottom": "0px", "padding": "5px",
              "color": "#003084", "border": "none", "font-size": "24px", "font-weight": "bold"
            }}>Salidas Detalle</h2>
            {renderSalidasDetalle()}
          </>
        )}
      </div>
    </div>
  );
};