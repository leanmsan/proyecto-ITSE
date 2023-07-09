import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import "../css/form.css"
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';

export function DynamicForm() {
  const navigate = useNavigate();
<<<<<<< Updated upstream

  const [nombre, setNombre] = useState('');
  const [errorNombre, setErrorNombre] = useState(false);

  const [descripcion, setDescripcion] = useState('');
  const [errorDescripcion, setErrorDescripcion] = useState(false);

  const [preciocompra, setPrecioCompra] = useState('');
  const [errorPrecioCompra, setErrorPrecioCompra] = useState(false);

  const [precioventa, setPrecioVenta] = useState('');
  const [errorPrecioVenta, setErrorPrecioVenta] = useState(false);

  const [marca, setMarca] = useState('');
  const [errorMarca, setErrorMarca] = useState(false);

  const [stockdisponible, setStockDisponible] = useState(0);
  const [errorStockDisponible, setErrorStockDisponible] = useState(false);

  const [rubro_id, setRubro_id] = useState('');
  const [errorRubro, setErrorRubro] = useState(false);
=======
  const [campos, setCampos] = useState({
    nombre: '',
    descripcion: '',
    preciocompra: '',
    precioventa: '',
    marca: '',
    stockdisponible: 0,
    rubro_id: '',
  });

  const [error, setError] = useState({
    nombre: false,
    descripcion: false,
    preciocompra: false,
    precioventa: false,
    marca: false,
    stockdisponible: false,
    rubro_id: false,
  });
>>>>>>> Stashed changes

  const [caracteristicas, setCaracteristicas] = useState({});
  const [nuevaCaracteristica, setNuevaCaracteristica] = useState({
    clave: '',
    valor: ''
  });

<<<<<<< Updated upstream
=======
  const handleChange = (event) => {
    const { name, value } = event.target;
    setCampos((prevCampos) => ({
      ...prevCampos,
      [name]: value
    }));
    setError((prevErrores) => ({
      ...prevErrores,
      [name]: false
    }));
  };
>>>>>>> Stashed changes

  const handleSubmit = async (e) => {
    e.preventDefault();

    let tieneErrores = false;

    Object.keys(campos).forEach((campo) => {
      if (campos[campo] === '' || campos[campo] === 0) {
        setError((prevErrores) => ({
          ...prevErrores,
          [campo]: true
        }));
        tieneErrores = true;
      }
    });

    if (tieneErrores) {
      return;
    }

    /*const producto = {
      nombre : campos.nombre,
      descripcion : campos.descripcion,
      preciocompra : campos.preciocompra,
      precioventa : campos.precioventa,
      marca : campos.marca,
      stockdisponible : campos.stockdisponible,
      rubro_id : campos.rubro_id,
      caracteristicas,
    };*/

    try {
      const response = await fetch('http://127.0.0.1:8000/api/productos/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(campos),
      });
  
<<<<<<< Updated upstream

      if (nombre.trim() === '') {
      setErrorNombre(true);
    }else{
      setErrorNombre(false)
    }

    if (descripcion.trim() === '') {
      setErrorDescripcion(true);
    }else{
      setErrorDescripcion(false)
    }

    if (preciocompra.trim() === '') {
      setErrorPrecioCompra(true);
    }else{
      setErrorPrecioCompra(false)
    }

    if (precioventa.trim() === '') {
      setErrorPrecioVenta(true);
    }else{
      setErrorPrecioVenta(false)
    }

    if (marca.trim() === '') {
      setErrorMarca(true);
    }else{
      setErrorMarca(false)
    }

    if (stockdisponible <= 0) {
      setErrorStockDisponible(true);
    }else{
      setErrorStockDisponible(false)
    }

    if (rubro_id.trim() === '') {
      setErrorRubro(true);
    }else{
      setErrorRubro(false)
    }

=======
>>>>>>> Stashed changes
      if (response.ok) {
        console.log('El formulario se envió correctamente');
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
      <form className='form' onSubmit={handleSubmit} >
        <h1 className='title'>Alta de Producto</h1>
        <div className='input-control'>
          <label>
            Nombre
            <input
              type='text'
<<<<<<< Updated upstream
              value={nombre}
              onChange={(e) => {setNombre(e.target.value)
                                setErrorNombre(false)}}
            />
            {errorNombre && <div className="error-message">Nombre es requerido</div>}
=======
              name= 'nombre'
              value={campos.nombre}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio</div>}
>>>>>>> Stashed changes
          </label>
          <br />
          <label>
            Descripción
            <input
              type='text'
<<<<<<< Updated upstream
              value={descripcion}
              onChange={(e) => {setDescripcion(e.target.value)
                setErrorDescripcion(false)}}
            />
            {errorDescripcion && <div className="error-message">Descripcion es requerida</div>}
=======
              name= 'descripcion'
              value={campos.descripcion}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio</div>}
>>>>>>> Stashed changes
          </label>
          <br />
          <label>
            Precio de Compra
            <input
              type='text'
<<<<<<< Updated upstream
              value={preciocompra}
              onChange={(e) => {setPrecioCompra(e.target.value)
                setErrorPrecioCompra(false)}}
            />
            {errorPrecioCompra && <div className="error-message">El precio de compra es requerido</div>}
=======
              name= 'preciocompra'
              value={campos.preciocompra}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio</div>}
