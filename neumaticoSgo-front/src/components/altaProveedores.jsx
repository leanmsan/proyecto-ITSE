import React from "react";
import { useState } from "react";
import "../css/form.css"
import { Sidebar } from "./Sidebar";
import { NavBar } from "./NavBar";

export function ProveedoresForm () {
    const [cuitproveedor, setCuitProveedor] = useState("");
    const [errorCuitProveedor, setErrorCuitProveedor] = useState(false);

    const [nombre, setNombre] = useState("");
    const [errorNombre, setErrorNombre] = useState(false);

    const [razonsocial, setRazonSocial] = useState("");
    const [errorRazonSocial, setErrorRazonSocial] = useState(false);

    const [direccion, setDireccion] = useState("");
    const [errorDireccion, setErrorDireccion] = useState(false);

    const [localidad, setLocalidad] = useState("");
    const [errorLocalidad, setErrorLocalidad] = useState(false);

    const [provincia, setProvincia] = useState("");
    const [errorProvincia, setErrorProvincia] = useState(false);

    const [contacto, setContacto] = useState("");
    const [errorContacto, setErrorContacto] = useState(false);

    const [estado, setEstado] = useState("");
    const [errorEstado, setErrorEstado] = useState(false);

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

            if (cuitproveedor.trim() === '') {
              setErrorCuitProveedor(true);
            }else{
              setErrorCuitProveedor(false)
            }
            
            if (nombre.trim() === '') {
              setErrorNombre(true);
            }else{
              setErrorNombre(false)
            }

            if (razonsocial.trim() === '') {
              setErrorRazonSocial(true);
            }else{
              setErrorRazonSocial(false)
            }

            if (direccion.trim() === '') {
              setErrorDireccion(true);
            }else{
              setErrorDireccion(false)
            }

            if (localidad.trim() === '') {
              setErrorLocalidad(true);
            }else{
              setErrorLocalidad(false)
            }

            if (provincia.trim() === '') {
              setErrorProvincia(true);
            }else{
              setErrorProvincia(false)
            }
            
            if (contacto.trim() === '') {
              setErrorContacto(true);
            }else{
              setErrorContacto(false)
            }

            if (estado.trim() !== 'A' && estado.trim() !== 'B') {
              setErrorEstado(true);
            }else{
              setErrorEstado(false)
            }


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
              onChange={(e) => {setCuitProveedor(e.target.value)
                setErrorCuitProveedor(false)}}
            />
            {errorCuitProveedor && <div className='error-message'>
              El cuit del proveedor es requerido</div>}
            <br />
            <label>Nombre</label>
            <input
              type='text'
              name='nombre'
              onChange={(e) => {setNombre(e.target.value)
                setErrorNombre(false)}}
            />
            {errorNombre && <div className='error-message'>El nombre es requerido</div>}
            <br />

            <label>Razón Social</label>
            <input
              type='text'
              name='razon social'
              onChange={(e) => {setRazonSocial(e.target.value)
                setErrorRazonSocial(false) }}
            />
            {errorRazonSocial && <div className='error-message'>La razón Social es requerida</div>}
            <br />

            
            <label>Dirección</label>
            <input
              type='text'
              name='direccion'
              onChange={(e) => {setDireccion(e.target.value)
                setErrorDireccion(false)}}
            />
            {errorDireccion && <div className='error-message'>La dirección es requerida</div>}
            <br />

            <label>Localidad</label>
            <input
              type='text'
              name='localidad'
              onChange={(e) => {setLocalidad(e.target.value)
                setErrorLocalidad(false)}}
            />
            {errorLocalidad && <div className='error-message'>La localidad es requerido</div>}
            <br />

            <label>Provincia</label>
            <input
              type='text'
              name='provincia'
              onChange={(e) => {setProvincia(e.target.value)
                setErrorProvincia(false) }}
            />
            {errorProvincia && <div className='error-message'>La provincia es requerido</div>}
            <br />

            <label>Contacto</label>
            <input
              type='text'
              name='contacto'
              onChange={(e) => {setContacto(e.target.value)
                setErrorContacto(false)}}
            />
            {errorContacto && <div className='error-message'>El contacto es requerido</div>}
            <br />

            <label>Estado (A o B)</label>
            <input
              type='text'
              name='contacto'
              onChange={(e) => {setEstado(e.target.value)
                setErrorEstado(false)}}
            />
            {errorEstado && <div className='error-message'>El estado ingresado es invalido o esta vacio</div>}





          </div>
        <button className='button' type="submit">Enviar</button>
      </form>
      </div>
      
    )

}

