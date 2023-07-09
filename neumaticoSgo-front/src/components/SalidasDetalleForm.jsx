
import React, { useState, useEffect } from 'react';
import '../css/form.css';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import { useNavigate } from 'react-router-dom';

export function RegistroSalidaDetalleForm() {
    const navigate = useNavigate();
    const [idsalida_id, setIdSalida] = useState("");
    const [idproducto_id, setIdProducto] = useState("");
    const [cantidad, setCantidad] = useState("");
    const [preciounitario, setPrecioUnitario] = useState("");
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
                const response = await fetch('http://127.0.0.1:8000/api/salidas/');
                const data = await response.json();
                console.log('Esto es response salida', response)
                console.log('Esto es data salida', data)
                if (response.ok && data.salidas.length > 0) {
                    const lastId = data.salidas[data.salidas.length - 1].idsalida;
                    console.log('Esto es lastid', lastId)
                    setLastInsertedId(lastId);
                    setIdSalida(lastId);
                } else {
                    console.log('error al obtener el último id de salida');
                }
            } catch (error) {
                console.log('error de red', error);
            }
        };

        fetchLastInsertedId();
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();

        const salidaDetalle = {
            idsalida_id,
            idproducto_id,
            cantidad,
            preciounitario
        }

        try {
            const response = await fetch('http://127.0.0.1:8000/api/salida_detalles/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(salidaDetalle),
            });

            if (response.ok) {
                console.log('detalle de salida creado exitosamente');
                console.log('esto es respone de salida detalle', response)
                navigate('/salidas');
            } else {
                console.log('error al crear el detalle de salida');
            }
        } catch (error) {
            console.log('error de red', error);
        }
        console.log('Salidas detalle', salidaDetalle)
    };

    return (
        <div className='container'>
            <Sidebar />
            <NavBar />
            <form className='form' onSubmit={handleSubmit}>
                <h1 className='title'>Registro de Detalle de Salida</h1>
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
                        onChange={(e) => setIdProducto(e.target.value)}
                    >
                        <option value=''>Seleccione un producto</option>
                        {productos.map((producto) => (
                            <option key={producto.idproducto} value={producto.idproducto}>
                                {producto.nombre}
                            </option>
                        ))}
                    </select>
                    <br />
                    <label>Cantidad</label>
                    <input
                        type='number'
                        name='cantidad'
                        onChange={(e) => setCantidad(e.target.value)}
                    />
                    <br />
                    <label>Precio Unitario</label>
                    <input
                        type='number'
                        name='precio-unitario'
                        onChange={(e) => setPrecioUnitario(e.target.value)}
                    />
                </div>
                <button className='button' type='submit'>
                    Enviar
                </button>
            </form>
        </div>
    );
}
