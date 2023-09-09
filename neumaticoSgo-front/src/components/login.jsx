import { useState } from "react";
import "../css/login.css"
// import LoginLogo from "../img/logo.png";
import LoginLogo from "../img/loginlogo.png";
import imagenlogin from '../img/imagen-login.png'
import { Navigate, useNavigate, Link } from "react-router-dom";

export function Login({ handleAuthentication }) {
  const [error, setError] = useState(null);
  const [data, setData] = useState(null);
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const navegate = useNavigate()

  const handleUsernameChange = (e) => {
    setUsername(e.target.value);
  };

  const handlePasswordChange = (e) => {
    setPassword(e.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    console.log(`username: ${username}`);
    console.log(`password: ${password}`);
    const response = await fetch('http://127.0.0.1:8000/api2/api-token-auth/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });

    if (response.ok) {
      console.log('Inicio de Sesion Exitoso')
      handleAuthentication(true)
      localStorage.setItem('authenticated', 'true');
      console.log(localStorage.setItem)
      navegate('/inicio')
    } else {
      setError(true)
    }
  };

  return (
    <div className="login-container">
      <div className="imagen-login">
        <img className="login-imagen" src={imagenlogin} alt="" />
      </div>
      <div className="login">
        <img className="login-logo" src={LoginLogo} alt="" />
        <form className="login-form" onSubmit={handleSubmit} method="post">
          <h2 className="login-title">Login</h2>
          <div className="login-label">
            <i className="fa-solid fa-user"></i>
            <input type="text" id="username" value={username} placeholder="usuario" onChange={handleUsernameChange} />
          </div>
          <div className="login-label">
            <i className="fa-solid fa-lock"></i>
            <input type="password" id="password" value={password} placeholder="contraseña" onChange={handlePasswordChange} />
            {error && <div className="error-message">Los datos ingresados no son correctos</div>}
          </div>
          <button type="Submit" >Iniciar sesion</button>
          <Link className="recuperar-contraseña" to="/recuperar-contrasena">Olvidé mi contrasena</Link>
        </form>
      </div>
    </div>
  )
}