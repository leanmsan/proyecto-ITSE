
import React, { useState, useEffect } from 'react';
import "../css/form.css"
import { Sidebar } from "./Sidebar";
import { NavBar } from "./NavBar";
import { useNavigate } from "react-router-dom";
import { RegistroEntradaDetalleForm } from "./EntradasDetalleForm";

export function RegistroEntradasForm() {
    const navegate = useNavigate()
    const [idproveedor_id, setIdProveedor] = useState("")
    const [fecha, setFecha] = useState("")
    const [montototal, setMontoTotal] = useState("")
    const [proveedores, setProveedores] = useState([]);
    const handleSubmit = async (e) => {
        

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
                            onChange={(e) => setIdProveedor(e.target.value)}
                        >
                            <option value=''>Seleccione un proveedor</option>
                            {proveedores.map((proveedor) => (
                                <option key={proveedor.idproveedor} value={proveedor.idproveedor}>
                                    {proveedor.nombre}
                                </option>
                            ))}
                        </select>
                    </div>
                    <br />
                    <label>Fecha</label>
                    <input
                        type='date'
                        name='fecha'
                        onChange={(e) => setFecha(e.target.value)}
                    />

                    <br />

                    <label>Monto Total</label>
                    <input
                        type='text'
                        name='monto-total'
                        onChange={(e) => setMontoTotal(e.target.value)}
                    />
                </div>
                <button className='button' type="submit">Enviar</button>
            </form>
            <RegistroEntradaDetalleForm />
        </div>
    )
}