
import React, { useState, useEffect } from 'react';
import '../css/form.css';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import { useNavigate } from 'react-router-dom';

export function RegistroEntradaDetalleForm() {
  const navigate = useNavigate();
  
  const [identrada_id, setIdEntrada] = useState('');

  const [idproducto_id, setIdProducto] = useState('');
  const [errorProductoid, setErrorProductoid] = useState(false);

  const [cantidad, setCantidad] = useState(0);
  const [errorCantidad, setErrorCantidad] = useState(false);

  const [preciounitario, setPrecioUnitario] = useState('');
  const [errorPrecioUnitario, setErrorPrecioUnitario] = useState(false);
  
  const [productos, setProductos] = useState([]);

  const [lastInsertedId, setLastInsertedId] = useState('');

  useEffect(() => {
    const fetchProductos = async () => {
      try {
        const response = await fetch('http://127.0.0.1:8000/api/productos/');
        const data = await response.json();

        if (response.ok) {
          setProductos(data.productos);
        } else {
          console.log('error al obtener los productos');
        }
      } catch (error) {
        console.log('error de red', error);
      }
    };

    fetchProductos();
  }, []);

  useEffect(() => {
    const fetchLastInsertedId = async () => {
      try {
        const response = await fetch('http://127.0.0.1:8000/api/entradas/');
        const data = await response.json();
        console.log('Esto es response', response)
        console.log('Esto es data', data)
        if (response.ok && data.entradas.length > 0) {
          const lastId = data.entradas[data.entradas.length - 1].identrada;
          console.log('Esto es lastid', lastId)
          setLastInsertedId(lastId);
          setIdEntrada(lastId);
        } else {
          console.log('error al obtener el último id de entrada');
        }
      } catch (error) {
        console.log('error de red', error);
      }
    };

    fetchLastInsertedId();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();

    const entradaDetalle = {
      identrada_id,
      idproducto_id,
      cantidad,
      preciounitario,
    };

    try {
      const response = await fetch('http://127.0.0.1:8000/api/entrada_detalles/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(entradaDetalle),
      });

      if (idproducto_id.trim() === '') {
        setErrorProductoid(true);
      }else{
        setErrorProductoid(false)
      }

      if (cantidad <= 0) {
        setErrorCantidad(true);
      }else{
        setErrorCantidad(false)
      }
  
      if (preciounitario.trim() === '') {
        setErrorPrecioUnitario(true);
      }else{
        setErrorPrecioUnitario(false)
      }

      if (response.ok) {
        console.log('detalle de entrada creado exitosamente');
        navigate('/entradas');
      } else {
        console.log('error al crear el detalle de entrada');
      }
    } catch (error) {
      console.log('error de red', error);
    }
  };

  return (
    <div className='container'>
      <Sidebar />
      <NavBar />
      <form className='form' onSubmit={handleSubmit}>
        <h1 className='title'>Registro de Detalle de Entrada</h1>
        <div className='input-control'>
          <input
            type='hidden'
            name='last-inserted-id'
            value={lastInsertedId}
          />
          <br />
          <label>Producto</label>
          <select
            name='producto'
            value={idproducto_id}
            onChange={(e) => {setIdProducto(e.target.value)
              setErrorProductoid(false)}}
          >
            <option value=''>Seleccione un producto</option>
            {productos.map((producto) => (
              <option key={producto.idproducto} value={producto.idproducto}>
                {producto.nombre}
              </option>
            ))}
          </select>
          {errorProductoid && <div className='error-message'>Es requerido que seleccione un producto</div>}
          <br />
          <label>Cantidad</label>
          <input
            type='number'
            name='cantidad'
            onChange={(e) => {setCantidad(e.target.value)
              setErrorCantidad(false)}}
          />
          {errorCantidad && <div className='error-message'>Es requerido que ingrese una cantidad</div>}
          <br />
          <label>Precio Unitario</label>
          <input
            type='text'
            name='precio-unitario'
            onChange={(e) => {setPrecioUnitario(e.target.value)
              setErrorPrecioUnitario(false)}}
          />
          {errorPrecioUnitario && <div className='error-message'>Es requerido que ingrese un precio unitario</div>}
        </div>
        <button className='button' type='submit'>
          Enviar
        </button>
      </form>
    </div>
  );
}