>>>>>>> Stashed changes
          </label>
          <br />
          <label>
            Precio de Venta
            <input
              type='text'
<<<<<<< Updated upstream
              value={precioventa}
              onChange={(e) => {setPrecioVenta(e.target.value)
                setErrorPrecioVenta(false)}}
            />
            {errorPrecioVenta && <div className="error-message">El precio de venta es requerido</div>}
=======
              name= 'precioventa'
              value={campos.precioventa}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio</div>}
>>>>>>> Stashed changes
          </label>
          <br />
          <label>
            Marca
            <input
              type='text'
<<<<<<< Updated upstream
              value={marca}
              onChange={(e) => {setMarca(e.target.value)
                setErrorMarca(false)}}
            />
            {errorMarca && <div className="error-message">La marca es requerida</div>}
=======
              name= 'marca'
              value={campos.marca}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio</div>}
>>>>>>> Stashed changes
          </label>
          <br />
          <label>
            Stock Disponible
            <input
              type='number'
<<<<<<< Updated upstream
              value={stockdisponible}
              onChange={(e) => {setStockDisponible(e.target.value)
                setErrorStockDisponible(false)}}
            />
            {errorStockDisponible && <div className="error-message">El stock disponible debe ser mayor a 0</div>}
=======
              name= 'stockdisponible'
              value={campos.stockdisponible}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio o ser 0</div>}
>>>>>>> Stashed changes
          </label>
          <br />
          <label>
            Rubro
            <input
              type='text'
<<<<<<< Updated upstream
              value={rubro_id}
              onChange={(e) => {setRubro_id(e.target.value)
                setErrorRubro(false)}}
            />
            {errorRubro && <div className="error-message">El rubro es requerido</div>}
=======
              name= 'rubro_id'
              value={campos.rubro_id}
              onChange={handleChange}
            />
            {error.campo1 && <div className="error-message">Este campo no puede estar vacio</div>}
>>>>>>> Stashed changes
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
              <label>
              <input
                type='text'
                placeholder='clave'
                value={nuevaCaracteristica.clave}
                onChange={(e) => setNuevaCaracteristica({ ...nuevaCaracteristica, clave: e.target.value })}
              />   
              </label>
              <label>
              <input
                type="text"
                placeholder='valor'
                value={nuevaCaracteristica.valor}
                onChange={(e) => setNuevaCaracteristica({ ...nuevaCaracteristica, valor: e.target.value })}
              />
              </label>
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
