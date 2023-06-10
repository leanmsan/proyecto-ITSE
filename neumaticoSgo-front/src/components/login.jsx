import { useState } from "react";
import "../css/login.css"
import LoginLogo from "../img/logo.png";

export function Login() {

    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

     const handleUsernameChange = (e) => {
        setUsername(e.target.value);
    };

    const handlePasswordChange = (e) => {
        setPassword(e.target.value);
    };


    const handleSubmit = async (e) => {
        e.preventDefault();
        console.log(`Username: ${username}`);
        console.log(`Password: ${password}`);

        try {
            const response = await fetch('/api/login', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
              },
              body: JSON.stringify({ username, password }),
            });
      
            if (response.ok) {
              // Autenticación exitosa, realizar acciones necesarias (redireccionar, guardar token, etc.)
              console.log('Inicio de sesión exitoso');
            } else {
              // Autenticación fallida, mostrar mensaje de error
              const errorData = await response.json();
              setError(errorData.message);
            }
          } catch (error) {
            console.error('Error al iniciar sesión:', error);
          }
    };

    return (
        <div className="login-container">
            <img className="login-logo" src={LoginLogo} alt=""/>
            <form className="login-form" onSubmit={handleSubmit} method="post">
                <h1 className="login-title">Login</h1>
                <div className="login-label">
                    <i className="fa-solid fa-user"></i>
                    <input type="text" id="username" value={username} onChange={handleUsernameChange} required/>
                </div>
                <div className="login-label">    
                    <i className="fa-solid fa-lock"></i>
                    <input type="password" id="password" value={password} onChange={handlePasswordChange} required/>
                </div>
                <button type="Submit">Iniciar sesion</button>
            </form>
        </div>
    )
}