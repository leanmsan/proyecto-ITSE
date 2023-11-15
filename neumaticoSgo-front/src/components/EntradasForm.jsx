import React, { useState, useEffect } from 'react';
import "../css/form.css"
import { Sidebar } from "./Sidebar";
import { NavBar } from "./NavBar";
import { useNavigate } from "react-router-dom";
import { RegistroEntradaDetalleForm } from "./EntradasDetalleForm";

export function RegistroEntradasForm() {
    const navegate = useNavigate()
    const [idproveedor_id, setIdProveedor] = useState("")
    const [errorIdProveedor, setErrorIdProveedor] = useState(false);

    const [fecha, setFecha] = useState("")
    const [errorFecha, setErrorFecha] = useState(false);

    const [montototal, setMontoTotal] = useState("")
    const [errorMontoTotal, setErrorMontoTotal] = useState(false);

    const [proveedores, setProveedores] = useState([]);

    const handleSubmit = async (e) => {
        e.preventDefault();

        const entrada = {
            idproveedor_id,
            fecha,
            montototal,
        };

        try {
            const response = await fetch('http://127.0.0.1:8000/api/entradas/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(entrada)
            })

            if (idproveedor_id.trim() === '') {
                setErrorIdProveedor(true);
            } else {
                setErrorIdProveedor(false)
            }

            if (fecha.trim() === '') {
                setErrorFecha(true);
            } else {
                setErrorFecha(false)
            }

            if (montototal.trim() === '') {
                setErrorMontoTotal(true);
            } else {
                setErrorMontoTotal(false)
            }

            if (response.ok) {
                console.log(response, "esto es response")
                console.log('entrada creada exitosamente')
                navegate('/registroentradas')
            } else {
                console.log('error al crear la entrada')
            }
        } catch (error) {
            console.log('error de red', error)

        }

    }

    useEffect(() => {
        const fetchProveedores = async () => {
            try {
                // Obtener la lista de proveedores
                const response = await fetch('http://127.0.0.1:8000/api/proveedores/');
                const data = await response.json();

                if (response.ok) {
                    setProveedores(data.proveedores);
                } else {
                    console.log('error al obtener los proveedores');
                }
            } catch (error) {
                console.log('error de red', error);
            }
        };

        fetchProveedores();
    }, []);

    return (
        <div className='container'>
            <Sidebar />
            <NavBar />
            <form className='form' onSubmit={handleSubmit}>
                <h1 className='title' >Registro de Entrada</h1>
                <div className='input-control'
                >
                    <div className='input-control'>
                        <label>Proveedor</label>
                        <select
                            name='proveedor'
                            value={idproveedor_id}
                            onChange={(e) => { setIdProveedor(e.target.value)
                            setErrorIdProveedor(false)}}
                        >
                            <option value=''>Seleccione un proveedor</option>
                            {proveedores.map((proveedor) => (
                                <option key={proveedor.idproveedor} value={proveedor.idproveedor}>
                                    {proveedor.nombre}
                                </option>
                            ))}
                        </select>
                    </div>
                    {errorIdProveedor && <div className="error-message">Es requerido que seleccion un proveedor</div>}
                    <br />
                    <label>Fecha</label>
                    <input
                        type='date'
                        name='fecha'
                        onChange={(e) => { setFecha(e.target.value)
                        setErrorFecha(false)}}
                    />
                    {errorFecha && <div className="error-message">Es requerido que ingrese una fecha</div>}
                    <br />

                    <label>Monto Total</label>
                    <input
                        type='text'
                        name='monto-total'
                        onChange={(e) => { setMontoTotal(e.target.value)
                        setErrorMontoTotal(false)}}
                    />
                    {errorMontoTotal && <div className="error-message">Es requerido que ingrese un monto total</div>}
                </div>
                <button className='button' type="submit">Enviar</button>
            </form>
            <RegistroEntradaDetalleForm />
        </div>
    )
}