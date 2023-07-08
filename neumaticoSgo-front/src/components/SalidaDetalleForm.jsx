//import React from "react";
import { useState } from "react";
import "../css/form.css"
import { Sidebar } from "./Sidebar";
import { NavBar } from "./NavBar";
import { useNavigate } from "react-router-dom";

export function RegistroSalidaDetalleForm() {
    const navegate = useNavigate()
    const [idsalida_id, setIdSalida] = useState("")
    const [idproducto_id, setIdProducto] = useState("")
    const [cantidad, setCantidad] = useState("")
    const [preciounitario, setPrecioUnitario] = useState("")

    const handleSubmit = async (e) => {
        e.preventDefault()

        const entradaDetalle = {
            idsalida_id,
            idproducto_id,
            cantidad,
            preciounitario,
        };

        try {
            const response = await fetch('http://127.0.0.1:8000/api/salida_detalles/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(entradaDetalle)
            })
            if (response.ok) {
                console.log(response, "esto es response")
                console.log('salida creada exitosamente')
                navegate('/salidas')
            } else {
                console.log('error al crear la salida')
            }
        } catch (error) {
            console.log('error de red', error)

        }
    }
    return (
        <div className='container'>
            <Sidebar />
            <NavBar />
            <form className='form' onSubmit={handleSubmit}>
                <h1 className='title' >Registro de Detalle de Entrada</h1>
                <div className='input-control'
                >
                    <label>Id de Salida</label>
                    <input
                        type='number'
                        name='id-entrada'
                        onChange={(e) => setIdSalida(e.target.value)}
                    />
                    <br />
                    <label>Id de Producto</label>
                    <input
                        type='number'
                        name='id-producto'
                        onChange={(e) => setIdProducto(e.target.value)}
                    />

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
                        type='text'
                        name='precio-unitario'
                        onChange={(e) => setPrecioUnitario(e.target.value)}
                    />
                </div>
                <button className='button' type="submit">Enviar</button>
            </form>
        </div>
    )
}