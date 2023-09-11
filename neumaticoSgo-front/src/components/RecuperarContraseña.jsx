import React, { useState } from 'react';
import ImagenRecupCont from '../img/imagen-recupcont.png';
import LoginLogo from '../img/loginlogo.png'
import '../css/recupcont.css';

function PasswordRecovery() {
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleEmailChange = (e) => {
    setEmail(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      // Aquí deberías enviar una solicitud al servidor para recuperar la contraseña
      // Puedes usar una librería como axios o la función fetch para hacer la solicitud

      // Ejemplo de solicitud ficticia
      const response = await fetch('/api/password-recovery', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email }),
      });

      if (response.ok) {
        const data = await response.json();
        setMessage(data.message);
      } else {
        const errorData = await response.json();
        setMessage(errorData.error);
      }
    } catch (error) {
      setMessage('Ocurrió un error al procesar la solicitud.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className='recupcont-container'>
      <div className='imagen-recupcont'>
        <img className="recupcont-imagen" src={ImagenRecupCont} alt="" />
      </div>
      <div className='recuperar-contraseña'>
        <img className="login-logo" src={LoginLogo} alt="" />
        <form className='recupcont-form' onSubmit={handleSubmit}>
          <h2 className='recupcont-title'>Recuperar Contraseña</h2>
          <label className='recupcont-label'>
            Correo Electrónico
            <input type="email" value={email} onChange={handleEmailChange} required />
          </label>
          <button type="submit" disabled={isLoading}>
            {isLoading ? 'Enviando...' : 'Enviar Solicitud'}
          </button>
        </form>
        <p>{message}</p>
      </div>
    </div>
  );
}

export default PasswordRecovery;
