import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom'
import { useState } from 'react';
import {DynamicForm} from './components/DynamicForm';
import { Menu } from './pages/menu';
import { ProductosPage } from './pages/productosPage';
import { ProovedoresPage } from './pages/ProveedoresPage';
import {Login} from './components/login';
import { ProveedoresForm } from './components/AltaProveedores';
import { TablaEntradasMovimientos } from './components/TablaEntradaMovimientos';
import {Inicio} from './components/Inicio'

function ProtectedRoute({ element: Component, authenticated, ...rest }) {
  return authenticated ? <Component {...rest} /> : <Navigate to="/" replace={true} />;
}
function App(){
  
  const [authenticated, setAuthenticated] = useState(false);

  const handleAuthentication = (status) => {
    setAuthenticated(status);
  };

  return (  
    <div className='app'>
      <BrowserRouter basename="/">
      <Routes>
        <Route path='/' element={<Login handleAuthentication={handleAuthentication} />}  />
        <Route
            path="/Menu"
            element={
              <ProtectedRoute
                element={Menu }
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/inicio"
            element={
              <ProtectedRoute
                element={Inicio }
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/productos"
            element={
              <ProtectedRoute
                element={ProductosPage }
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/altaproducto"
            element={
              <ProtectedRoute
                element={DynamicForm}
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/proveedores"
            element={
              <ProtectedRoute
                element={ProovedoresPage}
                authenticated={authenticated}
              />
            }
          />
          <Route
            path="/altaproveedores"
            element={
              <ProtectedRoute
                element={ProveedoresForm}
                authenticated={authenticated}
              />
            }
          />

          <Route
            path="/entradas"
            element={
              <ProtectedRoute
                element={TablaEntradasMovimientos}
                authenticated={authenticated}
              />
            }
          />

      </Routes>
      </BrowserRouter>
    </div>
     
  )
}

export default App