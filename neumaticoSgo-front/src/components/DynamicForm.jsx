import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "../css/form.css"
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';

export function DynamicForm() {
  const navigate = useNavigate();
  const [nombre, setNombre] = useState('');
  const [descripcion, setDescripcion] = useState('');
  const [preciocompra, setPrecioCompra] = useState('');
  const [precioventa, setPrecioVenta] = useState('');
  const [marca, setMarca] = useState('');
  const [stockdisponible, setStockDisponible] = useState(0);
  const [rubro_id, setRubro_id] = useState('');
  const [caracteristicas, setCaracteristicas] = useState({});
  const [nuevaCaracteristica, setNuevaCaracteristica] = useState({
    clave: '',
    valor: ''
  });

  const handleSubmit = async (e) => {
    e.preventDefault();

    const producto = {
      nombre,
      descripcion,
      preciocompra,
      precioventa,
      marca,
      stockdisponible,
      rubro_id,
      caracteristicas,
    };

    try {
      const response = await fetch('http://127.0.0.1:8000/api/productos/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(producto),
      });

      if (response.ok) {
        console.log('El formulario se envió correctamente');
        navigate('/productos');
      } else {
        console.log('Error al enviar el formulario');
      }
    } catch (error) {
      console.log('Error en la solicitud POST', error);
    }
  };

  const handleAgregarCaracteristica = (e) => {
    e.preventDefault();

    const { clave, valor } = nuevaCaracteristica;

    if (clave && valor) {
      setCaracteristicas({
        ...caracteristicas,
        [clave]: valor,
      });

      setNuevaCaracteristica({
        clave: '',
        valor: '',
      });
    }
  };

  return (
    <div className='container'>
      <Sidebar />
      <NavBar />
      <form className='form' onSubmit={handleSubmit}>
        <h1 className='title'>Alta de Producto</h1>
        <div className='input-control'>
          <label>
            Nombre
            <input
              type='text'
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
            />
          </label>
          <br />
          <label>
            Descripción
            <input
              type='text'
              value={descripcion}
              onChange={(e) => setDescripcion(e.target.value)}
            />
          </label>
          <br />
          <label>
            Precio de Compra
            <input
              type='text'
              value={preciocompra}
              onChange={(e) => setPrecioCompra(e.target.value)}
            />
          </label>
          <br />
          <label>
            Precio de Venta
            <input
              type='text'
              value={precioventa}
              onChange={(e) => setPrecioVenta(e.target.value)}
            />
          </label>
          <br />
          <label>
            Marca
            <input
              type='text'
              value={marca}
              onChange={(e) => setMarca(e.target.value)}
            />
          </label>
          <br />
          <label>
            Stock Disponible
            <input
              type='number'
              value={stockdisponible}
              onChange={(e) => setStockDisponible(e.target.value)}
            />
          </label>
          <br />
          <label>
            Rubro
            <input
              type='text'
              value={rubro_id}
              onChange={(e) => setRubro_id(e.target.value)}
            />
          </label>
          <br />
          <label>
            Características
            <br />
            {Object.keys(caracteristicas).map((key) => (
              <div key={key}>
                <input
                  type="text"
                  value={caracteristicas[key]}
                  readOnly
                />
              </div>
            ))}
            <br />
            <div>
              <input
                type='text'
                placeholder='clave'
                value={nuevaCaracteristica.clave}
                onChange={(e) => setNuevaCaracteristica({ ...nuevaCaracteristica, clave: e.target.value })}
              />

              <input
                type="text"
                placeholder='valor'
                value={nuevaCaracteristica.valor}
                onChange={(e) => setNuevaCaracteristica({ ...nuevaCaracteristica, valor: e.target.value })}
              />

            </div>
            <button type='button' onClick={handleAgregarCaracteristica}>
              Agregar Característica
            </button>
          </label>
          <br />
        </div>

        <button className='button' type="submit">Enviar</button>
      </form>
    </div>
  );
}
