//import React from "react";
import { useState } from "react";
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

    const handleSubmit = async (e) => {
        e.preventDefault()

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
    return (
        <div className='container'>
            <Sidebar />
            <NavBar />
            <form className='form' onSubmit={handleSubmit}>
                <h1 className='title' >Registro de Entrada</h1>
                <div className='input-control'
                >
                    <label>Id de Proveedor</label>
                    <input
                        type='number'
                        name='id-proveedor'
                        onChange={(e) => setIdProveedor(e.target.value)}
                    />
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
            <RegistroEntradaDetalleForm/>
        </div>
    )
}