import React from "react";
import { useState } from "react";
import "../css/form.css"
import { Sidebar } from "./Sidebar";
import { NavBar } from "./NavBar";
import { useNavigate } from "react-router-dom";

export function ProveedoresForm () {
    const navegate = useNavigate()
    const [cuitproveedor, setCuitProveedor] = useState("")
    const [nombre, setNombre] = useState("")
    const [razonsocial, setRazonSocial] = useState("")
    const [direccion, setDireccion] = useState("")
    const [localidad, setLocalidad] = useState("")
    const [provincia, setProvincia] = useState("")
    const [contacto, setContacto] = useState("")
    const [estado, setEstado] = useState("")

    const handleSubmit = async (e) => {
        e.preventDefault()
        
        const proveedor = {
            cuitproveedor,
            nombre,
            razonsocial,
            direccion,
            localidad,
            provincia,
            contacto,
            estado,
          };
    
         try {
            const response = await fetch('http://127.0.0.1:8000/api/proveedores/', {
                method : 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(proveedor)
            })
            if (response.ok) {
                console.log(response, "esto es response")
                console.log('proveedor creado exitosamente')
                navegate('/proveedores')
            } else {
                console.log('error al crear el proveedor')
            }
         } catch (error) {
            console.log('error de red', error)
            
         }
    }
    return (
        <div className='container'>
        <Sidebar/>
        <NavBar/>
          <form className='form' onSubmit={handleSubmit}>
            <h1 className='title' >Alta de Proveedores</h1>
          <div className='input-control'
          >
            <label>Cuit Proveedor</label>
            <input
              type='text'
              name='cuit Proveedor'
              onChange={(e) => setCuitProveedor(e.target.value)}
            />
            <br />
            <label>Nombre</label>
            <input
              type='text'
              name='nombre'
              onChange={(e) => setNombre(e.target.value)}
            />

            <br />

            <label>Razón Social</label>
            <input
              type='text'
              name='razon social'
              onChange={(e) => setRazonSocial(e.target.value)}
            />
            <br />

            
            <label>Dirección</label>
            <input
              type='text'
              name='direccion'
              onChange={(e) => setDireccion(e.target.value)}
            />

            <br />

            <label>Localidad</label>
            <input
              type='text'
              name='localidad'
              onChange={(e) => setLocalidad(e.target.value)}
            />
            <br />

            <label>Provincia</label>
            <input
              type='text'
              name='provincia'
              onChange={(e) => setProvincia(e.target.value)}
            />
            <br />

            <label>Contacto</label>
            <input
              type='text'
              name='contacto'
              onChange={(e) => setContacto(e.target.value)}
            />
            <br />

            <label>Estado</label>
            <input
              type='text'
              name='contacto'
              onChange={(e) => setEstado(e.target.value)}
            />






          </div>
        <button className='button' type="submit">Enviar</button>
      </form>
      </div>
      
    )

}

